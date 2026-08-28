import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:pic_grid/constants/purchase_ids.dart';
import 'package:pic_grid/services/ad_visibility_service.dart';

/// App-wide Google Play and App Store purchase coordinator.
///
/// It starts listening at app launch and remains alive when routes change.
class InAppPurchaseService extends ChangeNotifier with WidgetsBindingObserver {
  InAppPurchaseService._();

  static final InAppPurchaseService instance = InAppPurchaseService._();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  ProductDetails? product;
  bool isLoading = true;
  bool isStoreAvailable = false;
  String? messageKey;
  bool _initialized = false;
  bool _purchaseFlowStarted = false;
  bool _leftAppDuringPurchase = false;
  bool _isSyncingSubscription = false;
  Timer? _purchaseFallbackTimer;
  Timer? _resumeSyncTimer;

  bool get isSubscribed => AdVisibilityService.instance.isSubscribed;

  String? get productId {
    if (Platform.isAndroid) return PurchaseIds.androidAdFreeSubscription;
    if (Platform.isIOS) return PurchaseIds.iosAdFreeSubscription;
    return null;
  }

  void initialize() {
    if (_initialized) return;
    _initialized = true;
    WidgetsBinding.instance.addObserver(this);

    _purchaseSubscription = _inAppPurchase.purchaseStream.listen(
      _handlePurchaseUpdates,
      onError: (_) {
        isLoading = false;
        messageKey = 'purchaseFailed';
        notifyListeners();
      },
    );
    unawaited(loadProduct());
    unawaited(syncSubscriptionStatus());
  }

  /// Reconciles cached access with subscriptions owned by the store account.
  /// A failed query never removes cached access.
  Future<void> syncSubscriptionStatus() async {
    if ((!Platform.isAndroid && !Platform.isIOS) || _isSyncingSubscription) {
      return;
    }
    _isSyncingSubscription = true;

    try {
      final available = await _inAppPurchase.isAvailable();
      if (!available) return;

      // Google Play exposes owned purchases directly. On iOS, StoreKit sends
      // current/restored transactions through purchaseStream; the explicit
      // restore action below handles reinstalling on a different device.
      if (Platform.isIOS) return;

      final androidAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final response = await androidAddition.queryPastPurchases();
      if (response.error != null) return;

      final currentProductId = productId;
      final hasActiveSubscription = response.pastPurchases.any(
        (purchase) =>
            purchase.productID == currentProductId &&
            (purchase.status == PurchaseStatus.purchased ||
                purchase.status == PurchaseStatus.restored),
      );
      await AdVisibilityService.instance.setSubscribed(hasActiveSubscription);
      notifyListeners();
    } catch (_) {
      // Keep the cached entitlement when Google Play cannot be reached.
    } finally {
      _isSyncingSubscription = false;
    }
  }

  Future<void> loadProduct() async {
    isLoading = true;
    notifyListeners();

    final currentProductId = productId;
    if (currentProductId == null) {
      isLoading = false;
      messageKey = 'subscriptionAndroidOnly';
      notifyListeners();
      return;
    }

    try {
      isStoreAvailable = await _inAppPurchase.isAvailable();
      if (!isStoreAvailable) {
        messageKey = 'subscriptionStoreUnavailable';
        return;
      }

      final response = await _inAppPurchase.queryProductDetails({
        currentProductId,
      });
      if (response.error != null || response.productDetails.isEmpty) {
        messageKey = 'subscriptionProductUnavailable';
        return;
      }

      product = response.productDetails.first;
      messageKey = null;
    } catch (_) {
      messageKey = 'subscriptionStoreUnavailable';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> purchase() async {
    final selectedProduct = product;
    if (selectedProduct == null || isLoading) return;

    isLoading = true;
    _purchaseFlowStarted = true;
    _leftAppDuringPurchase = false;
    messageKey = null;
    notifyListeners();
    _purchaseFallbackTimer?.cancel();
    _purchaseFallbackTimer = Timer(const Duration(minutes: 2), () {
      if (_purchaseFlowStarted) {
        _finishPurchaseFlow('subscriptionPurchaseCanceled');
      }
    });
    try {
      final started = await _inAppPurchase.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: selectedProduct),
      );
      if (!started) _finishPurchaseFlow('purchaseFailed');
    } catch (_) {
      _finishPurchaseFlow('purchaseFailed');
    }
  }

  Future<void> restorePurchases() async {
    if ((!Platform.isAndroid && !Platform.isIOS) || isLoading) return;

    isLoading = true;
    messageKey = 'subscriptionRestoring';
    notifyListeners();
    try {
      await _inAppPurchase.restorePurchases();
      messageKey = 'subscriptionRestoreFinished';
    } catch (_) {
      messageKey = 'subscriptionRestoreFailed';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    final currentProductId = productId;
    for (final purchase in purchases) {
      if (purchase.productID != currentProductId) continue;

      switch (purchase.status) {
        case PurchaseStatus.pending:
          _finishPurchaseFlow('subscriptionPurchasePending');
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // TODO: Add server-side receipt verification before production.
          await AdVisibilityService.instance.setSubscribed(true);
          _finishPurchaseFlow('subscriptionPurchaseSuccess');
          break;
        case PurchaseStatus.error:
          _finishPurchaseFlow('purchaseFailed');
          break;
        case PurchaseStatus.canceled:
          _finishPurchaseFlow('subscriptionPurchaseCanceled');
          break;
      }

      if (purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchase);
      }
      notifyListeners();
    }
  }

  void _finishPurchaseFlow(String nextMessageKey) {
    _purchaseFallbackTimer?.cancel();
    _purchaseFlowStarted = false;
    _leftAppDuringPurchase = false;
    isLoading = false;
    messageKey = nextMessageKey;
    notifyListeners();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (Platform.isAndroid &&
        _purchaseFlowStarted &&
        (state == AppLifecycleState.inactive ||
            state == AppLifecycleState.paused ||
            state == AppLifecycleState.hidden)) {
      _leftAppDuringPurchase = true;
      return;
    }

    if (Platform.isAndroid &&
        state == AppLifecycleState.resumed &&
        _leftAppDuringPurchase) {
      Future<void>.delayed(const Duration(seconds: 2), () {
        if (_purchaseFlowStarted) {
          _finishPurchaseFlow('subscriptionPurchaseCanceled');
        }
      });
    }

    if (state == AppLifecycleState.resumed) {
      _resumeSyncTimer?.cancel();
      _resumeSyncTimer = Timer(
        Duration(seconds: _purchaseFlowStarted ? 4 : 1),
        () => unawaited(syncSubscriptionStatus()),
      );
    }
  }

  @visibleForTesting
  Future<void> disposeService() async {
    WidgetsBinding.instance.removeObserver(this);
    _purchaseFallbackTimer?.cancel();
    _resumeSyncTimer?.cancel();
    await _purchaseSubscription?.cancel();
    _purchaseSubscription = null;
    _initialized = false;
  }
}

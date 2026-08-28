import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pic_grid/routes/routes.dart';
import 'package:pic_grid/services/in_app_purchase_service.dart';

class SubscriptionViewController extends GetxController {
  final isSubscribed = false.obs;
  final isLoading = true.obs;
  final isStoreAvailable = false.obs;
  final product = Rxn<ProductDetails>();
  final messageKey = RxnString();

  final InAppPurchaseService _purchaseService = InAppPurchaseService.instance;

  @override
  void onInit() {
    super.onInit();
    _purchaseService.addListener(_syncState);
    _syncState();
  }

  void _syncState() {
    isSubscribed.value = _purchaseService.isSubscribed;
    isLoading.value = _purchaseService.isLoading;
    isStoreAvailable.value = _purchaseService.isStoreAvailable;
    product.value = _purchaseService.product;
    messageKey.value = _purchaseService.messageKey;
  }

  void openPrivacyAndTerms() => Get.toNamed(Routes.privacyPolicyView);

  Future<void> subscribe() => _purchaseService.purchase();

  Future<void> restorePurchases() => _purchaseService.restorePurchases();

  @override
  void onClose() {
    _purchaseService.removeListener(_syncState);
    super.onClose();
  }
}

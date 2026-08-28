import 'package:flutter/foundation.dart';
import 'package:pic_grid/sharedpreference/sharedpreferences.dart';

/// Holds the locally cached subscription entitlement.
class AdVisibilityService extends ValueNotifier<bool> {
  AdVisibilityService._() : super(false);

  static final AdVisibilityService instance = AdVisibilityService._();

  bool get isSubscribed => value;

  Future<void> initialize() async {
    value = await SharedPreference.loadSubscriptionStatus();
  }

  /// Call after a purchase or restored entitlement has been verified.
  Future<void> setSubscribed(bool isSubscribed) async {
    await SharedPreference.saveSubscriptionStatus(isSubscribed);
    value = isSubscribed;
  }
}

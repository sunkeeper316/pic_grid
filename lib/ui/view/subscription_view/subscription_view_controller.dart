import 'package:get/get.dart';
import 'package:pic_grid/routes/routes.dart';
import 'package:pic_grid/services/ad_visibility_service.dart';

class SubscriptionViewController extends GetxController {
  final isSubscribed = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    isSubscribed.value = AdVisibilityService.instance.isSubscribed;
  }

  void openPrivacyAndTerms() => Get.toNamed(Routes.privacyPolicyView);

  void subscribe() {
    // TODO: Query the configured store product and start the purchase flow.
  }

  void restorePurchases() {
    // TODO: Restore purchases after the store listener and product ID are configured.
  }
}

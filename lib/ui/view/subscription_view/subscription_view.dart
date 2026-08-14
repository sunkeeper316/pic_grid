import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/resource/values/app_colors.dart';
import 'package:pic_grid/ui/view/subscription_view/subscription_view_controller.dart';

class SubscriptionView extends GetView<SubscriptionViewController> {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.darkGary,
      appBar: AppBar(
        backgroundColor: AppColors.darkGary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(strings.subscriptionTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                color: Colors.amber,
                size: 72,
              ),
              const SizedBox(height: 16),
              Text(
                strings.subscriptionHeadline,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                strings.subscriptionDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 28),
              _Benefit(
                icon: Icons.block,
                text: strings.subscriptionBenefitNoAds,
              ),
              _Benefit(
                icon: Icons.touch_app_outlined,
                text: strings.subscriptionBenefitUninterrupted,
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white12),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        controller.isSubscribed.value
                            ? strings.subscriptionActive
                            : controller.product.value?.title ??
                                  strings.subscriptionPlanPreparing,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (!controller.isSubscribed.value &&
                          controller.product.value != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          controller.product.value!.price,
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      if (controller.messageKey.value != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          _message(strings, controller.messageKey.value!),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed:
                            controller.isSubscribed.value ||
                                controller.isLoading.value ||
                                controller.product.value == null
                            ? null
                            : controller.subscribe,
                        child: controller.isLoading.value
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(strings.subscriptionButton),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => TextButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.restorePurchases,
                  child: Text(strings.subscriptionRestore),
                ),
              ),
              TextButton(
                onPressed: controller.openPrivacyAndTerms,
                child: Text(strings.settingPrivacyPolicyAndTerms),
              ),
              const SizedBox(height: 8),
              Text(
                strings.subscriptionRenewalNotice,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _message(S strings, String key) => switch (key) {
    'subscriptionAndroidOnly' => strings.subscriptionAndroidOnly,
    'subscriptionStoreUnavailable' => strings.subscriptionStoreUnavailable,
    'subscriptionProductUnavailable' => strings.subscriptionProductUnavailable,
    'subscriptionRestoring' => strings.subscriptionRestoring,
    'subscriptionRestoreFinished' => strings.subscriptionRestoreFinished,
    'subscriptionRestoreFailed' => strings.subscriptionRestoreFailed,
    'subscriptionPurchasePending' => strings.subscriptionPurchasePending,
    'subscriptionPurchaseSuccess' => strings.subscriptionPurchaseSuccess,
    'subscriptionPurchaseCanceled' => strings.subscriptionPurchaseCanceled,
    _ => strings.purchaseFailed,
  };
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, color: Colors.greenAccent),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

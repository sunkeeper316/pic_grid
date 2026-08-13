import 'package:get/get.dart';
import 'package:pic_grid/routes/routes.dart';

import 'package:pic_grid/ui/view/home/home_view.dart';
import 'package:pic_grid/ui/view/home/home_view_binding.dart';
import 'package:pic_grid/ui/view/setting/setting_view.dart';
import 'package:pic_grid/ui/view/setting/setting_view_binding.dart';
import 'package:pic_grid/ui/view/start/start_view.dart';
import 'package:pic_grid/ui/view/start/start_view_binding.dart';
import 'package:pic_grid/ui/view/subscription_view/subscription_view.dart';
import 'package:pic_grid/ui/view/subscription_view/subscription_view_binding.dart';
import 'package:pic_grid/ui/view/web_view/privacy_policy_view/privacy_policy_view.dart';
import 'package:pic_grid/ui/view/web_view/privacy_policy_view/privacy_policy_view_binding.dart';
import 'package:pic_grid/ui/view/grid_collage/grid_collage_view.dart';
import 'package:pic_grid/ui/view/grid_collage/grid_collage_view_binding.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.startView,
      page: () => const StartView(),
      binding: StartViewBinding(),
    ),
    GetPage(
      name: Routes.homeView,
      page: () => const HomeView(),
      binding: HomeViewBinding(),
    ),

    GetPage(
      name: Routes.settingView,
      page: () => const SettingView(),
      binding: SettingViewBinding(),
    ),
    GetPage(
      name: Routes.privacyPolicyView,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyViewBinding(),
    ),
    GetPage(
      name: Routes.gridCollageView,
      page: () => const GridCollageView(),
      binding: GridCollageViewBinding(),
    ),
    GetPage(
      name: Routes.subscriptionView,
      page: () => const SubscriptionView(),
      binding: SubscriptionViewBinding(),
    ),
  ];

  // static Route? onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case Routes.community:
  //       return GetPageRoute(
  //         settings: settings,
  //         page: () => CommunityView(),
  //         binding: CommunityViewBinding(),
  //       );
  //     case Routes.trade:
  //       return GetPageRoute(
  //         settings: settings,
  //         page: () => const TradeView(),
  //         binding: TradeViewBinding(),
  //       );
  //     case Routes.meetup:
  //       return GetPageRoute(
  //         settings: settings,
  //         page: () => MeetupView(),
  //         binding: MeetupViewBinding(),
  //       );
  //     case Routes.message:
  //       return GetPageRoute(
  //         settings: settings,
  //         page: () => MessageView(),
  //         binding: MessageViewBinding(),
  //       );
  //     case Routes.setting:
  //       return GetPageRoute(
  //         settings: settings,
  //         page: () => SettingView(),
  //         binding: SettingViewBinding(),
  //       );
  //   }

  //   return null;
  // }
}

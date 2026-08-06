import 'package:get/get.dart';
import 'package:pic_grid/routes/routes.dart';
import 'package:pic_grid/ui/weiget/mixins/loading_mixin.dart';
import 'package:pic_grid/ui/view/photo_picker/photo_picker_view.dart';

class HomeViewController extends GetxController with LoadingMixin {
  // final languageService = Get.find<LanguageService>();
  var message = ''.obs;

  void checkFirstAndLogin() async {}

  Future<void> pickImages() async {
    final context = Get.context;
    if (context == null) return;
    final images = await PhotoPickerView.pick(context);

    if (images.isEmpty) return;

    await Get.toNamed(Routes.gridCollageView, arguments: images);
  }

  @override
  void onInit() async {
    super.onInit();
    // CacheImageManager.initialize(days: 7);
    await executeWithLoading(() async {
      // await languageService.init();
      await Future.delayed(const Duration(seconds: 1));
      // if (code != null){
      //   if (code == ErrorConstants.errAppVersionOutdated) {
      //     //版本更新
      //   }else if (await TokenManager.instance.getToken() == null) {
      //     // Get.offAllNamed(Routes.loginView);
      //   }else{
      //     await userController.getUserAndNavigate();
      //   }
      // }else{
      //   if (systemConfigController.responseData == null) {
      //     Get.offAllNamed(Routes.errorView);
      //   }
      // }
    });
  }
}

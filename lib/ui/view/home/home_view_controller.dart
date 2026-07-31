
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pic_grid/routes/routes.dart';
import 'package:pic_grid/ui/weiget/mixins/loading_mixin.dart';
import 'package:pic_grid/utils/image_upload_utils.dart';

class HomeViewController extends GetxController with LoadingMixin {

  // final languageService = Get.find<LanguageService>();
  var message = ''.obs;

  void checkFirstAndLogin() async {

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
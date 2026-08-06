import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pic_grid/routes/routes.dart';
import 'package:pic_grid/ui/weiget/mixins/loading_mixin.dart';

class HomeViewController extends GetxController with LoadingMixin {
  final ImagePicker _picker = ImagePicker();

  // final languageService = Get.find<LanguageService>();
  var message = ''.obs;

  void checkFirstAndLogin() async {}

  Future<void> pickImages() async {
    final images = await _picker.pickMultiImage(limit: 12);

    if (images.isEmpty) return;

    if (images.length < 2) {
      Get.snackbar('Error', 'Please select at least 2 photos.');
      return;
    }

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

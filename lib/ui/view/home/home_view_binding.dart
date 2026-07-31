
import 'package:get/get.dart';
import 'package:pic_grid/ui/view/home/home_view_controller.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewController());
  }
}
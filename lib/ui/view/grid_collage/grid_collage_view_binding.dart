import 'package:get/get.dart';
import 'package:pic_grid/ui/view/grid_collage/grid_collage_view_controller.dart';

class GridCollageViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GridCollageViewController>(() => GridCollageViewController());
  }
}

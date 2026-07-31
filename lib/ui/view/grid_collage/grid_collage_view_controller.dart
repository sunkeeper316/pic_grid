import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GridCollageViewController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  
  var selectedImages = <XFile>[].obs;
  
  // Example state for grid layout proportions
  var rowProportions = <double>[].obs;
  var colProportions = <double>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      if (images.length > 12) {
        selectedImages.value = images.sublist(0, 12);
      } else if (images.length < 2) {
        // Need at least 2
        Get.snackbar("Error", "Please select at least 2 photos.");
        return;
      } else {
        selectedImages.value = images;
      }
      _initializeProportions();
    }
  }

  void _initializeProportions() {
    int count = selectedImages.length;
    int rows = 1;
    int cols = 1;
    
    // Simple heuristic for rows and cols
    if (count <= 2) { rows = 1; cols = 2; }
    else if (count <= 4) { rows = 2; cols = 2; }
    else if (count <= 6) { rows = 2; cols = 3; }
    else if (count <= 9) { rows = 3; cols = 3; }
    else { rows = 4; cols = 3; } // up to 12

    rowProportions.value = List.generate(rows, (index) => 1.0 / rows);
    colProportions.value = List.generate(cols, (index) => 1.0 / cols);
  }
  
  void updateRowProportion(int index, double delta) {
    if (index >= rowProportions.length - 1) return;
    double newProp = rowProportions[index] + delta;
    double newNextProp = rowProportions[index + 1] - delta;
    if (newProp > 0.1 && newNextProp > 0.1) {
      rowProportions[index] = newProp;
      rowProportions[index + 1] = newNextProp;
      rowProportions.refresh();
    }
  }

  void updateColProportion(int index, double delta) {
    if (index >= colProportions.length - 1) return;
    double newProp = colProportions[index] + delta;
    double newNextProp = colProportions[index + 1] - delta;
    if (newProp > 0.1 && newNextProp > 0.1) {
      colProportions[index] = newProp;
      colProportions[index + 1] = newNextProp;
      colProportions.refresh();
    }
  }
}

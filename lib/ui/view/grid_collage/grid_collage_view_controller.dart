import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pic_grid/generated/l10n.dart';
import 'package:pic_grid/services/review_prompt_service.dart';
import 'package:pic_grid/ui/view/photo_picker/photo_picker_view.dart';

enum MainPhotoPosition { left, right, top, bottom }

class GridCollageViewController extends GetxController {
  final GlobalKey repaintKey = GlobalKey();

  var selectedImages = <XFile>[].obs;
  var isSaving = false.obs;
  var borderWidth = 0.0.obs;
  var borderColor = Colors.white.obs;
  var mainPhotoPosition = MainPhotoPosition.left.obs;
  var evenLayoutByColumns = true.obs;
  var cropRevision = 0.obs;

  // Example state for grid layout proportions
  var rowProportions = <double>[].obs;
  var colProportions = <double>[].obs;
  var localProportions = <List<double>>[].obs;

  bool get usesMainPhotoLayout =>
      selectedImages.length.isOdd && selectedImages.length != 9;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is List<XFile> && arguments.length >= 2) {
      selectedImages.assignAll(arguments.take(12));
      _initializeProportions();
    }
  }

  Future<void> pickImages() async {
    final context = Get.context;
    if (context == null) return;
    final List<XFile> images = await PhotoPickerView.pick(context);
    if (images.isNotEmpty) {
      selectedImages.value = images;
      _initializeProportions();
    }
  }

  Future<void> saveImage() async {
    if (isSaving.value || selectedImages.isEmpty) return;

    try {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          Get.snackbar(
            S.current.permissionError,
            S.current.albumPermissionRequired,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
      }

      // Hide the draggable splitters before capturing the collage.
      isSaving.value = true;
      await WidgetsBinding.instance.endOfFrame;

      final boundary = repaintKey.currentContext?.findRenderObject();
      if (boundary is! RenderRepaintBoundary) {
        throw StateError('Collage canvas is not ready.');
      }

      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      if (byteData == null) {
        throw StateError('Unable to create image data.');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      await Gal.putImageBytes(
        pngBytes,
        name: 'pic_grid_${DateTime.now().millisecondsSinceEpoch}',
      );
      Get.snackbar(
        S.current.success,
        S.current.imageSavedToAlbum,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      await ReviewPromptService.recordSuccessfulOperation();
    } catch (error) {
      Get.snackbar(
        S.current.error,
        S.current.saveFailed(error.toString()),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSaving.value = false;
    }
  }

  void _initializeProportions() {
    cropRevision.value++;
    int count = selectedImages.length;
    int rows = 1;
    int cols = 1;

    if (count == 9) {
      rows = 3;
      cols = 3;
    } else if (count.isOdd) {
      // The first photo spans the full left side. The remaining photos fill
      // one column for 3 photos, or two columns for 5–11 photos.
      rows = count == 3 ? 2 : (count - 1) ~/ 2;
      cols = count == 3 ? 2 : 3;
    } else if (count == 2) {
      rows = 1;
      cols = 2;
    } else if (count == 4) {
      rows = 2;
      cols = 2;
    } else if (count == 6) {
      rows = 2;
      cols = 3;
    } else if (count == 8) {
      rows = 4;
      cols = 2;
    } else if (count == 10) {
      rows = 5;
      cols = 2;
    } else {
      rows = 4;
      cols = 3;
    }

    rowProportions.value = List.generate(rows, (index) => 1.0 / rows);
    colProportions.value = List.generate(cols, (index) => 1.0 / cols);
    final trackCount = usesMainPhotoLayout ? cols - 1 : cols;
    localProportions.assignAll(
      List.generate(trackCount, (_) => List.generate(rows, (_) => 1.0 / rows)),
    );
    mainPhotoPosition.value = MainPhotoPosition.left;
    evenLayoutByColumns.value = true;
  }

  void toggleLayout() {
    if (!usesMainPhotoLayout) {
      _transposeGrid();
      evenLayoutByColumns.toggle();
      return;
    }

    final next = switch (mainPhotoPosition.value) {
      MainPhotoPosition.left => MainPhotoPosition.top,
      MainPhotoPosition.top => MainPhotoPosition.right,
      MainPhotoPosition.right => MainPhotoPosition.bottom,
      MainPhotoPosition.bottom => MainPhotoPosition.left,
    };
    setMainPhotoPosition(next);
  }

  void setMainPhotoPosition(MainPhotoPosition position) {
    final currentIsSide = _isSide(mainPhotoPosition.value);
    final nextIsSide = _isSide(position);
    if (currentIsSide != nextIsSide) {
      _transposeGrid();
    }
    mainPhotoPosition.value = position;
  }

  bool _isSide(MainPhotoPosition position) {
    return position == MainPhotoPosition.left ||
        position == MainPhotoPosition.right;
  }

  void _transposeGrid() {
    final previousRows = rowProportions.toList();
    final previousColumns = colProportions.toList();
    rowProportions.assignAll(previousColumns);
    colProportions.assignAll(previousRows);
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

  void updateLocalProportion(int track, int index, double delta) {
    if (track < 0 || track >= localProportions.length) return;
    final proportions = List<double>.of(localProportions[track]);
    if (index < 0 || index >= proportions.length - 1) return;

    final current = proportions[index] + delta;
    final next = proportions[index + 1] - delta;
    if (current > 0.1 && next > 0.1) {
      proportions[index] = current;
      proportions[index + 1] = next;
      localProportions[track] = proportions;
      localProportions.refresh();
    }
  }

  void setBorderWidth(double width) {
    borderWidth.value = width;
  }

  void setBorderColor(Color color) {
    borderColor.value = color;
    if (borderWidth.value == 0) {
      borderWidth.value = 2;
    }
  }
}

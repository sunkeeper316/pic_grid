

import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';

class OverlayItem {
  String id;
  File file;
  var position = Offset.zero.obs;
  var scale = 1.0.obs;
  var rotation = 0.0.obs;

  // 手勢開始時的暫存值（非 observable）
  double gestureStartScale = 1.0;
  double gestureStartRotation = 0.0;

  OverlayItem({
    required this.id,
    required this.file,
    Offset initialPosition = Offset.zero,
    double initialScale = 1.0,
    double initialRotation = 0.0,
  }) {
    position.value = initialPosition;
    scale.value = initialScale;
    rotation.value = initialRotation;
  }
}
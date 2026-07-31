import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ImageUploadUtils {
  static final ImagePicker _picker = ImagePicker();

  /// 選擇圖片（相機或相簿），並自動壓縮，回傳 File 物件
  static Future<File?> pickImage({
    required ImageSource source,
  }) async {
    // 不傳 imageQuality，避免 image_picker 自動將 PNG 重新編碼成 JPEG（會失去 alpha）
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      try {
        final XFile? compressed = await _compressImageIfNeeded(pickedFile);
        return File((compressed ?? pickedFile).path);
      } catch (e) {
        debugPrint("處理圖片失敗${e.toString()}");
        Get.snackbar("處理圖片失敗", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
        return null;
      }
    }
    return null;
  }

  static bool _isPng(String path) => path.toLowerCase().endsWith('.png');

  static Future<XFile?> _compressImageIfNeeded(XFile file) async {
    try {
      final decodedImage = await decodeImageFromList(await file.readAsBytes());

      final int width = decodedImage.width;
      final int height = decodedImage.height;

      debugPrint('✅✅原圖片 width $width height $height');
      if (width <= 1024 && height <= 1024) {
        return file;
      }

      final double ratio = width > height ? 1024 / width : 1024 / height;
      final int newWidth = (width * ratio).round();
      final int newHeight = (height * ratio).round();
      debugPrint('✅✅✅ 壓縮圖片後 width $newWidth height $newHeight');
      final tempDir = await getTemporaryDirectory();

      // PNG 保留透明通道，其他格式才用 JPEG 壓縮
      final bool keepAlpha = _isPng(file.path);
      final String ext = keepAlpha ? 'png' : 'jpg';
      final CompressFormat format =
          keepAlpha ? CompressFormat.png : CompressFormat.jpeg;

      final String targetPath = join(
        tempDir.path,
        '${DateTime.now().millisecondsSinceEpoch}_compressed.$ext',
      );

      final XFile? compressed = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        minWidth: newWidth,
        minHeight: newHeight,
        quality: keepAlpha ? 100 : 85,
        format: format,
      );

      return compressed;
    } catch (e) {
      debugPrint("❌ 圖片壓縮失敗: $e");
      return null;
    }
  }


  /// 使用原生 ImagePicker 選擇單張圖片（相簿），並自動壓縮
  static Future<XFile?> pickSingleImageNative({ImageSource source = ImageSource.gallery}) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked == null) return null;

    final compressed = await _compressImageIfNeeded(picked);
    return compressed ?? picked;
  }

  /// 使用原生 ImagePicker 選擇圖片（支援單選或多選）
  /// 如果 maxCount > 1 且 source 為 gallery，使用 pickMultiImage；否則使用 pickImage
  static Future<List<XFile>> pickNativeImages({
    int maxCount = 1,
    ImageSource source = ImageSource.gallery,
  }) async {
    List<XFile> pickedFiles = [];

    if (maxCount > 1 && source == ImageSource.gallery) {
      // 多選只支援 Gallery
      final List<XFile> multiPicked = await _picker.pickMultiImage();
      if (multiPicked.isNotEmpty) {
        pickedFiles = multiPicked.length > maxCount
            ? multiPicked.sublist(0, maxCount)
            : multiPicked;
      }
    } else {
      final XFile? picked = await _picker.pickImage(source: source);
      if (picked != null) {
        pickedFiles = [picked];
      }
    }

    // 壓縮處理
    final List<XFile> result = [];
    for (final file in pickedFiles) {
      final compressed = await _compressImageIfNeeded(file);
      if (compressed != null) {
        result.add(compressed);
      }
    }

    return result;
  }
}

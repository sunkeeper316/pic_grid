import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoadingMixin {
  final RxBool runActivityIndicator = false.obs;

  void startLoading() {
    runActivityIndicator.value = true;
  }

  void stopLoading() {
    runActivityIndicator.value = false;
  }

  Widget buildLoadingIndicator() {
    return Obx(() {
      return Visibility(
        visible: runActivityIndicator.value,
        child: Center(
          // child:
          // Image.asset(
          //   'assets/loading.gif',
          //   width: 80,
          //   height: 80,
          // ),
        ),
      );
    });
  }

  Future<void> executeWithLoading(
      Future<void> Function() action, {
        void Function(dynamic error)? onError,
      }) async {
    if (runActivityIndicator.value) return; // 避免重複執行
    startLoading(); // 開始加載
    try {
      await action(); // 執行異步操作
    } catch (error) {
      // 捕捉錯誤並調用回調
      if (onError != null) {
        onError(error); // 傳遞錯誤給外部
      } else {
        // 預設錯誤處理（例如打印日誌）
        print("❌❌❌ Error occurred: $error");
      }
    } finally {
      stopLoading(); // 結束加載
    }
  }

}

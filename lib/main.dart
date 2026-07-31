import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pic_grid/config/environment.dart';

import 'pic_grid_app.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp, // 竖屏 Portrait 模式
      DeviceOrientation.portraitDown,
      //DeviceOrientation.landscapeLeft, // 横屏 Landscape 模式
      // DeviceOrientation.landscapeRight,
    ],
  );

  /// 初始化Firebase服務
  // await Firebase.initializeApp();
  Environment().initConfig(BuildFlavor.local);
  // await PackageInfoHelper().initPackageInfo();
  runApp(const PicGridApp());
}



import 'package:pic_grid/config/dev_config.dart';
import 'package:pic_grid/config/local_config.dart';

import 'base_config.dart';
import 'prod_config.dart';

enum BuildFlavor { production, development , local}

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  late BaseConfig config;
  late BuildFlavor flavor = BuildFlavor.development;

  initConfig(BuildFlavor buildFlavor) {
    config = _getConfig(buildFlavor);
  }

  BaseConfig _getConfig(BuildFlavor buildFlavor) {
    flavor = buildFlavor;
    switch (buildFlavor) {
      case BuildFlavor.production:
        return ProdConfig();
      case BuildFlavor.local:
        return LocalConfig();
      default:
        return DevConfig();
    }
  }
}

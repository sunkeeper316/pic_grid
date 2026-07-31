
import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get environmentName => 'hello prod';

  @override
  // TODO: implement rootApi
  String get rootApi => 'https://www.taigun.sbs/api/v1/';

  @override
  // TODO: implement rootImageUrl
  String get rootImageUrl => 'https://www.taigun.sbs/';

  @override
  // TODO: implement pusherAppKey
  String get pusherAppKey => '';

  @override
  // TODO: implement pusherCluster
  String get pusherCluster => 'ap1';

  @override
  // TODO: implement googleMapApiKey
  String get googleMapApiKey => '';

  @override
  String get socketUrl => 'wss://www.taigun.sbs/api/v1/ws';
}

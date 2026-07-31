
import 'base_config.dart';

class LocalConfig implements BaseConfig {
  @override
  String get environmentName => 'hello Local';

  @override
  // TODO: implement rootApi
  String get rootApi => 'http://192.168.40.218:8080/api/v1/';

  @override
  // TODO: implement rootImageUrl
  String get rootImageUrl => 'http://192.168.40.218:8080/';

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
  String get socketUrl => 'ws://192.168.40.218:8080/api/v1/ws';
}

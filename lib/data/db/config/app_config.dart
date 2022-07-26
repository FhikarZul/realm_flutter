import 'package:realm/realm.dart';

//app id dari atlas mongo db
const appId = 'belajarmongo-enfwb';

//app config
class AppConfig {
  AppConfiguration appConfiguration = AppConfiguration(
    appId,
    defaultRequestTimeout: const Duration(seconds: 120),
    localAppVersion: '2.0',
  );
}

import 'package:realm/realm.dart';

const appId = 'belajarmongo-enfwb';

class Config {
  AppConfiguration appConfiguration = AppConfiguration(
    appId,
    defaultRequestTimeout: const Duration(seconds: 120),
    localAppVersion: '2.0',
  );
}

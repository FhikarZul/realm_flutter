import 'package:realm/realm.dart';
import 'package:realm_flutter/data/db/local/dao/car.dart';
import 'package:realm_flutter/data/db/local/dao/garage.dart';
import 'package:realm_flutter/data/db/local/dao/owner.dart';
import 'package:realm_flutter/data/db/remote/config.dart';

class RemoteDatSource {
  final config = Config();
  final anonCredentials = Credentials.anonymous();

  Future<User?> isLogin() async {
    try {
      final app = App(config.appConfiguration);
      User user = await app.logIn(anonCredentials);
      print('is login');

      return user;
    } catch (e) {
      print('is error: ${e.toString()}');
    }
    return null;
  }

  Future<String> logout() async {
    try {
      final app = App(config.appConfiguration);
      User user = await app.logIn(anonCredentials);

      await user.logOut();
    } catch (e) {
      return e.toString();
    }
    return 'isLogout';
  }

  Future<String> synced({required User userLogin}) async {
    try {
      final configuration = Configuration.flexibleSync(
        userLogin,
        [Owner.schema, Car.schema, Garage.schema],
      );

      final realm = Realm(configuration);
      print(realm.syncSession.realmPath);
      realm.close();
    } catch (e) {
      return 'Error sync: ${e.toString()}';
    }

    return 'sync success';
  }
}

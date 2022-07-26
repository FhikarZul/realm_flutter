import 'package:realm/realm.dart';
import 'package:realm_flutter/data/db/local/dao/car.dart';
import 'package:realm_flutter/data/db/local/dao/garage.dart';
import 'package:realm_flutter/data/db/local/dao/owner.dart';

import 'app_config.dart';

class Synchronization {
  //instance dari app config
  final appConfig = AppConfig();
  //tipe autentikasi ayng digunakan
  final anonCredentials = Credentials.anonymous();

  //autentikasi dan mengambil user yang login
  Future<User?> isLogin() async {
    try {
      final app = App(appConfig.appConfiguration);
      User user = await app.logIn(anonCredentials);

      print(user.id);
      return user;
    } catch (e) {
      print('is error: ${e.toString()}');
      return null;
    }
  }

  //fungsi logout
  Future<String> logout() async {
    try {
      final app = App(appConfig.appConfiguration);
      final realm = await getRealmInstance();

      User user = await app.logIn(anonCredentials);
      realm.close();
      await user.logOut();
    } catch (e) {
      return e.toString();
    }
    return 'isLogout';
  }

  //instansi realm dan configurasi type database [flexible SYNC]
  Future<Realm> getRealmInstance() async {
    final user = await isLogin();

    final configuration = Configuration.flexibleSync(
      user!,
      [Owner.schema, Car.schema, Garage.schema],
    );

    return Realm(configuration);
  }

  //fungsi untuk melakukakn sinkronisasi
  Future<void> synced(RealmResults query, {required String name}) async {
    try {
      final realm = await getRealmInstance();

      //pengecekan apakah terdapat data yang sama dari server
      realm.subscriptions.update((mutableSubscriptions) {
        if (mutableSubscriptions.any((element) => element.name == name)) {
          return;
        }
        mutableSubscriptions.add(query, name: name);
      });
      await realm.subscriptions.waitForSynchronization();
      print(realm.syncSession.connectionState);
    } catch (e) {
      print('Realm: ${e}');
    }
  }
}

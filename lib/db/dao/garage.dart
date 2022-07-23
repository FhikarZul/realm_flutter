import 'package:realm/realm.dart';

part 'garage.g.dart';

@RealmModel()
class _Garage {
  @PrimaryKey()
  late final String id;

  late String idCar;
  late String idOwner;
}

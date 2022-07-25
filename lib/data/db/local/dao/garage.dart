import 'package:realm/realm.dart';

part 'garage.g.dart';

@RealmModel()
@MapTo('garage')
class _Garage {
  @PrimaryKey()
  @MapTo('_id')
  late final String id;

  @MapTo('id_car')
  late String idCar;
  @MapTo('id_owner')
  late String idOwner;
}

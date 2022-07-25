import 'package:realm/realm.dart';

part 'car.g.dart';

@RealmModel()
@MapTo('car')
class _Car {
  @PrimaryKey()
  @MapTo('_id')
  late final String id;

  @MapTo('name')
  late String name;
  @MapTo('model')
  late String model;
}

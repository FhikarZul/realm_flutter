import 'package:realm/realm.dart';

part 'car.g.dart';

@RealmModel()
class _Car {
  @PrimaryKey()
  late final String id;

  late String name;
  late String model;
}

import 'package:realm/realm.dart';

part 'owner.g.dart';

@RealmModel()
class _Owner {
  @PrimaryKey()
  late final String id;

  late String name;
}

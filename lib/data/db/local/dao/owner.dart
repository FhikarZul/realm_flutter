import 'package:realm/realm.dart';

part 'owner.g.dart';

@RealmModel()
@MapTo('owner')
class _Owner {
  @PrimaryKey()
  @MapTo('_id')
  late final String id;

  @MapTo('name')
  late String name;
}

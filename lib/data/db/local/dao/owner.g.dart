// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Owner extends _Owner with RealmEntity, RealmObject {
  Owner(
    String id,
    String name,
  ) {
    RealmObject.set(this, '_id', id);
    RealmObject.set(this, 'name', name);
  }

  Owner._();

  @override
  String get id => RealmObject.get<String>(this, '_id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<Owner>> get changes =>
      RealmObject.getChanges<Owner>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Owner._);
    return const SchemaObject(Owner, 'owner', [
      SchemaProperty('_id', RealmPropertyType.string,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

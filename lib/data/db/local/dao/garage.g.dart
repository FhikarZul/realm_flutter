// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garage.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Garage extends _Garage with RealmEntity, RealmObject {
  Garage(
    String id,
    String idCar,
    String idOwner,
  ) {
    RealmObject.set(this, '_id', id);
    RealmObject.set(this, 'id_car', idCar);
    RealmObject.set(this, 'id_owner', idOwner);
  }

  Garage._();

  @override
  String get id => RealmObject.get<String>(this, '_id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get idCar => RealmObject.get<String>(this, 'id_car') as String;
  @override
  set idCar(String value) => RealmObject.set(this, 'id_car', value);

  @override
  String get idOwner => RealmObject.get<String>(this, 'id_owner') as String;
  @override
  set idOwner(String value) => RealmObject.set(this, 'id_owner', value);

  @override
  Stream<RealmObjectChanges<Garage>> get changes =>
      RealmObject.getChanges<Garage>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Garage._);
    return const SchemaObject(Garage, 'garage', [
      SchemaProperty('_id', RealmPropertyType.string,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('id_car', RealmPropertyType.string, mapTo: 'id_car'),
      SchemaProperty('id_owner', RealmPropertyType.string, mapTo: 'id_owner'),
    ]);
  }
}

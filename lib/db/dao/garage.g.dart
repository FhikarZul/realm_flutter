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
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'idCar', idCar);
    RealmObject.set(this, 'idOwner', idOwner);
  }

  Garage._();

  @override
  String get id => RealmObject.get<String>(this, 'id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get idCar => RealmObject.get<String>(this, 'idCar') as String;
  @override
  set idCar(String value) => RealmObject.set(this, 'idCar', value);

  @override
  String get idOwner => RealmObject.get<String>(this, 'idOwner') as String;
  @override
  set idOwner(String value) => RealmObject.set(this, 'idOwner', value);

  @override
  Stream<RealmObjectChanges<Garage>> get changes =>
      RealmObject.getChanges<Garage>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Garage._);
    return const SchemaObject(Garage, 'Garage', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('idCar', RealmPropertyType.string),
      SchemaProperty('idOwner', RealmPropertyType.string),
    ]);
  }
}

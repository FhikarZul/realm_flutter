// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Car extends _Car with RealmEntity, RealmObject {
  Car(
    String id,
    String name,
    String model,
  ) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'model', model);
  }

  Car._();

  @override
  String get id => RealmObject.get<String>(this, 'id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  String get model => RealmObject.get<String>(this, 'model') as String;
  @override
  set model(String value) => RealmObject.set(this, 'model', value);

  @override
  Stream<RealmObjectChanges<Car>> get changes =>
      RealmObject.getChanges<Car>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Car._);
    return const SchemaObject(Car, 'Car', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('model', RealmPropertyType.string),
    ]);
  }
}

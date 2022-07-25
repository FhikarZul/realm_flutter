import 'dart:math';

import 'package:realm/realm.dart';
import 'package:realm_flutter/model/car_model.dart';
import 'package:realm_flutter/model/car_with_owner_model.dart';
import 'package:realm_flutter/model/owner_model.dart';

import 'dao/car.dart';
import 'dao/garage.dart';
import 'dao/owner.dart';

final configOwner = Configuration.local([Owner.schema], schemaVersion: 2);
final configCar = Configuration.local([Car.schema], schemaVersion: 2);
final configGarage = Configuration.local([Garage.schema], schemaVersion: 2);

class LocalDataSource {
  final realmOwner = Realm(configOwner);
  final realmCar = Realm(configCar);
  final realmGarage = Realm(configGarage);

  Future<String> insertNewOwner({required OwnerModel ownerModel}) async {
    final owner = Owner(
      ownerModel.id,
      ownerModel.name,
    );

    realmOwner.write(() => realmOwner.add(owner));

    return 'Insert is success.';
  }

  Future<String> insertToGarage({
    required String idCar,
    required String idOwner,
  }) async {
    final random = Random();
    final id = random.nextInt(9999);

    final garage = Garage(
      id.toString(),
      idCar,
      idOwner,
    );

    realmGarage.write(() => realmGarage.add(garage));

    return 'Insert is success';
  }

  Future<String> insertNewCar({required CarModel carModel}) async {
    final car = Car(
      carModel.id,
      carModel.name,
      carModel.model,
    );

    realmCar.write(() => realmCar.add(car));

    return 'Insert is success';
  }

  Future<List<CarModel>> getAllCars() async {
    final result = realmCar.all<Car>();

    return result
        .map((e) => CarModel(
              id: e.id,
              name: e.name,
              model: e.model,
            ))
        .toList();
  }

  Future<List<OwnerModel>> getAllOwners() async {
    final result = realmOwner.all<Owner>();

    return result
        .map((e) => OwnerModel(
              id: e.id,
              name: e.name,
            ))
        .toList();
  }

  Future<Map<String, CarWithOwnerModel>> getAllCarsWithOwner() async {
    final Map<String, CarWithOwnerModel> carWithOwner = {};

    final result = realmGarage.all<Garage>();

    for (var garage in result) {
      final carResult = realmCar.query<Car>('_id == "${garage.idCar}"');
      final ownerResult = realmOwner.query<Owner>('_id == "${garage.idOwner}"');

      final car = carResult.first;
      final owner = ownerResult.first;

      carWithOwner.putIfAbsent(
        garage.id,
        () => CarWithOwnerModel(
          car: CarModel(
            id: car.id,
            name: car.name,
            model: car.model,
          ),
          owner: OwnerModel(
            id: owner.id,
            name: owner.name,
          ),
        ),
      );
    }

    return carWithOwner;
  }

  Future<String> deletedCarInGarage({
    required String idGarage,
    required String idCar,
    required String idOwner,
  }) async {
    final toDelete = realmGarage.query<Garage>('_id == "$idGarage"').first;
    try {
      realmGarage.write(
        () => realmGarage.delete(toDelete),
      );
    } catch (e) {
      return 'Deleted is error: $e';
    }

    return 'deleted is success';
  }
}

import 'dart:math';

import 'package:realm_flutter/model/car_model.dart';
import 'package:realm_flutter/model/car_with_owner_model.dart';
import 'package:realm_flutter/model/owner_model.dart';

import '../config/synchronization.dart';
import 'dao/car.dart';
import 'dao/garage.dart';
import 'dao/owner.dart';

class DataSource {
  //instansi dari synchronization
  final remoteDataSource = Synchronization();

  //fungsi untuk menambah data pemilik
  Future<String> insertNewOwner({required OwnerModel ownerModel}) async {
    final realm = await remoteDataSource.getRealmInstance();

    final owner = Owner(
      ownerModel.id,
      ownerModel.name,
    );

    realm.write(() => realm.add(owner));

    return 'Insert is success.';
  }

  //fungsi untuk menambah data garasi
  Future<String> insertToGarage({
    required String idCar,
    required String idOwner,
  }) async {
    try {
      final realm = await remoteDataSource.getRealmInstance();

      final random = Random();
      final id = random.nextInt(9999);

      final garage = Garage(
        id.toString(),
        idCar,
        idOwner,
      );

      realm.write(() => realm.add(garage));
    } catch (e) {
      return e.toString();
    }

    return 'Insert is success';
  }

  //fungsi untuk menambah data mobil
  Future<String> insertNewCar({required CarModel carModel}) async {
    try {
      final realm = await remoteDataSource.getRealmInstance();

      final car = Car(
        carModel.id,
        carModel.name,
        carModel.model,
      );

      realm.write(() => realm.add(car));

      return 'Insert is success';
    } catch (e) {
      return e.toString();
    }
  }

  //fungsi untuk mengambil data mobil
  Future<List<CarModel>> getAllCars() async {
    final realm = await remoteDataSource.getRealmInstance();

    final result = realm.all<Car>();

    return result
        .map((e) => CarModel(
              id: e.id,
              name: e.name,
              model: e.model,
            ))
        .toList();
  }

  //fungsi untuk menambha data pemilik
  Future<List<OwnerModel>> getAllOwners() async {
    final realm = await remoteDataSource.getRealmInstance();

    final result = realm.all<Owner>();

    return result
        .map((e) => OwnerModel(
              id: e.id,
              name: e.name,
            ))
        .toList();
  }

  //fungsi untuk menambah data mobil dengan owner di dalam garasi
  Future<Map<String, CarWithOwnerModel>> getAllCarsWithOwner() async {
    final realm = await remoteDataSource.getRealmInstance();

    final Map<String, CarWithOwnerModel> carWithOwner = {};

    final result = realm.all<Garage>();

    for (var garage in result) {
      final carResult = realm.query<Car>('_id == "${garage.idCar}"');
      final ownerResult = realm.query<Owner>('_id == "${garage.idOwner}"');

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

  //fungsi untuk menghapus data garasi
  Future<String> deletedCarInGarage({
    required String idGarage,
    required String idCar,
    required String idOwner,
  }) async {
    final realm = await remoteDataSource.getRealmInstance();

    final toDelete = realm.query<Garage>('_id == "$idGarage"').first;
    try {
      realm.write(
        () => realm.delete(toDelete),
      );
    } catch (e) {
      return 'Deleted is error: $e';
    }

    return 'deleted is success';
  }

  //fungsi untuk melakukan sinkronisasi ke server
  Future<String> syncAllToServer() async {
    final realm = await remoteDataSource.getRealmInstance();

    try {
      final allGarage = realm.all<Garage>();
      final allOwner = realm.all<Owner>();
      final allCar = realm.all<Car>();

      await remoteDataSource.synced(allGarage, name: 'all-garage');
      await remoteDataSource.synced(allCar, name: 'all-car');
      await remoteDataSource.synced(allOwner, name: 'all-owner');

      return 'sync is completed';
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}

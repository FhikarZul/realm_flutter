import 'package:realm_flutter/model/car_model.dart';
import 'package:realm_flutter/model/owner_model.dart';

class CarWithOwnerModel {
  final CarModel car;
  final OwnerModel owner;

  CarWithOwnerModel({
    required this.car,
    required this.owner,
  });
}

import 'package:flutter/material.dart';
import 'package:realm_flutter/model/owner_model.dart';

import '../data/db/local/data_source.dart';
import '../model/car_model.dart';

class InsertToGaragePage extends StatefulWidget {
  const InsertToGaragePage({Key? key}) : super(key: key);

  @override
  State<InsertToGaragePage> createState() => _InsertToGaragePageState();
}

class _InsertToGaragePageState extends State<InsertToGaragePage> {
  final dataSource = DataSource();
  List<CarModel> cars = [];
  List<OwnerModel> owners = [];

  String? carDropDownSelected;
  String? ownerDropDownSelected;

  @override
  void initState() {
    super.initState();

    fetchingCar();
    fetchingOwner();
  }

  //mengambil data mobil
  void fetchingCar() async {
    final result = await dataSource.getAllCars();

    setState(() {
      cars = result;
    });
  }

  //mengambil data pemilik
  void fetchingOwner() async {
    final result = await dataSource.getAllOwners();

    setState(() {
      owners = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Garage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Mobil'),
            DropdownButton(
              isExpanded: true,
              value: carDropDownSelected,
              items: cars
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  carDropDownSelected = value.toString();
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Pilih Owner'),
            DropdownButton(
              isExpanded: true,
              value: ownerDropDownSelected,
              items: owners
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  ownerDropDownSelected = value.toString();
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await dataSource.insertToGarage(
                  idCar: carDropDownSelected!,
                  idOwner: ownerDropDownSelected!,
                );

                Future.delayed(
                  const Duration(milliseconds: 0),
                  (() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result),
                      ),
                    );

                    Navigator.pop(context, true);
                  }),
                );
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}

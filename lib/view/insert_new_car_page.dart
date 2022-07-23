import 'dart:math';

import 'package:flutter/material.dart';
import 'package:realm_flutter/db/data_source/data_source.dart';
import 'package:realm_flutter/model/car_model.dart';

class InsertNewCarPage extends StatefulWidget {
  const InsertNewCarPage({Key? key}) : super(key: key);

  @override
  State<InsertNewCarPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertNewCarPage> {
  String? name;
  String? models;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert New Car'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text('Name'),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text('Models'),
                TextFormField(
                  onChanged: (text) {
                    setState(() {
                      models = text;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final random = Random();
                      int id = random.nextInt(99999);

                      final carModel = CarModel(
                        id: '$id',
                        name: name!,
                        model: models!,
                      );

                      final dataSource = DataSource();
                      final result =
                          await dataSource.insertNewCar(carModel: carModel);

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
                    child: const Text('ADD NEW CAR'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

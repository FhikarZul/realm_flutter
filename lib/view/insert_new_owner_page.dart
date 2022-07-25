import 'dart:math';

import 'package:flutter/material.dart';
import 'package:realm_flutter/model/owner_model.dart';

import '../data/db/local/local_data_source.dart';

class InsertNewOwnerPage extends StatefulWidget {
  const InsertNewOwnerPage({Key? key}) : super(key: key);

  @override
  State<InsertNewOwnerPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertNewOwnerPage> {
  String? name;
  String? models;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert New Owner'),
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
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final random = Random();
                      int id = random.nextInt(99999);

                      final ownerModel = OwnerModel(
                        id: '$id',
                        name: name!,
                      );

                      final dataSource = LocalDataSource();
                      final result = await dataSource.insertNewOwner(
                          ownerModel: ownerModel);

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

import 'package:flutter/material.dart';
import 'package:realm_flutter/db/data_source/data_source.dart';
import 'package:realm_flutter/model/car_with_owner_model.dart';
import 'package:realm_flutter/view/insert_new_car_page.dart';
import 'package:realm_flutter/view/insert_new_owner_page.dart';
import 'package:realm_flutter/view/insert_to_garage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, CarWithOwnerModel> garage = {};
  final dataSource = DataSource();

  @override
  void initState() {
    super.initState();
    fetching();
  }

  void fetching() async {
    final result = await dataSource.getAllCarsWithOwner();
    setState(() {
      garage = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            InkResponse(
              onTap: () => fetching(),
              child: const Icon(Icons.restart_alt),
            )
          ],
        ),
        body: (garage.isEmpty)
            ? const Center(
                child: Text('Garage is empty!'),
              )
            // : ListView.builder(
            //     itemCount: garage.length,
            //     itemBuilder: ((context, index) {
            //       final item = garage[index];

            //       return Card(
            //         child: InkWell(
            //           onTap: () {
            //             showDialog(
            //                 context: context,
            //                 builder: (context) {
            //                   return AlertDialog(
            //                     title: const Text('Detail'),
            //                     content: Column(
            //                       mainAxisSize: MainAxisSize.min,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text('Model: ${item!.car.model}'),
            //                         Text('Owner: ${item.owner.name}'),
            //                       ],
            //                     ),
            //                   );
            //                 });
            //           },
            //           child: ListTile(
            //             title: Text(item!.car.name),
            //           ),
            //         ),
            //       );
            //     }),
            //   ),

            : Column(
                children: [
                  ...garage.entries.map((e) {
                    final key = e.key;
                    final value = e.value;

                    return Card(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Detail'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Model: ${value.car.model}'),
                                      Text('Owner: ${value.owner.name}'),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: ListTile(
                          title: Text(value.car.name),
                          trailing: InkResponse(
                            child: const Icon(Icons.delete),
                            onTap: () async {
                              final result =
                                  await dataSource.deletedCarInGarage(
                                idGarage: key,
                                idCar: value.car.id,
                                idOwner: value.owner.id,
                              );
                              fetching();
                              print(result);
                            },
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InsertNewCarPage(),
                    ),
                  );
                },
                child: const Text('Add Car'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InsertNewOwnerPage(),
                    ),
                  );
                },
                child: const Text('Add Owner'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InsertToGaragePage()),
                  );

                  if (result != null && result) {
                    fetching();
                  }
                },
                child: const Text('Add Car To Garage'),
              )
            ],
          ),
        ));
  }
}

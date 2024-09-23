import 'package:flutter/material.dart';
import 'package:bro/data/CarData.dart';
import 'package:bro/screens/ModelsWiseFiltering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModelDetailsScreen extends ConsumerStatefulWidget {
  ModelDetailsScreen({super.key, required this.car});

  final Car car;

  @override
  ConsumerState<ModelDetailsScreen> createState() => _ModelDetailsScreenState();
}

class _ModelDetailsScreenState extends ConsumerState<ModelDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var listofmodels = widget.car.models;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Models Details"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return ListView.builder(
            itemCount: listofmodels.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(listofmodels[index]['name']),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp),
                      onTap: () {
                        var car_id = widget.car.car_id;

                        var model_id = listofmodels[index]['_id'];

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ModelWiseFilteringScreen(
                              car_id: car_id,
                              model_id: model_id,
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

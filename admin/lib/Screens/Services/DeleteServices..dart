import 'package:admin/Api/Services.dart';
import 'package:admin/Api/Users.dart';
import 'package:admin/models/Service.dart';
import 'package:admin/models/UserModel.dart';
import 'package:flutter/material.dart';

class DeleteServices extends StatefulWidget {
  const DeleteServices({super.key});

  @override
  State<DeleteServices> createState() => _DeleteServicesState();
}

class _DeleteServicesState extends State<DeleteServices> {
  final _formKey = GlobalKey<FormState>();
  String? selectedServices;

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Services"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth < 600
              ? constraints.maxWidth * 0.9
              : constraints.maxWidth / 2;
          double height = constraints.maxHeight / 1.5;

          return Center(
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Select Service to Delete",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      FutureBuilder<List<ServiceModel>>(
                        future: Services().getServies(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            List<ServiceModel> serviceData = snapshot.data!;

                            return DropdownButtonFormField<String>(
                              value: selectedServices,
                              hint: const Text("Select Service to delete"),
                              items: serviceData
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e.service_id,
                                      child: Text(e.service_name)))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedServices = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a Car';
                                }
                                return null;
                              },
                            );
                          } else {
                            return const Text("No products available");
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final isValid = _formKey.currentState!.validate();

                            if (!isValid) {
                              return;
                            }

                            setState(() {
                              isloading = true;
                            });

                            final response = await Services()
                                .deleteService(selectedServices!);

                            if (response.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response)));

                              setState(() {
                                isloading = false;
                                selectedServices = null;
                              });
                            }
                          },
                          child: const Text("Delete Service"))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

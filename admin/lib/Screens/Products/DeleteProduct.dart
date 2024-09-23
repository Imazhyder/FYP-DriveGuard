import 'package:admin/Api/Cars.dart';
import 'package:admin/Api/ProductsApi.dart';
import 'package:admin/Api/modelWiseUpload.dart';
import 'package:admin/models/CarModel.dart';
import 'package:admin/models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteProduct extends ConsumerStatefulWidget {
  const DeleteProduct({super.key});

  @override
  ConsumerState<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends ConsumerState<DeleteProduct> {
  final _formKey = GlobalKey<FormState>();

  bool isloading = false;
  String? selectedProductId;
  String? selectedCar;
  String? selectedModel;
  String? selectedPriority;
  String? selectedModelWiseCategory;

  bool modelWise = false;
  List models = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Product"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth < 600
              ? constraints.maxWidth * 0.9
              : constraints.maxWidth / 2;
          double height = constraints.maxHeight / 2;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (modelWise) ..._modelWise(),
                        if (modelWise == false)
                          FutureBuilder<List<ProductModel>>(
                            future: ref.read(productsProvider).getProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                List<ProductModel> products = snapshot.data!;

                                // Ensure selectedProductId is valid
                                if (selectedProductId != null &&
                                    !products.any((product) =>
                                        product.product_id ==
                                        selectedProductId)) {
                                  selectedProductId = null;
                                }

                                return DropdownButtonFormField<String>(
                                  value: selectedProductId,
                                  hint: const Text("Select Your Product"),
                                  items: products.map((product) {
                                    return DropdownMenuItem<String>(
                                      value: product.product_id,
                                      child: Text(product.product_name),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedProductId = value;
                                      print(
                                          'Selected product: $selectedProductId');
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a Product';
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
                          height: 20,
                        ),
                        if (modelWise == false)
                          ElevatedButton(
                              onPressed: () async {
                                final isValid =
                                    _formKey.currentState!.validate();

                                if (!isValid || selectedProductId == null) {
                                  return;
                                }
                                setState(() {
                                  isloading = true;
                                });
                                final response = await ref
                                    .read(productsProvider)
                                    .deleteProduct(selectedProductId!);

                                if (response ==
                                    "Product deleted successfully") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(response)));
                                  setState(() {
                                    selectedProductId = null;
                                    isloading = false;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(response)));
                                }
                              },
                              child: const Text("Delete Product")),
                        Switch.adaptive(
                          value: modelWise,
                          onChanged: (value) {
                            setState(() {
                              modelWise = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _modelWise() {
    return [
      FutureBuilder<List<CarModel>>(
        future: Cars().getCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            List<CarModel> carsData = snapshot.data!;

            return DropdownButtonFormField<String>(
              value: selectedCar,
              hint: const Text("Select Your Car"),
              items: carsData
                  .map((e) => DropdownMenuItem<String>(
                        value: e.car_id,
                        child: Text(e.car_name),
                      ))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCar = value;
                  if (value != null) {
                    final car = carsData
                        .firstWhere((element) => element.car_id == value);
                    models = car.models;
                    selectedModel =
                        null; // Reset selected model when car changes
                  }
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
      if (selectedCar != null) ...[
        DropdownButtonFormField<String>(
          value: selectedModel,
          hint: const Text("Select Your Model"),
          items: models
              .map((e) => DropdownMenuItem<String>(
                    value: e.model_id,
                    child: Text(e.model_name),
                  ))
              .toList(),
          onChanged: (String? value) {
            setState(() {
              selectedModel = value;
              print(selectedModel);
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a Model';
            }
            return null;
          },
        ),
        DropdownButtonFormField<String>(
          value: selectedModelWiseCategory,
          hint: const Text("Select Your Category"),
          items: ['Oil Filter', 'Air Filter', "Car Oil"]
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (String? value) {
            setState(() {
              selectedModelWiseCategory = value;

              print(selectedModelWiseCategory);
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a Priority';
            }
            return null;
          },
        ),
        DropdownButtonFormField<String>(
          value: selectedPriority,
          hint: const Text("Select Your Priority"),
          items: ['First Priority', 'Second Priority', 'Third Priority']
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (String? value) {
            setState(() {
              selectedPriority = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a Priority';
            }
            return null;
          },
        ),
      ],
      ElevatedButton(
          onPressed: () async {
            final isValid = _formKey.currentState!.validate();

            if (!isValid) {
              return;
            }

            final response = await ModelWise().deletePreferenceProduct(
                selectedCar!,
                selectedModel!,
                selectedPriority!,
                selectedModelWiseCategory!);

            if (response == "Model Product Deleted Succesfully") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(response)));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(response)));
            }

            setState(() {
              selectedCar = null;
              selectedModel = null;
              selectedPriority = null;
              selectedModelWiseCategory = null;
            });
          },
          child: const Text("Delete"))
    ];
  }
}

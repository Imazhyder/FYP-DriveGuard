import 'package:admin/Api/Cars.dart';
import 'package:admin/Api/ProductsApi.dart';
import 'package:admin/Api/modelWiseUpload.dart';
import 'package:admin/models/CarModel.dart';
import 'package:admin/models/ProductModel.dart';
import 'package:admin/providers/loadingProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddProductsScreen extends ConsumerStatefulWidget {
  const AddProductsScreen({super.key});

  @override
  ConsumerState<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends ConsumerState<AddProductsScreen> {
  Uint8List? webImage;
  final _formKey = GlobalKey<FormState>();
  String? productName;
  String? description;
  String? selectedCategory;
  int? price;
  String? selectedCar;
  String? selectedModel;
  String? selectedProduct;
  String? selectedPriority;
  String? selectedModelWiseCategory;
  List models = [];

  bool isloading = false;

  bool modelWise = false;

  void _imagePicker() async {
    if (kIsWeb) {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage == null) {
        return;
      }

      var f = await pickedImage.readAsBytes();

      setState(() {
        webImage = f;
      });
    }
  }

  String? _validateProductName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a product name';
    }
    if (!(value.endsWith('Car Oil') ||
        value.endsWith('Oil Filter') ||
        value.endsWith('Air Filter') ||
        value.endsWith('Gear Oil') ||
        value.endsWith('Battery') ||
        value.endsWith('Coolant') ||
        value.endsWith('Tyre') ||
        value.endsWith('Alloy Wheel') ||
        value.endsWith('Car Wax') ||
        value.endsWith('Spark plug') ||
        value.endsWith('Headlight') ||
        value.endsWith('Seat Cover') ||
        value.endsWith('Exhaust System') ||
        value.endsWith('Car Cover') ||
        value.endsWith('Microfiber Cloth'))) {
      return 'Product name must end with one of the valid categories: "Car Oil", "Oil Filter", "Air Filter", "Gear Oil", "Battery", "Coolant", \n "Tire", "Alloy Wheel", "Car Wax", "Spark plug", \n  "Headlight", "Seat Cover", "Exhaust System", "Car Cover", or "Microfiber Cloth"';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth < 600
                ? constraints.maxWidth * 0.9
                : constraints.maxWidth / 2;
            double height = constraints.maxHeight / 1.1;

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
                        mainAxisAlignment: modelWise
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (modelWise == false) ...[
                            Center(
                              child: Text(
                                "Add Product",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Product Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: _validateProductName,
                              onSaved: (value) {
                                productName = value;
                              },
                            ),
                            TextFormField(
                              maxLines: 10,
                              decoration: const InputDecoration(
                                labelText: 'Product Description',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter description';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                description = newValue;
                              },
                            ),
                            Text(
                              "Images",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            InkWell(
                              onTap: _imagePicker,
                              child: Container(
                                height: 100,
                                width: 100,
                                color: Colors.grey.withOpacity(0.4),
                                child: Center(
                                    child: webImage != null
                                        ? Image.memory(webImage!)
                                        : const Text("Upload Image")),
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              value: selectedCategory,
                              hint: const Text("Select Your Category"),
                              items: [
                                'Car Oil',
                                'Oil Filter',
                                'Air Filter',
                                'Gear Oil',
                                'Battery',
                                'Coolant',
                                'Tyre',
                                'Alloy Wheel',
                                'Car Wax',
                                'Spark plug',
                                'Headlight',
                                'Seat Cover',
                                'Exhaust System',
                                'Car Cover',
                                'Microfiber Cloth',
                              ]
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a Category';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  final regex = RegExp(r'^[0-9]+$');
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a number';
                                  } else if (!regex.hasMatch(value)) {
                                    return 'Only numbers are allowed';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  price = int.tryParse(newValue!);
                                },
                              ),
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final isloading = ref.watch(isLodingProvider);
                                return ElevatedButton(
                                    onPressed: () async {
                                      final isValid =
                                          _formKey.currentState!.validate();

                                      if (!isValid) {
                                        return;
                                      }

                                      _formKey.currentState!.save();

                                      if (webImage == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please Upload Your Image")));

                                        return;
                                      }

                                      final response = await ref
                                          .read(productsProvider)
                                          .addProduct(
                                              productName!,
                                              price!,
                                              description!,
                                              selectedCategory!,
                                              webImage);

                                      if (response.statusCode == 200) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Product uploaded Successfuly")));
                                        }

                                        setState(() {
                                          _formKey.currentState!.reset();
                                          webImage = null;
                                          selectedCategory = null;
                                        });
                                      } else {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "${response.body}")));
                                        }
                                      }
                                    },
                                    child: isloading
                                        ? const CircularProgressIndicator()
                                        : const Text('Add Product'));
                              },
                            ),
                          ],
                          if (modelWise) ..._modelWiseContent(),
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
      ),
    );
  }

  List<Widget> _modelWiseContent() {
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
        FutureBuilder<List<ProductModel>>(
          future: ref.read(productsProvider).getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              List<ProductModel> products = snapshot.data!;

              return DropdownButtonFormField<String>(
                value: selectedProduct,
                hint: const Text("Select Your Product"),
                items: products.map((product) {
                  return DropdownMenuItem<String>(
                    value: product.product_id,
                    child: Text(product.product_name),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedProduct = value;
                    print(value);
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
              return 'Please select a Category';
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
        ElevatedButton(
          onPressed: () async {
            final isValid = _formKey.currentState!.validate();

            if (!isValid) {
              return;
            }
            setState(() {
              isloading = true;
            });
            final response = await ModelWise().uploadPreferenceProduct(
                selectedCar!,
                selectedModel!,
                selectedProduct!,
                selectedPriority!,
                selectedModelWiseCategory!);

            if (response == "Product Succesfully Created") {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(response)));
            } else if (response ==
                "Car id and model id combination already exists") {
              final response = await ModelWise().updatePreferenceProduct(
                  selectedCar!,
                  selectedModel!,
                  selectedProduct!,
                  selectedPriority!,
                  selectedModelWiseCategory!);

              if (response == "Model Product Updated Succesfully") {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(response)));

                setState(() {
                  selectedCar = null;
                  selectedModel = null;
                  selectedProduct = null;
                  selectedPriority = null;
                  selectedModelWiseCategory = null;
                  isloading = false;
                });
              } else if (response == "Car with its model not added yet") {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(response)));
              }
            }
          },
          child: isloading
              ? const CircularProgressIndicator()
              : const Text("Add Products"),
        )
      ],
    ];
  }
}

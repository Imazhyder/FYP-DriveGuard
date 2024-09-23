import 'package:admin/Api/Services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _formKey = GlobalKey<FormState>();

  // Define variables to store form field values
  String? _serviceName;
  Uint8List? webImage;
  String? _price;
  String? _description;
  String? _address;
  String? _email;
  String? _phoneNo;
  List<String>? _providedServices; // Updated to List<String>
  List<String>? _slots; // Updated to List<String>
  int? _rating;
  bool isloading = false;

  // Regex patterns
  // final RegExp _providedServicesRegExp = RegExp(r'^([\w\s]+(, [\w\s]+)*)$');

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

            return Center(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Add Service",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Service Name',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              _serviceName = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a service name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
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
                          SizedBox(height: 10),
                          TextFormField(
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
                              _price = newValue;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                            onSaved: (value) {
                              _description = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              _address = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              _email = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address';
                              }
                              // Simple email validation
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                            onSaved: (value) {
                              _phoneNo = value;
                            },
                            validator: (value) {
                              final RegExp _phoneNoRegExp =
                                  RegExp(r'^\+\d{1,3}-\d{7,15}$');
                              if (value == null || value.isEmpty) {
                                return 'Please enter a phone number';
                              }

                              if (!_phoneNoRegExp.hasMatch(value)) {
                                return "Enter valid phone number e.g +92-3415701533";
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Provided Services (comma separated)',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              // Split the comma-separated values into a list and trim whitespace
                              _providedServices = value
                                  ?.split(',')
                                  .map((e) => e.trim())
                                  .toList();
                            },
                            validator: (value) {
                              RegExp regex = RegExp(r'^[A-Z].*$');
                              if (value == null || value.isEmpty) {
                                return 'Please enter provided services';
                              }

                              // Split the values and check for uniqueness
                              List<String> services = value
                                  .split(',')
                                  .map((e) => e.trim())
                                  .toList();
                              if (services.length != services.toSet().length) {
                                return 'Provided services must be unique';
                              }

                              if (value.length > 100) {
                                return "total numbers for letters should be less than 40";
                              }

                              if (!regex.hasMatch(value)) {
                                return 'First Letter should be capital e.g Wheel or Wheel Balancing both will be accepted';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Available Slots (comma separated)',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              // Split the comma-separated values into a list and trim whitespace
                              _slots = value
                                  ?.split(',')
                                  .map((e) => e.trim())
                                  .toList();
                            },
                            validator: (value) {
                              final RegExp _slotsRegExp = RegExp(
                                r'^(\d{1,2}\/\d{1,2}\/\d{4} - (0?[1-9]|1[0-2]):[0-5][0-9](am|pm))(, \d{1,2}\/\d{1,2}\/\d{4} - (0?[1-9]|1[0-2]):[0-5][0-9](am|pm))*$',
                              );
                              if (value == null || value.isEmpty) {
                                return 'Please enter available slots';
                              }
                              if (!_slotsRegExp.hasMatch(value)) {
                                return 'Please enter valid slots';
                              }

                              // Split the values and check for uniqueness
                              List<String> slots = value
                                  .split(',')
                                  .map((e) => e.trim())
                                  .toList();
                              if (slots.length != slots.toSet().length) {
                                return 'Slots must be unique';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Rating',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              final regex = RegExp(r'^[0-4]+$');
                              if (value == null || value.isEmpty) {
                                return 'Please enter a number';
                              } else if (!regex.hasMatch(value)) {
                                return 'Only numbers from 0 - 4 ';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _rating = int.tryParse(newValue!);
                            },
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() == true) {
                                  // Save the form state
                                  _formKey.currentState?.save();
                                  // Process the data
                                  print('Service Name: $_serviceName');
                                  print('Image URL: $webImage');
                                  print('Price: $_price');
                                  print('Description: $_description');
                                  print('Address: $_address');
                                  print('Email: $_email');
                                  print('Phone Number: $_phoneNo');
                                  print(
                                      'Provided Services: $_providedServices');
                                  print('Available Slots: $_slots');
                                  print('Rating: $_rating');

                                  if (webImage != null) {
                                    setState(() {
                                      isloading = true;
                                    });
                                    final imageUrl = await Services()
                                        .uploadServicesImage(webImage);

                                    final response = await Services()
                                        .addService(
                                            serviceName: _serviceName!,
                                            price: _price!,
                                            description: _description!,
                                            address: _address!,
                                            email: _email!,
                                            phoneNo: _phoneNo!,
                                            providedServices:
                                                _providedServices!,
                                            slots: _slots!,
                                            rating: _rating!,
                                            imgUrl: imageUrl!);

                                    if (response.isNotEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(response)));

                                      setState(() {
                                        isloading = false;
                                      });
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please Upload Your Image")));

                                    return;
                                  }
                                }
                              },
                              child: isloading
                                  ? CircularProgressIndicator()
                                  : Text('Submit'),
                            ),
                          ),
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
}

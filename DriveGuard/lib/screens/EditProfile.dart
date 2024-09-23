import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bro/Api_Service/UserInfoUpdateApi.dart';
import 'package:bro/styles/EditProfiletext.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen(
      {super.key,
      required this.email,
      required this.username,
      required this.gender,
      required this.country,
      required this.address});

  final String email;
  final String username;
  final String gender;
  final String country;
  final String address;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2 - 200,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      triggerDialogBox(
                          context, "Username", false, false, null, false);
                    },
                    leading: Text(
                      'Name',
                      style: editProfileText,
                    ),
                    trailing: Text(
                      widget.username,
                      style: editProfileText,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      triggerDialogBox(
                          context, null, false, false, "Email", false);
                    },
                    leading: Text(
                      'Email',
                      style: editProfileText,
                    ),
                    trailing: Text(
                      widget.email,
                      style: editProfileText,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      triggerDialogBox(context, null, false, true, null, false);
                    },
                    leading: Text(
                      "Gender",
                      style: editProfileText,
                    ),
                    trailing: Text(
                      widget.gender,
                      style: editProfileText,
                    ),
                  ),
                  const Gap(5),
                  ListTile(
                    onTap: () {
                      triggerDialogBox(context, null, true, false, null, false);
                    },
                    selectedColor: Colors.grey,
                    leading: Text(
                      'Country/region',
                      style: editProfileText,
                    ),
                    trailing: Text(
                      widget.country,
                      style: editProfileText,
                    ),
                  )
                ],
              ),
            ),
            const Gap(30),
            ListTile(
              onTap: () {
                triggerDialogBox(context, null, false, false, null, true);
              },
              tileColor: Colors.white,
              leading: Text(
                'Address',
                style: editProfileText,
              ),
              trailing: Container(
                width: MediaQuery.of(context).size.width /
                    2, // Adjust the width as needed
                child: Text(
                  widget.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      decoration: TextDecoration.overline, fontSize: 14),
                ),
              ),
            ),
            const Gap(30),
            ListTile(
              onTap: () {
                awsomeDialog(context);
              },
              tileColor: Colors.white,
              leading: Text(
                'Delete Account',
                style: editProfileText,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget Functions
  void triggerDialogBox(BuildContext context, String? username, bool isCountry,
      bool isGender, String? email, bool isAddress) {
    String? selectedGender;
    String? selectCountry;
    String? newEmail;
    String? newUsername;

    String? newAddress;
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit '),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (isGender) ...[
                      DropdownButtonFormField<String>(
                        value: selectedGender,
                        hint: const Text("Select Your gender"),
                        items: ['Male', 'Female']
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setDialogState(() {
                            selectedGender = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                      ),
                    ],
                    if (username != null) ...[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: username,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                        validator: (value) {
                          final usernameRegix =
                              RegExp(r'^[a-zA-Z](?=.*[._0-9])[a-zA-Z0-9._]+$');
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter First Name";
                          } else if (value.length < 4) {
                            return "The username should contain atleast four characters";
                          } else if (!usernameRegix.hasMatch(value)) {
                            return "starts with alphabet and \nshould contain \natleast one (._ or 0-9 number)";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          newUsername = value!;
                        },
                      ),
                      const Gap(10),
                    ],
                    if (email != null) ...[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: email,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                        validator: (value) {
                          final emailRegex = RegExp(
                              r'^[a-zA-Z]+[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Email";
                          } else if (!emailRegex.hasMatch(value)) {
                            return "Please Enter valid Email address";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          newEmail = value!;
                        },
                      ),
                    ],
                    if (isCountry) ...[
                      DropdownButtonFormField<String>(
                        value: selectCountry,
                        hint: const Text("Select your country"),
                        items: ['Pakistan', 'India', 'Dubai']
                            .map((country) => DropdownMenuItem<String>(
                                  value: country,
                                  child: Text(country),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setDialogState(() {
                            selectCountry = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a Country';
                          }
                          return null;
                        },
                      ),
                    ],
                    if (isAddress) ...[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Please Enter Your Address",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Address";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          newAddress = value!;
                        },
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (username != null) {
                  bool isValid = _formKey.currentState!.validate();

                  if (!isValid) {
                    return;
                  }

                  _formKey.currentState!.save();

                  var requestBody = {'username': newUsername};

                  UserUpdateInfoApi().userUpdateInfo(context, requestBody);
                } else if (email != null) {
                  bool isValid = _formKey.currentState!.validate();

                  if (!isValid) {
                    return;
                  }

                  _formKey.currentState!.save();

                  var requestBody = {'email': newEmail};

                  UserUpdateInfoApi().userUpdateInfo(context, requestBody);
                } else if (isGender) {
                  bool isValid = _formKey.currentState!.validate();

                  if (!isValid) {
                    return;
                  }

                  var requestBody = {'Gender': selectedGender};

                  UserUpdateInfoApi().userUpdateInfo(context, requestBody);
                } else if (isCountry) {
                  bool isValid = _formKey.currentState!.validate();

                  if (!isValid) {
                    return;
                  }

                  var requestBody = {'country': selectCountry};

                  UserUpdateInfoApi().userUpdateInfo(context, requestBody);
                } else {
                  bool isValid = _formKey.currentState!.validate();

                  if (!isValid) {
                    return;
                  }

                  _formKey.currentState!.save();

                  var requestBody = {'address': newAddress};

                  UserUpdateInfoApi().userUpdateInfo(context, requestBody);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void awsomeDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Do you want to delete the account',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnOkOnPress: () {
        UserUpdateInfoApi().deleteAccount(context);
      },
      btnCancelOnPress: () {},
    ).show();
  }
}

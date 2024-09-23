import 'package:bro/Api_Service/UserInfoUpdateApi.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  String? currentPassword;
  String? newPassword;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Image.asset(
            "lib/assets/logo/WhatsApp_Image_2024-05-05_at_1.09.14_PM-removebg-preview.png",
            scale: 4),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),
              const Gap(80),
              TextFormField(
                obscureText: !_currentPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _currentPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentPasswordVisible = !_currentPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter current password";
                  } else if (value.length < 8) {
                    return "Please enter a password greater than 8 characters";
                  }
                  return null;
                },
                onSaved: (value) {
                  currentPassword = value;
                },
              ),
              const Gap(30),
              TextFormField(
                obscureText: !_newPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _newPasswordVisible = !_newPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  final passwordRegix = RegExp(
                      r'^[A-Z](?=.*[0-9])(?=.*[!@#$%^&*_.])[A-Za-z0-9!@#$%^&*_.]+$');
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter new password";
                  } else if (value.length < 8) {
                    return "Please enter a password greater than 8 characters";
                  } else if (!passwordRegix.hasMatch(value)) {
                    return "Start with uppercase alphabet and \n1should contain atleast one (!@#\$%^&*) and atleast one number 0-9";
                  }
                  // Temporarily store the new password value for comparison in confirm password field
                  newPassword = value;
                  return null;
                },
                onSaved: (value) {
                  newPassword = value;
                },
              ),
              const Gap(30),
              TextFormField(
                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter confirm password";
                  } else if (value.length < 8) {
                    return "Please enter a password greater than 8 characters";
                  } else if (value != newPassword) {
                    return "Confirm Password and New Password do not match";
                  }
                  return null;
                },
                onSaved: (value) {
                  confirmPassword = value;

                  print(confirmPassword);
                },
              ),
              const Gap(30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    var isValid = _formKey.currentState!.validate();
                    if (!isValid) {
                      return;
                    }

                    _formKey.currentState!.save();

                    UserUpdateInfoApi().changePassword(
                        context, currentPassword!, confirmPassword!);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(150, 117, 250, 1),
                    fixedSize: Size(180, 60),
                  ),
                  child: const Text(
                    "Confirm Password",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

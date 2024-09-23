import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bro/styles/Light_Text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

  var _username = "";
  var _email = "";
  var _password = "";

  Future<void> _signUp() async {
    final requestBody = {
      'username': _username,
      'email': _email,
      'password': _password,
    };

    final response = await http.post(
      Uri.parse('http://localhost:3000/api/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("signUp Successful");
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Account created Successfully',
        buttonsTextStyle: const TextStyle(color: Colors.black),
        transitionAnimationDuration: const Duration(milliseconds: 500),
        autoHide: const Duration(seconds: 2),
        onDismissCallback: (type) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            )),
      ).show();
    } else {
      print("SignUp failed: ${response.body}");

      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'User already exits',
        buttonsTextStyle: const TextStyle(color: Colors.black),
        autoHide: const Duration(seconds: 1),
        transitionAnimationDuration: const Duration(milliseconds: 500),
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.all(30)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: const Text('Already have an Account? Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Image.asset(
                        "lib/assets/logo/WhatsApp_Image_2024-05-05_at_1.09.14_PM-removebg-preview.png",
                        scale: 3),
                  ),
                ),
                const Text(
                  'Create an Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Light_Text(text: "Welcome to DriveGuard", fontSize: 14),
                const Gap(40),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple))),
                  validator: (value) {
                    final usernameRegix =
                        RegExp(r'^[a-zA-Z](?=.*[._0-9])[a-zA-Z0-9._]+$');
                    if (value == null || value.trim().isEmpty) {
                      return "username not valid";
                    } else if (value.length < 4) {
                      return "The username should contain atleast four characters";
                    } else if (!usernameRegix.hasMatch(value)) {
                      return "starts with alphabet and should contain \natleast one (._ or 0-9 number)";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                const Gap(30),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple))),
                  validator: (value) {
                    final emailRegex = RegExp(
                        r'^[a-zA-Z]+[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter email";
                    } else if (!emailRegex.hasMatch(value)) {
                      return "Please Enter valid Email address";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const Gap(30),
                TextFormField(
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    final passwordRegix = RegExp(
                        r'^[A-Z](?=.*[0-9])(?=.*[!@#$%^&*_.])[A-Za-z0-9!@#$%^&*_.]+$');

                    if (value == null || value.trim().isEmpty) {
                      return "Invalid password";
                    } else if (value.length < 8) {
                      return "Please enter a password greater than 8 characters";
                    } else if (!passwordRegix.hasMatch(value)) {
                      return "Start with uppercase alphabet and \n1should contain atleast one (!@#\$%^&*) and atleast one number 0-9";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const Gap(30),
                Container(
                  margin: const EdgeInsets.only(left: 210),
                  child: ElevatedButton(
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();

                      if (!isValid) {
                        return;
                      }

                      _formKey.currentState!.save();

                      _signUp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(150, 117, 250, 1),
                      fixedSize: const Size(130, 60),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

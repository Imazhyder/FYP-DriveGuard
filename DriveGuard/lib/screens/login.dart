import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bro/screens/bottoNavigation.dart';
import 'package:bro/screens/signup.dart';
import 'package:bro/styles/Light_Text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  bool progressIndicator = false;
  var height = AppBar().preferredSize.height;
  final _formKey = GlobalKey<FormState>();
  var _email = "";
  var _password = "";

  Future<void> _login() async {
    // try {
    //   final url = Uri.parse('http://192.168.18.10:3000/api/auth/login');

    //   final response = await http.post(
    //     url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(<String, String>{
    //       'email': email,
    //       'password': password,
    //     }),
    //   );
    //   var res = jsonDecode(response.body);
    //   if (response.statusCode == 201) {
    //     print('${res['message']}');
    //     print('Working');
    //     return true;

    //     // Navigate to the next screen (e.g., home screen)
    //   } else {
    //     print('${res['message']}');
    //     return false;
    //     // Display error message to the user
    //   }
    // } catch (error) {
    //   print('Error Logging in: $error');
    //   return false;
    //   // Display error message to the user
    // }

    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    try {
      final requestBody = {
        'email': _email,
        'password': _password,
      };

      final response =
          await http.post(Uri.parse('http://localhost:3000/api/login'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final token = responseData['token'];
        final user_id = responseData['_id'];

        print(user_id);

        print(responseData);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('user_id', user_id);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BotttomNavigationScreen(),
            ));
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Invalid Username or Password',
          buttonsTextStyle: const TextStyle(color: Colors.black),
          showCloseIcon: true,
        ).show();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.all(30)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
          );
        },
        child: const Text('Create a Account ? Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(height + 50),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Image.asset(
                        "lib/assets/logo/WhatsApp_Image_2024-05-05_at_1.09.14_PM-removebg-preview.png",
                        scale: 3),
                  ),
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Light_Text(text: "Please Sign in to Continue", fontSize: 14),
                const Gap(40),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple))),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const SizedBox(height: 16.0),
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
                    if (value == null || value.trim().isEmpty) {
                      return "Invalid password";
                    } else if (value.length < 8) {
                      return "please enter password greater then 8 ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const Gap(40),
                Container(
                  margin: const EdgeInsets.only(left: 230),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Implement login logic here
                      // await loginUp(
                      //             email: _emailController.text.trim(),
                      //             password: _passwordController.text.trim()) ==
                      //         true
                      //     ? Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => BotttomNavigationScreen()))
                      //     : Null;

                      _login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(150, 117, 250, 1),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Login",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

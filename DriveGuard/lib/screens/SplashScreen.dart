import 'package:bro/screens/bottoNavigation.dart';
import 'package:bro/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 2), () {
    //   checkLoginStatus();
    // });

    checkUserInDataBase();
  }

  Future<void> checkUserInDataBase() async {
    try {
      // Get the user ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('user_id');
      var token = prefs.getString('token');

      if (userId == null || token == null) {
        checkLoginStatus();
        return;
      }

      // Make the GET request
      final response = await http
          .get(Uri.parse("http://localhost:3000/api/checkUser/$userId"));

      print(response.body);

      if (response.statusCode == 200) {
        checkLoginStatus();
        return;
      } else if (response.statusCode == 400) {
        prefs.remove('token');
        prefs.remove('user_id');

        checkLoginStatus();

        return;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BotttomNavigationScreen(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
            image: AssetImage(
                "lib/assets/logo/WhatsApp_Image_2024-05-05_at_1.09.14_PM-removebg-preview.png")),
      ),
    );
  }
}

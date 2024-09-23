import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bro/screens/UserProfile.dart';
import 'package:bro/screens/bottoNavigation.dart';
import 'package:bro/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserUpdateInfoApi {
  UserUpdateInfoApi();
  void userUpdateInfo(
      BuildContext context, Map<String, dynamic> requestBody) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('user_id').toString();
    try {
      final response = await http.put(
          Uri.parse('http://localhost:3000/api/updateUserInfo/$userid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(requestBody));

      if (response.statusCode == 200) {
        print("Succesfull");
        triggerDialog(context, DialogType.success, (p0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BotttomNavigationScreen(),
              ));
        }, "Your Info Updated");
      } else {
        triggerDialog(context, DialogType.error, null, "Some error Ocuured");
      }
    } catch (error) {
      print(error);
    }
  }

  void deleteAccount(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user_id = prefs.getString('user_id').toString();

      final response = await http
          .delete(Uri.parse('http://localhost:3000/api/deleteUser/$user_id'));

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        prefs.remove('user_id');

        triggerDialog(context, DialogType.success, (p0) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
        }, "Your Account Has been deleted Successfully");
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }

  void changePassword(BuildContext context, String currentPassword,
      String confirmPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString('user_id').toString();

    var requestBody = {
      'currentPassword': currentPassword,
      'confirmPassword': confirmPassword
    };

    try {
      final response = await http.put(
          Uri.parse('http://localhost:3000/api/changePassword/$user_id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        triggerDialog(
            context,
            DialogType.success,
            (p0) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BotttomNavigationScreen(),
                )),
            "Your Password is changed");
      } else if (response.statusCode == 400) {
        triggerDialog(
            context, DialogType.error, null, "Current password not valid");
      } else if (response.statusCode == 401) {
        triggerDialog(context, DialogType.info, null,
            "'New password cannot be the same as the current password'");
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print(error);
    }
  }
}

void triggerDialog(BuildContext context, DialogType dialogType,
    void Function(DismissType)? onDismissCallback, String text) {
  onDismissCallback != null
      ? AwesomeDialog(
              context: context,
              dialogType: dialogType,
              headerAnimationLoop: false,
              animType: AnimType.bottomSlide,
              title: text,
              buttonsTextStyle: const TextStyle(color: Colors.black),
              showCloseIcon: true,
              transitionAnimationDuration: const Duration(seconds: 2),
              onDismissCallback: onDismissCallback)
          .show()
      : AwesomeDialog(
          context: context,
          dialogType: dialogType,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: text,
          buttonsTextStyle: const TextStyle(color: Colors.black),
          showCloseIcon: true,
          transitionAnimationDuration: const Duration(seconds: 2),
        ).show();
}

import 'dart:convert';

import 'package:admin/models/UserModel.dart';
import 'package:http/http.dart' as http;

class Users {
  Future<List<User>> getUsers() async {
    final url = Uri.parse("http://localhost:3000/api/getAllUsersData");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);

        List<User> usersList = jsonData.map<User>(
          (item) {
            return User.fromJson(item);
          },
        ).toList();

        return usersList;
      }

      return [];
    } catch (error) {
      print(error);

      return [];
    }
  }

  Future<String> deleteUser(String user_id) async {
    final url = Uri.parse("http://localhost:3000/api/deleteUser/$user_id");

    print(user_id);
    try {
      final response = await http.delete(url);

      return response.body;
    } catch (error) {
      print(error);

      return "";
    }
  }
}

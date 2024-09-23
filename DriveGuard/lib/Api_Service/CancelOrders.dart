import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CancelOrderRequest {
  Future<String> cancelRequest(String order_id) async {
    final url = Uri.parse("http://localhost:3000/api/cancelRequest");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getString('user_id').toString();

    final requestBody = jsonEncode({"order_id": order_id, "user_id": user_id});

    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: requestBody);

      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        return response.body;
      } else if (response.statusCode == 500) {
        return "This Request is Already been send";
      } else {
        return response.body;
      }
    } catch (error) {
      return "${error}";
    }
  }
}

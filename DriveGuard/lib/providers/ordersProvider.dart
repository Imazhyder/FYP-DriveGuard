import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bro/data/OrderModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersService {
  Future<List<OrderModel>> fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId == null) {
      return [];
    }

    try {
      final response = await http
          .get(Uri.parse("http://localhost:3000/api/getOrders/$userId"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        return jsonData
            .map<OrderModel>((item) => OrderModel.fromJson(item))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}

final ordersProvider = Provider<OrdersService>((ref) => OrdersService());

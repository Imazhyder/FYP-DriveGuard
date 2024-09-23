import 'dart:convert';

import 'package:admin/models/CancelOrderModel.dart';
import 'package:admin/models/OrderModel.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  Future<List<OrderModel>> getAllOrders() async {
    final String url = 'http://localhost:3000/api/getAllOrders';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> ordersJson = json.decode(response.body);
        return ordersJson.map((json) => OrderModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      throw Exception('Error fetching orders: ${error.toString()}');
    }
  }

  Future<String> changeOrderStatus(
      String order_id, String delivery_status) async {
    var url = Uri.parse('http://localhost:3000/api/changeOrderStatus');
    final requestBody =
        jsonEncode({"order_id": order_id, "delivery_status": delivery_status});
    try {
      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          },
          body: requestBody);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } catch (error) {
      return "Error ${error}";
    }
  }

  Future<List<CancelOrderModel>> getCancelOrderRequests() async {
    final url = Uri.parse('http://localhost:3000/api/getcancelRequest');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        final List<CancelOrderModel> canceledOrders = jsonResponse
            .map((order) => CancelOrderModel.fromJson(order))
            .toList();

        return canceledOrders;
      } else {
        // Handle error response
        throw Exception('Failed to load canceled orders');
      }
    } catch (error) {
      print('Error fetching canceled orders: $error');

      // Optionally, rethrow the error to be handled by the calling function
      throw Exception('Failed to fetch canceled orders');
    }
  }
}

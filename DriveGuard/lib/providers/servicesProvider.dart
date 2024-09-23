import 'dart:convert';

import 'package:bro/data/Servicesdata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServicesApi {
  ServicesApi(this.ref);
  ProviderRef ref;

  Future<List<Service>> fetchServices() async {
    try {
      final response = await http
          .get(Uri.parse("http://localhost:3000/api/get-all-services"));

      if (response.statusCode == 200) {
        // Offload the parsing task to an isolate

        return parseServices(response.body);
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to load services');
    }
  }

  List<Service> parseServices(String responseBody) {
    final List<dynamic> jsonData = json.decode(responseBody);

    return jsonData.map<Service>((item) => Service.fromJson(item)).toList();
  }

  Future<http.Response> bookService(String service_id, String selected_service,
      String slot, String paymentMethod) async {
    try {
      ref.read(isLodingProvider.notifier).state = true;

      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getString('user_id');

      final requestBody = {
        "user_id": user_id,
        "service_id": service_id,
        "selected_service": selected_service,
        "slot": slot,
        "paymentMethod": paymentMethod
      };

      final response = await http.post(
        Uri.parse('http://localhost:3000/api/book-service'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: jsonEncode(requestBody),
      );

      return response;
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to book service');
    } finally {
      ref.read(isLodingProvider.notifier).state = false;
    }
  }
}

final serviceProvider = Provider<ServicesApi>((ref) => ServicesApi(ref));

final serviceDataProvider = FutureProvider<List<Service>>(
    (ref) => ref.watch(serviceProvider).fetchServices());

final isLodingProvider = StateProvider<bool>((ref) => false);

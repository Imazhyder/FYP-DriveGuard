import 'dart:convert';

import 'package:bro/data/CarData.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class CarProvider extends StateNotifier<List<Car>> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  CarProvider() : super([]);

  Future<void> getAllCars() async {
    _isLoading = true;

    try {
      final response =
          await http.get(Uri.parse("http://localhost:3000/api/getAllCars"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData is List) {
          final List<Car> cars = jsonData.map<Car>((item) {
            dynamic models = item['models'];

            return Car(
                car_id: item['_id'],
                car_name: item['car_name'],
                brand: item['brand'],
                models: models);
          }).toList();

          state = cars;
        }
      }
    } catch (e) {
      print("Error $e");
    } finally {
      _isLoading = false;
    }
  }
}

final carProvider = StateNotifierProvider<CarProvider, List<Car>>((ref) {
  return CarProvider();
});

import 'dart:convert';

import 'package:admin/models/CarModel.dart';
import 'package:http/http.dart' as http;

class Cars {
  Future<List<CarModel>> getCars() async {
    final url = Uri.parse("http://localhost:3000/api/getAllCars");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List jsonData = jsonDecode(response.body);

        List<CarModel> carsData = jsonData.map(
          (item) {
            return CarModel.fromJson(item);
          },
        ).toList();

        return carsData;
      } else {
        return [];
      }
    } catch (error) {
      print(error);

      return [];
    }
  }
}

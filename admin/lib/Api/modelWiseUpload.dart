import 'dart:convert';
import 'package:http/http.dart' as http;

class ModelWise {
  Future<String> uploadPreferenceProduct(
    String car_id,
    String model_id,
    String product_id,
    String priority,
    String category,
  ) async {
    var requestBody;
    final url = Uri.parse("http://localhost:3000/api/addPreferedProduct");
    try {
      if (priority == "First Priority" && category == "Oil Filter") {
        requestBody = jsonEncode({
          "car_id": car_id,
          "model_id": model_id,
          "modelProducts": {
            "Oil_Filter": {"first_priority": product_id},
          }
        });
      } else if (priority == "Second Priority" && category == "Oil Filter") {
        requestBody = jsonEncode({
          "car_id": car_id,
          "model_id": model_id,
          "modelProducts": {
            "Oil_Filter": {"second_priority": product_id}
          }
        });
      } else if (priority == "Third Priority" && category == "Oil Filter") {
        requestBody = jsonEncode({
          "car_id": car_id,
          "model_id": model_id,
          "modelProducts": {
            "Oil_Filter": {"third_priority": product_id}
          }
        });
      } else if (priority == "First Priority" && category == "Air Filter") {
        requestBody = jsonEncode({
          "car_id": car_id,
          "model_id": model_id,
          "modelProducts": {
            "Air_Filter": {"first_priority": product_id},
          }
        });
      } else if (priority == "Second Priority" && category == "Air Filter") {
        requestBody = jsonEncode({
          "car_id": car_id,
          "model_id": model_id,
          "modelProducts": {
            "Air_Filter": {"second_priority": product_id}
          }
        });
      } else if (priority == "Third Priority" && category == "Air Filter") {
        requestBody = jsonEncode({
          "car_id": car_id,
          "model_id": model_id,
          "modelProducts": {
            "Air_Filter": {"third_priority": product_id}
          }
        });
      } else if (priority == "First Priority" && category == "Car Oil") {
        requestBody = jsonEncode({
          "car_id": car_id,
          "model_id": model_id,
          "modelProducts": {
            "Car_Oil": {"first_priority": product_id}
          }
        });
      } else if (priority == "Second Priority" && category == "Car Oil") {
        requestBody = jsonEncode({
          "car_id": car_id,
          "model_id": model_id,
          "modelProducts": {
            "Car_Oil": {"second_priority": product_id}
          }
        });
      } else {
        requestBody = jsonEncode({
          "car_id": car_id,
          "model_id": model_id,
          "modelProducts": {
            "Car_Oil": {"third_priority": product_id}
          }
        });
      }

      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          },
          body: requestBody);

      print(response.statusCode);

      if (response.statusCode == 200) {
        return "Product Succesfully Created";
      } else if (response.statusCode == 400) {
        return "Car id and model id combination already exists";
      } else {
        return "Some Other Error Occured";
      }
    } catch (error) {
      print(error);
      return "";
    }
  }

  Future<String> updatePreferenceProduct(
    String car_id,
    String model_id,
    String product_id,
    String priority,
    String category,
  ) async {
    final url = Uri.parse("http://localhost:3000/api/updateModelWiseProduct");
    try {
      final requestBody = jsonEncode({
        "car_id": car_id,
        "model_id": model_id,
        "product_id": product_id,
        "priority": priority,
        "category": category
      });

      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          },
          body: requestBody);

      if (response.statusCode == 200) {
        return "Model Product Updated Succesfully";
      } else if (response.statusCode == 400) {
        return "Car with its model not added yet";
      } else {
        return "Some Other Error Occured";
      }
    } catch (error) {
      print(error);
      return "";
    }
  }

  Future<String> deletePreferenceProduct(
    String car_id,
    String model_id,
    String priority,
    String category,
  ) async {
    final url = Uri.parse("http://localhost:3000/api/deletePreferenceProduct");
    try {
      final requestBody = jsonEncode({
        "car_id": car_id,
        "model_id": model_id,
        "priority": priority,
        "category": category
      });

      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          },
          body: requestBody);

      if (response.statusCode == 200) {
        return "Model Product Deleted Succesfully";
      } else if (response.statusCode == 400) {
        return "No combination found";
      } else {
        return "Some Other Error Occured";
      }
    } catch (error) {
      print(error);
      return "";
    }
  }
}

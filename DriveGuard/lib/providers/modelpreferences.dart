import 'dart:convert';
import 'package:bro/data/productdata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ModelPreferencesProvider extends StateNotifier<List<dynamic>> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<CarProduct> _listOfOilFilters = [];
  List<CarProduct> _listofAirFilters = [];
  List<CarProduct> _listofCarOil = [];

  List<CarProduct> get listOfOilFilters => _listOfOilFilters;
  List<CarProduct> get listofAirFilters => _listofAirFilters;
  List<CarProduct> get listofCarOil => _listofCarOil;

  ModelPreferencesProvider() : super([]);

  Future<void> fetchPreferedProducts(String car_id, String model_id) async {
    _listOfOilFilters.clear();
    _listofAirFilters.clear();
    _listofCarOil.clear();

    try {
      final response = await http.get(Uri.parse(
          "http://localhost:3000/api/get_model_preferences/$car_id/$model_id"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData is List) {
          for (var item in jsonData) {
            var modelProducts = item['modelProducts'];
            if (modelProducts != null) {
              var oilFilters = FilterFromObject(modelProducts['Oil_Filter']);
              if (oilFilters != null) _listOfOilFilters = oilFilters;

              var airFilters = FilterFromObject(modelProducts['Air_Filter']);
              if (airFilters != null) _listofAirFilters = airFilters;

              var carOils = FilterFromObject(modelProducts['Car_Oil']);
              if (carOils != null) _listofCarOil = carOils;
            }
          }
        }
      }
    } catch (e) {
      print("Error $e");
    }
  }

  List<CarProduct>? FilterFromObject(dynamic object) {
    if (object == null) {
      print("Received null object in FilterFromObject");
      return null;
    }

    print(object);

    List<CarProduct> priorityProducts = [];

    try {
      var firstPriorityProduct = CarProduct(
          product_id: object['first_priority']?['_id'] ?? '',
          product_name: object['first_priority']?['product_name'] ?? '',
          price: object['first_priority']?['price'] ?? 0,
          description: object['first_priority']?['decription'] ?? '',
          category: object['first_priority']?['category'] ?? '',
          imgUrl: object['first_priority']?['imgUrl'] ?? '',
          reviews: object['first_priority']?['Reviews_Rating'] ?? [],
          prioirty: 1);

      var secondPriorityProduct = CarProduct(
          product_id: object['second_priority']?['_id'] ?? '',
          product_name: object['second_priority']?['product_name'] ?? '',
          price: object['second_priority']?['price'] ?? 0,
          description: object['second_priority']?['decription'] ?? '',
          category: object['second_priority']?['category'] ?? '',
          imgUrl: object['second_priority']?['imgUrl'] ?? '',
          reviews: object['second_priority']?['Reviews_Rating'] ?? [],
          prioirty: 2);

      var thirdPriorityProduct = CarProduct(
          product_id: object['third_priority']?['_id'] ?? '',
          product_name: object['third_priority']?['product_name'] ?? '',
          price: object['third_priority']?['price'] ?? 0,
          description: object['third_priority']?['decription'] ?? '',
          category: object['third_priority']?['category'] ?? '',
          imgUrl: object['third_priority']?['imgUrl'] ?? '',
          reviews: object['third_priority']?['Reviews_Rating'] ?? [],
          prioirty: 3);

      priorityProducts.add(firstPriorityProduct);
      priorityProducts.add(secondPriorityProduct);
      priorityProducts.add(thirdPriorityProduct);
    } catch (e) {
      print("Error in FilterFromObject: $e");
    }

    return priorityProducts;
  }
}

final modelPreferencesProvider =
    StateNotifierProvider<ModelPreferencesProvider, List<dynamic>>((ref) {
  return ModelPreferencesProvider();
});






// import 'dart:convert';

// import 'package:bro/data/productdata.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

// class ModelPreferencesProvider extends StateNotifier<List<dynamic>> {
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   List<CarProduct> _listOfOilFilters = [];
//   List<CarProduct> _listofAirFilters = [];
//   List<CarProduct> _listofCarOil = [];

//   List<CarProduct> get listOfOilFilters => _listOfOilFilters;
//   List<CarProduct> get listofAirFilters => _listofAirFilters;
//   List<CarProduct> get listofCarOil => _listofCarOil;
//   ModelPreferencesProvider() : super([]);

//   Future<void> fetchPreferedProducts(String car_id, String model_id) async {
//     _listOfOilFilters.clear();
//     _listofAirFilters.clear();
//     _listofCarOil.clear();

//     try {
//       final response = await http.get(Uri.parse(
//           "http://localhost:3000/api/get_model_preferences/$car_id/$model_id"));

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);

//         if (jsonData is List) {
//           for (var item in jsonData) {
//             // var list =
//             //     listofAirFilters.add(item['modelProducts']['Air_Filter']);

//             var Oilfilters =
//                 FilterFromObject(item['modelProducts']['Oil_Filter']);

//             _listOfOilFilters = Oilfilters;

//             var Airfilters =
//                 FilterFromObject(item['modelProducts']['Air_Filter']);

//             _listofAirFilters = Airfilters;

//             var CarOils = FilterFromObject(item['modelProducts']['Car_Oil']);

//             _listofCarOil = CarOils;
//           }
//         }
//       }
//     } catch (e) {
//       print("Error $e");
//     }
//   }

//   List<CarProduct> FilterFromObject(dynamic Object) {
//     List<CarProduct> Priorityproducts = [];

//     var firstPriortyProduct = CarProduct(
//         product_id: Object['first_priority']['_id'],
//         product_name: Object['first_priority']['product_name'],
//         price: Object['first_priority']['price'],
//         description: Object['first_priority']['decription'],
//         category: Object['first_priority']['category'],
//         imgUrl: Object['first_priority']['imgUrl'],
//         prioirty: 1);

//     var secondPriortyProduct = CarProduct(
//         product_id: Object['second_priority']['_id'],
//         product_name: Object['second_priority']['product_name'],
//         price: Object['second_priority']['price'],
//         description: Object['second_priority']['decription'],
//         category: Object['second_priority']['category'],
//         imgUrl: Object['second_priority']['imgUrl'],
//         prioirty: 2);

//     var thridPriortyProduct = CarProduct(
//         product_id: Object['third_priority']['_id'],
//         product_name: Object['third_priority']['product_name'],
//         price: Object['third_priority']['price'],
//         description: Object['third_priority']['decription'],
//         category: Object['third_priority']['category'],
//         imgUrl: Object['third_priority']['imgUrl'],
//         prioirty: 3);

//     Priorityproducts.add(firstPriortyProduct);
//     Priorityproducts.add(secondPriortyProduct);
//     Priorityproducts.add(thridPriortyProduct);

//     return Priorityproducts;
//   }
// }

// final modelPreferencesProvider =
//     StateNotifierProvider<ModelPreferencesProvider, List<dynamic>>((ref) {
//   return ModelPreferencesProvider();
// });

import 'dart:convert';

import 'package:bro/data/productdata.dart';
import 'package:flutter/material.dart';

import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProductsProvider extends StateNotifier<List<CarProduct>> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  FavoriteProductsProvider() : super([]);

  // bool toggleFavProductStatus(CarProduct carProduct) {
  //   final isProductFav = state.contains(carProduct.product_id);

  //   if (isProductFav) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<void> addAndRemoveFromFav(
      CarProduct carProduct, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userid = prefs.getString('user_id').toString();

    String productid = carProduct.product_id;

    print(userid);

    print(productid);

    try {
      final requestBody = {"user_id": userid, "product_id": productid};
      final response =
          await http.post(Uri.parse('http://localhost:3000/api/addToFav'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode(requestBody));

      if (response.statusCode == 200) {
        print("product added Successfully");
        SnackbarMessenger("Added to Wishlist", context);

        // state = [...state, carProduct];
        getFavProducts();
      } else if (response.statusCode == 201) {
        print("Removed from favs");
        state = state
            .where((p) => p.product_id != productid)
            .toList(); // p.product_id (id of product inside the state and productid is the id of the product we are passing)
        SnackbarMessenger("Removed from wishlist", context);

        getFavProducts();
      } else {
        print("Some Error Occured");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> getFavProducts() async {
    _isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('user_id');

    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/api/getFavData$userid'));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        print(jsonData);

        // for (var item in jsonData) {
        //   print(item['product_id']['_id']);
        // }

        if (jsonData is List) {
          // Check if jsonData is a list
          final products = jsonData.map<CarProduct>((item) {
            print(item['product_id']['_id']);

            return CarProduct(
                product_id: item['product_id']['_id'],
                product_name: item['product_id']['product_name'],
                price: item['product_id']['price'],
                description: item['product_id']['decription'],
                category: item['product_id']['category'],
                imgUrl: item['product_id']['imgUrl']);
          }).toList();

          print(products);

          state = products;
        } else {
          state = []; // Set state to an empty list if jsonData is not a list
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> SnackbarMessenger(
      String text, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 1),
    ));
  }

  // Future<void> getFavProducts() async {
  //   _isLoading = true;

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userid = prefs.getString('user_id');

  //   try {
  //     final response = await http
  //         .get(Uri.parse('http://localhost:3000/api/getFavData$userid'));

  //     if (response.statusCode == 200) {
  //       List jsonData = jsonDecode(response.body);

  //       if (jsonData.isNotEmpty) {
  //         final products = jsonData.map<CarProduct>((item) {
  //           return CarProduct(
  //             product_id: item['product_id']['_id'] ?? '',
  //             product_name: item['product_id']['product_name'] ?? '',
  //             price: item['product_id']['price'] ?? 0.0,
  //             description: item['product_id']['description'] ?? '',
  //             category: item['product_id']['category'] ?? '',
  //             imgUrl: item['product_id']['imgUrl'] ?? '',
  //           );
  //         }).toList();

  //         state = products; // Reset the state to the new list of products
  //       } else {
  //         state = []; // Set state to an empty list if jsonData is an empty list
  //       }

  //       _isLoading = false;
  //     } else {
  //       print('Error response status: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error fetching favorite products: $error');
  //   }
  // }

//   Future<void> getFavProducts() async {
//     _isLoading = true;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var userid = prefs.getString('user_id');

//     try {
//       final response = await http
//           .get(Uri.parse('http://localhost:3000/api/getFavData$userid'));

//       if (response.statusCode == 200) {
//         var jsonData = jsonDecode(response.body);

//         if (jsonData.isNotEmpty) {
//           // Check if jsonData is not empty
//           final products = jsonData.map<CarProduct>((item) {
//             return CarProduct(
//                 product_id: item['product_id']['_id'],
//                 product_name: item['product_id']['product_name'],
//                 price: item['product_id']['price'],
//                 description: item['product_id']['decription'],
//                 category: item['product_id']['category'],
//                 imgUrl: item['product_id']['imgUrl']);
//           }).toList();

//           state = products;
//         } else {
//           state = []; // Set state to an empty list if jsonData is empty
//         }

//         // print(jsonData);

//         // for (var item in jsonData) {
//         //   var favProduct = CarProduct(
//         //       product_id: item['product_id']['_id'],
//         //       product_name: item['product_id']['product_name'],
//         //       price: item['product_id']['price'],
//         //       description: item['product_id']['decription'],
//         //       category: item['product_id']['category'],
//         //       imgUrl: item['product_id']['imgUrl']);

//         //   state = [...state, favProduct];
//         // }

//         _isLoading = false;
//       } else {
//         print(response.statusCode);
//       }
//     } catch (error) {
//       print(error);
//     }
//   }
}

final favProductProvider =
    StateNotifierProvider<FavoriteProductsProvider, List<CarProduct>>(
  (ref) {
    return FavoriteProductsProvider();
  },
);

// The CarProduct will be removed from the list of favorites when the toggleFavProductStatus method is called and the isProductFav variable is true, indicating that the product is already a favorite.

// Let's consider an example:

// Initially, let's say we have a list of favorite CarProducts:
// php

// [CarProduct(name: "Car 1"), CarProduct(name: "Car 2"), CarProduct(name: "Car 3")]

// Now, let's say we want to toggle the favorite status of "Car 2". We call the toggleFavProductStatus method with "Car 2" as the parameter.
// Inside the method, isProductFav will be true because "Car 2" is already in the list of favorites.
// Then, this line of code will execute:

// The where method will iterate over each CarProduct in the state list. It will keep the CarProduct if its name is not equal to "Car 2" (the carProduct we want to remove).
// So, after this line executes, "Car 2" will be removed from the list of favorite products.
// Therefore, the CarProduct will be removed from the list of favorites when the toggleFavProductStatus method is called and the isProductFav variable is true.

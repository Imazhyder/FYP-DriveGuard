import 'dart:convert';

import 'package:bro/data/productdata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends StateNotifier<List<CarProduct>> {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductsProvider() : super([]);

  Future<void> fetchProducts() async {
    _isLoading = true;

    try {
      final response = await http
          .get(Uri.parse("http://localhost:3000/api/get_All_Products"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final List<CarProduct> products = jsonData.map<CarProduct>((item) {
          return CarProduct(
              product_id: item['_id'],
              product_name: item['product_name'],
              price: item['price'],
              description: item['decription'],
              category: item['category'],
              imgUrl: item['imgUrl'],
              reviews: item['Reviews_Rating']);
        }).toList();

        state = products;
      }
    } catch (e) {
      print("Error $e");
    } finally {
      _isLoading = false;
    }
  }
}

final productsProvider =
    StateNotifierProvider<ProductsProvider, List<CarProduct>>((ref) {
  return ProductsProvider();
});

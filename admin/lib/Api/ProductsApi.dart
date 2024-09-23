import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:admin/Api/UploadImage.dart';
import 'package:admin/models/ProductModel.dart';
import 'package:admin/providers/loadingProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsApi {
  ProductsApi(this.ref);
  ProviderRef ref;

  Future<http.Response> addProduct(String productName, int price,
      String description, String category, Uint8List? webImage) async {
    try {
      ref.read(isLodingProvider.notifier).state = true;

      final imgUrl = await UploadImage().uploadImage(webImage);
      final requestBody = jsonEncode({
        'product_name': productName,
        'price': price,
        'decription': description,
        'category': category,
        'imgUrl': imgUrl
      });

      final response = await http.post(
        Uri.parse('http://localhost:3000/api/add_product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: requestBody,
      );
      return response;
    } catch (error) {
      // print('An error occurred: $error');
      throw Exception("Some Error occured $error");
    } finally {
      ref.read(isLodingProvider.notifier).state = false;
    }
  }

  Future<List<ProductModel>> getProducts() async {
    final url = Uri.parse("http://localhost:3000/api/get_All_Products");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        print(jsonData);

        List<ProductModel> productlist = jsonData.map<ProductModel>(
          (item) {
            return ProductModel.fromJson(item);
          },
        ).toList();

        return productlist;
      } else {
        print(response.statusCode);
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<String> deleteProduct(String product_id) async {
    final url =
        Uri.parse("http://localhost:3000/api/deleteProduct/$product_id");
    try {
      final response = await http.delete(url);

      return response.body;
    } catch (error) {
      print(error);
      return "Error $error";
    }
  }
}

final productsProvider = Provider<ProductsApi>((ref) => ProductsApi(ref));

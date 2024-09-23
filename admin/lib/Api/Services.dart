import 'dart:developer';
import 'dart:typed_data';
import 'package:admin/models/Service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Services {
  Future<String?> uploadServicesImage(Uint8List? webImage) async {
    if (webImage == null) return null;

    try {
      // Create a reference to the storage location
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('DriveGuard')
          .child('services')
          .child('${DateTime.now().millisecondsSinceEpoch.toString()}.png');

      // Upload the file to Firebase Storage
      final uploadTask = storageRef.putData(webImage);
      final snapshot = await uploadTask;

      // Get the download URL
      final downloadURL = await snapshot.ref.getDownloadURL();

      print(downloadURL);

      return downloadURL;
    } catch (e) {
      // Handle errors
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String> addService({
    required String serviceName,
    required String price,
    required String description,
    required String address,
    required String email,
    required String phoneNo,
    required List<String> providedServices,
    required List<String> slots,
    required int rating,
    required String imgUrl,
  }) async {
    final url = Uri.parse('http://localhost:3000/api/create-service');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "service_name": serviceName,
          "imgUrl": imgUrl,
          "price": price,
          "description": description,
          "info": {"address": address, "email": email, "phone_no": phoneNo},
          "providedServices": providedServices,
          "slots": slots,
          "rating": rating
        }),
      );

      if (response.statusCode == 200) {
        return "Service added successfully";
      } else {
        return "Failed to add service ${{response.statusCode}}";
        // Handle error response
      }
    } catch (error) {
      // Handle any errors that occur during the request
      return "Error adding service: $error";
    }
  }

  Future<List<ServiceModel>> getServies() async {
    final url = Uri.parse('http://localhost:3000/api/get-all-services');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List data = json.decode(response.body);

        final services =
            data.map((item) => ServiceModel.fromJson(item)).toList();

        return services;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<String> deleteService(String service_id) async {
    final url =
        Uri.parse('http://localhost:3000/api/deleteService/$service_id');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } catch (error) {
      return "Error $error";
    }
  }
}

// String? _serviceName;
//   Uint8List? webImage;
//   String? _price;
//   String? _description;
//   String? _address;
//   String? _email;
//   String? _phoneNo;
//   List<String>? _providedServices; // Updated to List<String>
//   List<String>? _slots; // Updated to List<String>
//   String? _rating;

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class UploadImage {
  Future<String?> uploadImage(Uint8List? webImage) async {
    if (webImage == null) return null;

    try {
      // Create a reference to the storage location
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('DriveGuard')
          .child('products')
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
}

import 'dart:io';
import 'package:employeemanager/response/firebase_response/firebase_response_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorageRepo {
  final _storage = FirebaseStorage.instance;

  Future<FirebaseResponse<String>> uploadImage(
      File imageBytes, String imageName) async {
    try {
      final Reference storageRef =
          _storage.ref().child('images/profile-pics/$imageName');
      final UploadTask uploadTask = storageRef.putFile(imageBytes);

      final TaskSnapshot storageSnapshot = await uploadTask;
      final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

      return FirebaseResponse<String>(data: downloadUrl, errorMessage: '');
    } catch (e) {
      return FirebaseResponse(errorMessage: e.toString());
    }
  }

  // Future<FirebaseResponse<String>> uploadVideo(
  //     File imageBytes, String imageName) async {
  //   try {
  //     final Reference storageRef =
  //         _storage.ref().child('video/property-video/$imageName');
  //     final UploadTask uploadTask = storageRef.putFile(imageBytes);

  //     final TaskSnapshot storageSnapshot = await uploadTask;
  //     final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

  //     return FirebaseResponse<String>(data: downloadUrl, errorMessage: '');
  //   } catch (e) {
  //     return FirebaseResponse(errorMessage: e.toString());
  //   }
  // }
}

import 'package:employeemanager/constant/data_constant.dart';
import 'package:employeemanager/response/firebase_response/firebase_response_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthRepo {
  final auth = FirebaseAuth.instance;

  bool isUserLogin() {
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  void signOutUser() {
    auth.signOut();
  }

  Future<FirebaseResponse<UserCredential>> loginUserWithEmail(
      String email, String password) async {
    try {
      final userLogin = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return FirebaseResponse<UserCredential>(
          data: userLogin, errorMessage: '');
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(errorMessage: firebaseAuthException(e));
    }
  }

  Future<FirebaseResponse<UserCredential>> signupUserWithEmail(
      String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return FirebaseResponse<UserCredential>(
          data: userCredential, errorMessage: '');
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(errorMessage: firebaseAuthException(e));
    }
  }

  Future<bool> resetUserPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (err) {
      debugPrint("Error while reseting user password: $err");
      return false;
    } catch (e) {
      debugPrint("Error while reseting user password: $e");
      return false;
    }
  }
}

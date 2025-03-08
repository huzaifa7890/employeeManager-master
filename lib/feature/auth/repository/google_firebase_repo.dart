import 'package:employeemanager/response/firebase_response/firebase_response_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleFirebaseRepo {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  void googleLogout() {
    googleSignIn.signOut();
  }

  Future<FirebaseResponse<UserCredential>> loginWithGoogle() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);
        final currentUser = userCredential.user;
        debugPrint('Current User: $currentUser');
        debugPrint("User Name : ${currentUser?.displayName}");
        debugPrint("Email : ${currentUser?.email}");
        debugPrint("Email Verified : ${currentUser?.emailVerified}");
        if (userCredential.user != null) {
          return FirebaseResponse<UserCredential>(
              data: userCredential, errorMessage: '');
        } else {
          return const FirebaseResponse<UserCredential>(
              errorMessage: 'Some Error Occured');
        }
      } else {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          final googleSignIn = await auth.signInWithCredential(credential);
          return FirebaseResponse<UserCredential>(
              data: googleSignIn, errorMessage: '');
        } else {
          return const FirebaseResponse<UserCredential>(
              errorMessage: 'Some Error Occured, Please try again');
        }
      }
    } on FirebaseAuthException catch (e) {
      return FirebaseResponse(errorMessage: e.toString());
    } on PlatformException catch (e) {
      debugPrint("error while google signin $e");
      return const FirebaseResponse(
          errorMessage: "Some Error Occured, Please try again");
    }
  }
}

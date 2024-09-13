import 'dart:io';
import 'package:employeemanager/constant/navigation_service.dart';
import 'package:employeemanager/core/repository/firestore_repo.dart';
import 'package:employeemanager/core/repository/user_firestore_repo.dart';
import 'package:employeemanager/feature/auth/providers/user_provider.dart';
import 'package:employeemanager/feature/auth/repository/auth_firebase_repo.dart';
import 'package:employeemanager/feature/auth/repository/firestorage_repo.dart';
import 'package:employeemanager/models/employee_manager_user.dart';
import 'package:employeemanager/response/firebase_response/firebase_response_model.dart';
import 'package:employeemanager/response/response.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'auth_state.dart';

class AuthNotifier extends Notifier<AuthState> {
  final FirebaseAuthRepo authRepo;
  final FirebaseReference firebaseReference;

  String verificationId = '';

  AuthNotifier(
    this.authRepo,
    this.firebaseReference,
  ) : super();

  Future<EmployeeManagerUser?> isFirebaseUser(String userId) async {
    final userRepo = UserFirebaseRepository(firebaseReference);
    final user = await userRepo.fetchUser(userId);

    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  Future<void> deleteUser() async {
    final userId = ref.read(userProvider)?.id;
    try {
      await firebaseReference.users.doc(userId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    authRepo.signOutUser();

    state = AuthState.initial();
    ref.read(userProvider.notifier).state = null;
  }

  Future<Response> loginUser(String email, String password) async {
    state = state.copyWith(isLoading: true);

    final firebaseResponse = await authRepo.loginUserWithEmail(email, password);
    if (firebaseResponse.data != null) {
      final user = await isFirebaseUser(firebaseResponse.data!.user!.uid);
      if (user != null) {
        ref.read(userProvider.notifier).state = user;
        state = state.copyWith(
          isLoading: false,
          user: firebaseResponse.data!.user,
          navigateToHome: true,
        );

        return const Response(isSuccess: true, errorMessage: '');
      } else {
        state = state.copyWith(
          isLoading: false,
          user: firebaseResponse.data!.user,
          errorMessage: null,
        );

        NavigationService.navigatorKey.currentState?.pop();
        return Response(
            isSuccess: false, errorMessage: firebaseResponse.errorMessage);
      }
    } else {
      state = state.copyWith(
          isLoading: false, errorMessage: firebaseResponse.errorMessage);
      NavigationService.navigatorKey.currentState?.pop();

      return Response(
          isSuccess: false, errorMessage: firebaseResponse.errorMessage);
    }
  }

  Future<Response> signupUser(String email, String password) async {
    state = state.copyWith(isLoading: true);
    final firebaseResponse =
        await authRepo.signupUserWithEmail(email, password);

    if (firebaseResponse.data != null) {
      final user = await isFirebaseUser(firebaseResponse.data!.user!.uid);
      if (user != null) {
        ref.read(userProvider.notifier).state = user;
        state = state.copyWith(
          isLoading: false,
          user: firebaseResponse.data!.user,
          errorMessage: null,
          navigateToHome: true,
        );
        NavigationService.navigatorKey.currentState?.pop();
        return const Response(isSuccess: true, errorMessage: '');
      } else {
        state = state.copyWith(
          isLoading: false,
          user: firebaseResponse.data?.user,
          errorMessage: null,
          navigateToHome: false,
        );
        NavigationService.navigatorKey.currentState?.pop();

        return Response(
            isSuccess: false, errorMessage: firebaseResponse.errorMessage);
      }
    } else {
      state = state.copyWith(
          isLoading: false, errorMessage: firebaseResponse.errorMessage);
      NavigationService.navigatorKey.currentState?.pop();
      return Response(
          isSuccess: false, errorMessage: firebaseResponse.errorMessage);
    }
  }

  void setEmployeeUser({
    String? id,
    String? name,
    String? phoneNo,
    String? currentAddress,
    String? email,
    String? profilePic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) async {
    final user = ref.read(userProvider);
    if (user != null) {
      EmployeeManagerUser? newEmployeeManagerUser = user.copyWith(
        id: id ?? user.id,
        name: name ?? user.name,
        email: email ?? user.email,
        phoneNo: phoneNo ?? user.phoneNo,
        profilePic: profilePic ?? user.profilePic,
        createdAt: createdAt ?? DateTime.now(),
        currentAddress: currentAddress ?? user.currentAddress,
      );
      ref.read(userProvider.notifier).state = newEmployeeManagerUser;
    } else {
      EmployeeManagerUser? newEmployeeManagerUser = EmployeeManagerUser(
        id: id ?? "",
        name: name ?? "",
        email: email ?? "",
        phoneNo: phoneNo ?? "",
        profilePic: profilePic ?? "",
        currentAddress: currentAddress ?? '',
        createdAt: createdAt ?? DateTime.now(),
      );
      ref.read(userProvider.notifier).state = newEmployeeManagerUser;
    }
  }

  Future<Response> savingEmployeeUserAndImage({
    File? selectimage,
    String? userId,
    String? name,
    String? phoneNo,
    String? currentAddress,
    String? email,
    DateTime? createdAt,
  }) async {
    final auth = FirebaseAuth.instance;
    final authEmail = auth.currentUser?.email;
    FirebaseResponse<String> firebaseresponse =
        const FirebaseResponse(errorMessage: '');

    if (selectimage != null) {
      final firebase = FireStorageRepo();
      firebaseresponse = await firebase.uploadImage(
          selectimage, "images/profile-pics/$userId");

      setEmployeeUser(
        name: name,
        phoneNo: phoneNo,
        currentAddress: currentAddress,
        email: email ?? authEmail,
        createdAt: DateTime.now(),
        profilePic: firebaseresponse.data,
        id: userId,
      );
    }
    if (selectimage == null) {
      setEmployeeUser(
        name: name,
        phoneNo: phoneNo,
        currentAddress: currentAddress,
        email: email ?? authEmail,
        createdAt: DateTime.now(),
        profilePic: firebaseresponse.data,
        id: userId,
      );
    }

    return Response(
        isSuccess: true, errorMessage: firebaseresponse.errorMessage);
  }

  Future<Response> saveEmployeeUser() async {
    final user = ref.read(userProvider);
    final userRepo = UserFirebaseRepository(firebaseReference);
    final response = await userRepo.saveUser(user!);
    NavigationService.navigatorKey.currentState?.pop();
    return Response(isSuccess: false, errorMessage: response.errorMessage);
  }

  Future<EmployeeManagerUser?> fetchInvestNetworkUser(String uid) async {
    final userRepo = UserFirebaseRepository(firebaseReference);
    final invesNetworkUser = await userRepo.fetchUser(uid);
    ref.read(userProvider.notifier).state = invesNetworkUser;
    return invesNetworkUser;
  }

  void saveAuthUser(User? user) async {
    state = state.copyWith(user: user);
  }

  @override
  AuthState build() {
    return AuthState.initial();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(FirebaseAuthRepo(), FirebaseReference()),
);

import 'package:employeemanager/core/repository/firestore_repo.dart';
import 'package:employeemanager/models/employee_manager_user.dart';
import 'package:employeemanager/response/firebase_response/firebase_response_model.dart';

class UserFirebaseRepository {
  final FirebaseReference firebaseReference;

  UserFirebaseRepository(this.firebaseReference);

  Future<FirebaseResponse<void>> saveUser(EmployeeManagerUser user) async {
    try {
      await firebaseReference.users.doc(user.id).set(user);
      return const FirebaseResponse<void>(errorMessage: '');
    } catch (e) {
      return FirebaseResponse(errorMessage: e.toString());
    }
  }

  Future<EmployeeManagerUser?> fetchUser(String userId) async {
    try {
      final data = await firebaseReference.users.doc(userId).get();
      return data.data();
    } catch (e) {
      return null;
    }
  }
}

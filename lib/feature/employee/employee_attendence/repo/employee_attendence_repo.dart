import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/core/repository/firestore_repo.dart';
import 'package:employeemanager/models/employee_attendence.dart';
import 'package:employeemanager/response/firebase_response/firebase_response_model.dart';

class EmployeeAttendenceFirebaseRepository {
  final FirebaseReference firebaseReference;

  EmployeeAttendenceFirebaseRepository(this.firebaseReference);

  Future<FirebaseResponse> updateAttendenceEmployee(
      String userId, EmployeeAttendence employeeAttendence) async {
    try {
      await firebaseReference.employee.doc(userId).update({
        'employeeAttendence':
            FieldValue.arrayUnion([employeeAttendence.toJson()]),
      }).catchError((err) {
        print(err);
      }).then((value) {
        print("Employee Attendence Updated");
        return const FirebaseResponse<void>(errorMessage: '');
      });
    } catch (e) {
      print(e);
    }
    return const FirebaseResponse<void>(errorMessage: '');
  }
}

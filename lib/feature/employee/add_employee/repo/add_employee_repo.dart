import 'package:employeemanager/core/repository/firestore_repo.dart';
import 'package:employeemanager/models/employee.dart';
import 'package:employeemanager/response/firebase_response/firebase_response_model.dart';

class EmployeeFirebaseRepository {
  final FirebaseReference firebaseReference;

  EmployeeFirebaseRepository(this.firebaseReference);

  Future<FirebaseResponse<void>> saveEmployee(Employee employee) async {
    try {
      await firebaseReference.employee.doc(employee.id).set(employee);
      return const FirebaseResponse<void>(errorMessage: '');
    } catch (e) {
      return FirebaseResponse(errorMessage: e.toString());
    }
  }

  Future<void> deleteEmployee(String employeeid) async {
    try {
      await firebaseReference.employee.doc(employeeid).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<FirebaseResponse<List<Employee>>> fetchAllEmployees(
      String userId) async {
    try {
      final querySnapshot = await firebaseReference.employee
          .where('userId', isEqualTo: userId)
          .get();
      // final querySnapshot = await firebaseReference.employee.get();
      final List<Employee> employees = [];
      for (var doc in querySnapshot.docs) {
        final employee = doc.data();
        employees.add(employee);
      }

      return FirebaseResponse<List<Employee>>(
          data: employees, errorMessage: '');
    } catch (e) {
      return FirebaseResponse(errorMessage: e.toString());
    }
  }
}

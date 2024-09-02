import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employeemanager/models/employee.dart';
import 'package:employeemanager/models/employee_manager_user.dart';

class FirebaseReference {
  FirebaseReference();
  final firestore = FirebaseFirestore.instance;

  DocumentReference get database =>
      firestore.collection("Production").doc("EmployeeManager");

  CollectionReference<EmployeeManagerUser> get users =>
      database.collection("Users").withConverter<EmployeeManagerUser>(
            fromFirestore: (snapshot, _) => EmployeeManagerUser.fromJson(
              snapshot.data() ?? {},
            ),
            toFirestore: (user, _) => user.toJson(),
          );
  CollectionReference<Employee> get employee =>
      database.collection("Employee").withConverter<Employee>(
            fromFirestore: (snapshot, _) => Employee.fromJson(
              snapshot.data() ?? {},
            ),
            toFirestore: (employee, _) => employee.toJson(),
          );
}

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:employeemanager/core/repository/firestore_repo.dart';
// import 'package:employeemanager/feature/auth/providers/user_provider.dart';
// import 'package:employeemanager/feature/employee/add_employee/provider/employee_provider.dart';
// import 'package:employeemanager/feature/employee/employee_attendence/repo/employee_attendence_repo.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:employeemanager/models/employee.dart';
// import 'package:employeemanager/models/employee_attendence.dart';

// class AttendenceState {
//   EmployeeAttendenceStatus? employeeAttendenceStatus;
//   EmployeeAttendence? employeeAttendence;

//   AttendenceState(
//       {required this.employeeAttendenceStatus,
//       required this.employeeAttendence});
//   factory AttendenceState.initial() =>
//       AttendenceState(employeeAttendenceStatus: null, employeeAttendence: null);

//   AttendenceState copyWith({
//     EmployeeAttendenceStatus? employeeAttendenceStatus,
//     EmployeeAttendence? employeeAttendence,
//   }) {
//     return AttendenceState(
//       employeeAttendenceStatus:
//           employeeAttendenceStatus ?? this.employeeAttendenceStatus,
//       employeeAttendence: employeeAttendence ?? this.employeeAttendence,
//     );
//   }
// }

// class AttendenceProvider extends Notifier<AttendenceState> {
//   final FirebaseReference firebaseReference;
//   AttendenceProvider({required this.firebaseReference});
//   void setAttendence(EmployeeAttendenceStatus employeeAttendence) {
//     state = state.copyWith(employeeAttendenceStatus: employeeAttendence);
//   }

//   Future<void> updateAttendence(String employeeId) async {
//     // final userId = ref.read(userProvider)?.id ?? '';
//     final employeeAttendenceRepo =
//         EmployeeAttendenceFirebaseRepository(firebaseReference);

//     final employeeAttendence = EmployeeAttendence(
//       dateTime: DateTime.now(),
//       status: state.employeeAttendenceStatus!,
//     );
//     await employeeAttendenceRepo.updateAttendenceEmployee(
//         employeeId, employeeAttendence);
//     state = state.copyWith(employeeAttendence: employeeAttendence);
//   }

//   @override
//   AttendenceState build() {
//     return AttendenceState.initial();
//   }
// }

// final attendenceProvider =
//     NotifierProvider<AttendenceProvider, AttendenceState>(
//         () => AttendenceProvider(firebaseReference: FirebaseReference()));

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:employeemanager/feature/employee/employee_attendence/repo/employee_attendence_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:employeemanager/constant/navigation_service.dart';
import 'package:employeemanager/core/repository/firestore_repo.dart';
import 'package:employeemanager/feature/auth/providers/user_provider.dart';
import 'package:employeemanager/feature/auth/repository/firestorage_repo.dart';
import 'package:employeemanager/feature/employee/add_employee/provider/employee_provider.dart';
import 'package:employeemanager/feature/employee/add_employee/repo/add_employee_repo.dart';
import 'package:employeemanager/models/employee.dart';
import 'package:employeemanager/models/employee_attendence.dart';
import 'package:employeemanager/response/firebase_response/firebase_response_model.dart';
import 'package:employeemanager/response/response.dart';
import 'package:intl/intl.dart';

final addEmployeeProvider = NotifierProvider<AddEmployee, AddEmployeeState>(
  () => AddEmployee(firebaseReference: FirebaseReference()),
);

class AddEmployeeState {
  final List<Employee> employeeList;
  final bool isLoading;
  final String? errorMessage;
  EmployeeAttendenceStatus? employeeAttendenceStatus;
  EmployeeAttendence? employeeAttendence;

  AddEmployeeState({
    required this.employeeList,
    required this.errorMessage,
    required this.isLoading,
    this.employeeAttendence,
    this.employeeAttendenceStatus,
  });

  AddEmployeeState copyWith({
    List<Employee>? employeeList,
    bool? isLoading,
    String? errorMessage,
    EmployeeAttendenceStatus? employeeAttendenceStatus,
    EmployeeAttendence? employeeAttendence,
  }) {
    return AddEmployeeState(
      employeeList: employeeList ?? this.employeeList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      employeeAttendenceStatus:
          employeeAttendenceStatus ?? this.employeeAttendenceStatus,
      employeeAttendence: employeeAttendence ?? this.employeeAttendence,
    );
  }

  factory AddEmployeeState.initial() => AddEmployeeState(
        employeeList: [],
        isLoading: false,
        errorMessage: '',
        employeeAttendenceStatus: EmployeeAttendenceStatus.present,
      );
}

class AddEmployee extends Notifier<AddEmployeeState> {
  final FirebaseReference firebaseReference;

  AddEmployee({required this.firebaseReference});

  Future<Response> addEmployee({
    required String id,
    required String userId,
    required String cnicId,
    required String fullName,
    required String designation,
    required int mobileNo,
    required int pay,
    String? address,
    String? details,
    File? selectedImage,
  }) async {
    FirebaseResponse<String> firebaseresponse =
        const FirebaseResponse(errorMessage: '');

    if (selectedImage != null) {
      final firebase = FireStorageRepo();
      firebaseresponse =
          await firebase.uploadImage(selectedImage, "images/employee/$id");
    }
    Employee newEmployee = Employee(
      id: id,
      userId: userId,
      cnicId: cnicId,
      name: fullName,
      designation: designation,
      phoneNo: mobileNo,
      pay: pay,
      adress: address ?? '',
      employeePic: firebaseresponse.data,
      createdAt: DateTime.now(),
    );

    final addProperty = [...state.employeeList, newEmployee];
    state = state.copyWith(employeeList: addProperty);
    ref.read(employeeProvider.notifier).state = newEmployee;
    await saveEmployee(newEmployee);
    NavigationService.navigatorKey.currentState?.pop();
    return const Response(isSuccess: true, errorMessage: '');
  }

  Future<Response> saveEmployee(employee) async {
    final employeeRepo = EmployeeFirebaseRepository(firebaseReference);
    final response = await employeeRepo.saveEmployee(employee);
    return Response(isSuccess: true, errorMessage: response.errorMessage);
  }

  Future<Response> deleteEmployee(String employeeId) async {
    final employeeRepo = EmployeeFirebaseRepository(firebaseReference);
    final employeeList = [...state.employeeList];
    final employeeIndex = employeeList.indexWhere((e) {
      return e.id == employeeId;
    });
    employeeList.removeAt(employeeIndex);
    state = state.copyWith(employeeList: employeeList);
    await employeeRepo.deleteEmployee(employeeId);
    return const Response(isSuccess: true, errorMessage: '');
  }

  Future<FirebaseResponse<List<Employee>>> fetchAllEmployee() async {
    final userId = ref.read(userProvider)?.id ?? '';
    final employeeRepo = EmployeeFirebaseRepository(firebaseReference);
    final response = await employeeRepo.fetchAllEmployees(userId);
    state = state.copyWith(
        isLoading: false, errorMessage: null, employeeList: response.data);
    return FirebaseResponse(
      data: response.data,
      errorMessage: response.errorMessage,
    );
  }

  void setAttendence(EmployeeAttendenceStatus employeeAttendence) {
    state = state.copyWith(employeeAttendenceStatus: employeeAttendence);
  }

  Future<Response> updateAttendence(
      String employeeId,
      int taxDebit,
      int bonus,
      int totalPayment,
      DateTime dateTime,
      EmployeeAttendenceStatus status) async {
    final employeeAttendenceRepo =
        EmployeeAttendenceFirebaseRepository(firebaseReference);

    final dateFormatted = DateFormat('dd MMMM y').format(dateTime);
    final employeeIndex = state.employeeList.indexWhere(
      (element) => element.id == employeeId,
    );

    final existingAttendenceIndex = state
        .employeeList[employeeIndex].employeeAttendence
        .indexWhere((att) => att.dateTime == dateFormatted);

    if (existingAttendenceIndex != -1) {
      // Update existing attendance
      final updatedAttendance = state.employeeList[employeeIndex]
          .employeeAttendence[existingAttendenceIndex]
          .copyWith(
        status: status,
        bonus: bonus,
        taxDebit: taxDebit,
        totalPayment: totalPayment,
      );

      final updatedAttendences = List<EmployeeAttendence>.from(
          state.employeeList[employeeIndex].employeeAttendence);
      updatedAttendences[existingAttendenceIndex] = updatedAttendance;

      final updatedEmployee = state.employeeList[employeeIndex].copyWith(
        employeeAttendence: updatedAttendences,
      );

      final List<Employee> updatedEmployees = [...state.employeeList];
      updatedEmployees[employeeIndex] = updatedEmployee;

      state = state.copyWith(employeeList: updatedEmployees);

      final response = await employeeAttendenceRepo.updateAttendenceEmployee(
          employeeId, updatedAttendance);

      return Response(isSuccess: true, errorMessage: response.errorMessage);
    } else {
      // Create new attendance if not exists
      final employeeAttendence = EmployeeAttendence(
        dateTime: dateFormatted,
        status: status,
        bonus: bonus,
        taxDebit: taxDebit,
        totalPayment: totalPayment,
      );

      final updatedEmployee = state.employeeList[employeeIndex].copyWith(
        employeeAttendence: [
          ...state.employeeList[employeeIndex].employeeAttendence,
          employeeAttendence,
        ],
      );
      final List<Employee> updatedEmployees = [...state.employeeList];
      updatedEmployees[employeeIndex] = updatedEmployee;
      final response = await employeeAttendenceRepo.updateAttendenceEmployee(
          employeeId, employeeAttendence);
      state = state.copyWith(employeeList: updatedEmployees);
      return Response(isSuccess: true, errorMessage: response.errorMessage);
    }
  }

  @override
  AddEmployeeState build() {
    return AddEmployeeState.initial();
  }
}

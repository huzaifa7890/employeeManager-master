import 'package:employeemanager/models/employee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'employee_attendence.freezed.dart';
part 'employee_attendence.g.dart';

@freezed
class EmployeeAttendence with _$EmployeeAttendence {
  const factory EmployeeAttendence({
    @Default(EmployeeAttendenceStatus.present) EmployeeAttendenceStatus status,
    @Default('') String dateTime,
    @Default(0) int bonus,
    @Default(0) int taxDebit,
    @Default(0) int totalPayment,
  }) = _EmployeeAttendence;
  factory EmployeeAttendence.fromJson(Map<String, dynamic> json) =>
      _$EmployeeAttendenceFromJson(json);
}

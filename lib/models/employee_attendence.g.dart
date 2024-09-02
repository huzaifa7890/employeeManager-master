// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_attendence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeAttendenceImpl _$$EmployeeAttendenceImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeAttendenceImpl(
      status: $enumDecodeNullable(
              _$EmployeeAttendenceStatusEnumMap, json['status']) ??
          EmployeeAttendenceStatus.present,
      dateTime: json['dateTime'] as String? ?? '',
      bonus: json['bonus'] as int? ?? 0,
      taxDebit: json['taxDebit'] as int? ?? 0,
      totalPayment: json['totalPayment'] as int? ?? 0,
    );

Map<String, dynamic> _$$EmployeeAttendenceImplToJson(
        _$EmployeeAttendenceImpl instance) =>
    <String, dynamic>{
      'status': _$EmployeeAttendenceStatusEnumMap[instance.status]!,
      'dateTime': instance.dateTime,
      'bonus': instance.bonus,
      'taxDebit': instance.taxDebit,
      'totalPayment': instance.totalPayment,
    };

const _$EmployeeAttendenceStatusEnumMap = {
  EmployeeAttendenceStatus.present: 'present',
  EmployeeAttendenceStatus.absent: 'absent',
  EmployeeAttendenceStatus.half: 'half',
  EmployeeAttendenceStatus.double: 'double',
  EmployeeAttendenceStatus.overtime: 'overtime',
};

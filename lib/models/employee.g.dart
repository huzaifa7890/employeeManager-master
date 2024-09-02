// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeImpl _$$EmployeeImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      cnicId: json['cnicId'] as String,
      name: json['name'] as String? ?? '',
      designation: json['designation'] as String? ?? '',
      phoneNo: json['phoneNo'] as int? ?? 0,
      pay: json['pay'] as int? ?? 0,
      adress: json['adress'] as String? ?? '',
      employeePic: json['employeePic'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      employeeAttendence: (json['employeeAttendence'] as List<dynamic>?)
              ?.map(
                  (e) => EmployeeAttendence.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$EmployeeImplToJson(_$EmployeeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'cnicId': instance.cnicId,
      'name': instance.name,
      'designation': instance.designation,
      'phoneNo': instance.phoneNo,
      'pay': instance.pay,
      'adress': instance.adress,
      'employeePic': instance.employeePic,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'employeeAttendence': instance.employeeAttendence,
    };

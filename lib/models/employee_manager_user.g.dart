// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_manager_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeManagerUserImpl _$$EmployeeManagerUserImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeManagerUserImpl(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      currentAddress: json['currentAddress'] as String? ?? '',
      phoneNo: json['phoneNo'] as String? ?? '',
      email: json['email'] as String,
      profilePic: json['profilePic'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      accessToken: json['accessToken'] as String? ?? '',
    );

Map<String, dynamic> _$$EmployeeManagerUserImplToJson(
        _$EmployeeManagerUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currentAddress': instance.currentAddress,
      'phoneNo': instance.phoneNo,
      'email': instance.email,
      'profilePic': instance.profilePic,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'accessToken': instance.accessToken,
    };

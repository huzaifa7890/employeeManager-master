import 'package:freezed_annotation/freezed_annotation.dart';
part 'employee_manager_user.freezed.dart';
part 'employee_manager_user.g.dart';

@freezed
class EmployeeManagerUser with _$EmployeeManagerUser {
  const factory EmployeeManagerUser({
    required String id,
    @Default('') String? name,
    @Default('') String? currentAddress,
    @Default('') String phoneNo,
    required String email,
    @Default('') String? profilePic,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default('') String accessToken,
  }) = _EmployeeManagerUser;
  factory EmployeeManagerUser.fromJson(Map<String, dynamic> json) =>
      _$EmployeeManagerUserFromJson(json);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return _Employee.fromJson(json);
}

/// @nodoc
mixin _$Employee {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get cnicId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get designation => throw _privateConstructorUsedError;
  int get phoneNo => throw _privateConstructorUsedError;
  int get pay => throw _privateConstructorUsedError;
  String? get adress => throw _privateConstructorUsedError;
  String? get employeePic => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<EmployeeAttendence> get employeeAttendence =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeCopyWith<Employee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeCopyWith<$Res> {
  factory $EmployeeCopyWith(Employee value, $Res Function(Employee) then) =
      _$EmployeeCopyWithImpl<$Res, Employee>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String cnicId,
      String? name,
      String? designation,
      int phoneNo,
      int pay,
      String? adress,
      String? employeePic,
      DateTime createdAt,
      DateTime? updatedAt,
      List<EmployeeAttendence> employeeAttendence});
}

/// @nodoc
class _$EmployeeCopyWithImpl<$Res, $Val extends Employee>
    implements $EmployeeCopyWith<$Res> {
  _$EmployeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cnicId = null,
    Object? name = freezed,
    Object? designation = freezed,
    Object? phoneNo = null,
    Object? pay = null,
    Object? adress = freezed,
    Object? employeePic = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? employeeAttendence = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cnicId: null == cnicId
          ? _value.cnicId
          : cnicId // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as int,
      pay: null == pay
          ? _value.pay
          : pay // ignore: cast_nullable_to_non_nullable
              as int,
      adress: freezed == adress
          ? _value.adress
          : adress // ignore: cast_nullable_to_non_nullable
              as String?,
      employeePic: freezed == employeePic
          ? _value.employeePic
          : employeePic // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      employeeAttendence: null == employeeAttendence
          ? _value.employeeAttendence
          : employeeAttendence // ignore: cast_nullable_to_non_nullable
              as List<EmployeeAttendence>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeImplCopyWith<$Res>
    implements $EmployeeCopyWith<$Res> {
  factory _$$EmployeeImplCopyWith(
          _$EmployeeImpl value, $Res Function(_$EmployeeImpl) then) =
      __$$EmployeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String cnicId,
      String? name,
      String? designation,
      int phoneNo,
      int pay,
      String? adress,
      String? employeePic,
      DateTime createdAt,
      DateTime? updatedAt,
      List<EmployeeAttendence> employeeAttendence});
}

/// @nodoc
class __$$EmployeeImplCopyWithImpl<$Res>
    extends _$EmployeeCopyWithImpl<$Res, _$EmployeeImpl>
    implements _$$EmployeeImplCopyWith<$Res> {
  __$$EmployeeImplCopyWithImpl(
      _$EmployeeImpl _value, $Res Function(_$EmployeeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cnicId = null,
    Object? name = freezed,
    Object? designation = freezed,
    Object? phoneNo = null,
    Object? pay = null,
    Object? adress = freezed,
    Object? employeePic = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? employeeAttendence = null,
  }) {
    return _then(_$EmployeeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cnicId: null == cnicId
          ? _value.cnicId
          : cnicId // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      designation: freezed == designation
          ? _value.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNo: null == phoneNo
          ? _value.phoneNo
          : phoneNo // ignore: cast_nullable_to_non_nullable
              as int,
      pay: null == pay
          ? _value.pay
          : pay // ignore: cast_nullable_to_non_nullable
              as int,
      adress: freezed == adress
          ? _value.adress
          : adress // ignore: cast_nullable_to_non_nullable
              as String?,
      employeePic: freezed == employeePic
          ? _value.employeePic
          : employeePic // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      employeeAttendence: null == employeeAttendence
          ? _value._employeeAttendence
          : employeeAttendence // ignore: cast_nullable_to_non_nullable
              as List<EmployeeAttendence>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeImpl implements _Employee {
  const _$EmployeeImpl(
      {required this.id,
      required this.userId,
      required this.cnicId,
      this.name = '',
      this.designation = '',
      this.phoneNo = 0,
      this.pay = 0,
      this.adress = '',
      this.employeePic = '',
      required this.createdAt,
      this.updatedAt,
      final List<EmployeeAttendence> employeeAttendence = const []})
      : _employeeAttendence = employeeAttendence;

  factory _$EmployeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String cnicId;
  @override
  @JsonKey()
  final String? name;
  @override
  @JsonKey()
  final String? designation;
  @override
  @JsonKey()
  final int phoneNo;
  @override
  @JsonKey()
  final int pay;
  @override
  @JsonKey()
  final String? adress;
  @override
  @JsonKey()
  final String? employeePic;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  final List<EmployeeAttendence> _employeeAttendence;
  @override
  @JsonKey()
  List<EmployeeAttendence> get employeeAttendence {
    if (_employeeAttendence is EqualUnmodifiableListView)
      return _employeeAttendence;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_employeeAttendence);
  }

  @override
  String toString() {
    return 'Employee(id: $id, userId: $userId, cnicId: $cnicId, name: $name, designation: $designation, phoneNo: $phoneNo, pay: $pay, adress: $adress, employeePic: $employeePic, createdAt: $createdAt, updatedAt: $updatedAt, employeeAttendence: $employeeAttendence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cnicId, cnicId) || other.cnicId == cnicId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.phoneNo, phoneNo) || other.phoneNo == phoneNo) &&
            (identical(other.pay, pay) || other.pay == pay) &&
            (identical(other.adress, adress) || other.adress == adress) &&
            (identical(other.employeePic, employeePic) ||
                other.employeePic == employeePic) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._employeeAttendence, _employeeAttendence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      cnicId,
      name,
      designation,
      phoneNo,
      pay,
      adress,
      employeePic,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_employeeAttendence));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeImplCopyWith<_$EmployeeImpl> get copyWith =>
      __$$EmployeeImplCopyWithImpl<_$EmployeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeImplToJson(
      this,
    );
  }
}

abstract class _Employee implements Employee {
  const factory _Employee(
      {required final String id,
      required final String userId,
      required final String cnicId,
      final String? name,
      final String? designation,
      final int phoneNo,
      final int pay,
      final String? adress,
      final String? employeePic,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final List<EmployeeAttendence> employeeAttendence}) = _$EmployeeImpl;

  factory _Employee.fromJson(Map<String, dynamic> json) =
      _$EmployeeImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get cnicId;
  @override
  String? get name;
  @override
  String? get designation;
  @override
  int get phoneNo;
  @override
  int get pay;
  @override
  String? get adress;
  @override
  String? get employeePic;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<EmployeeAttendence> get employeeAttendence;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeImplCopyWith<_$EmployeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

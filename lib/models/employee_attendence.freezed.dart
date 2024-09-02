// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_attendence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeeAttendence _$EmployeeAttendenceFromJson(Map<String, dynamic> json) {
  return _EmployeeAttendence.fromJson(json);
}

/// @nodoc
mixin _$EmployeeAttendence {
  EmployeeAttendenceStatus get status => throw _privateConstructorUsedError;
  String get dateTime => throw _privateConstructorUsedError;
  int get bonus => throw _privateConstructorUsedError;
  int get taxDebit => throw _privateConstructorUsedError;
  int get totalPayment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeAttendenceCopyWith<EmployeeAttendence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeAttendenceCopyWith<$Res> {
  factory $EmployeeAttendenceCopyWith(
          EmployeeAttendence value, $Res Function(EmployeeAttendence) then) =
      _$EmployeeAttendenceCopyWithImpl<$Res, EmployeeAttendence>;
  @useResult
  $Res call(
      {EmployeeAttendenceStatus status,
      String dateTime,
      int bonus,
      int taxDebit,
      int totalPayment});
}

/// @nodoc
class _$EmployeeAttendenceCopyWithImpl<$Res, $Val extends EmployeeAttendence>
    implements $EmployeeAttendenceCopyWith<$Res> {
  _$EmployeeAttendenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? dateTime = null,
    Object? bonus = null,
    Object? taxDebit = null,
    Object? totalPayment = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EmployeeAttendenceStatus,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as int,
      taxDebit: null == taxDebit
          ? _value.taxDebit
          : taxDebit // ignore: cast_nullable_to_non_nullable
              as int,
      totalPayment: null == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeAttendenceImplCopyWith<$Res>
    implements $EmployeeAttendenceCopyWith<$Res> {
  factory _$$EmployeeAttendenceImplCopyWith(_$EmployeeAttendenceImpl value,
          $Res Function(_$EmployeeAttendenceImpl) then) =
      __$$EmployeeAttendenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EmployeeAttendenceStatus status,
      String dateTime,
      int bonus,
      int taxDebit,
      int totalPayment});
}

/// @nodoc
class __$$EmployeeAttendenceImplCopyWithImpl<$Res>
    extends _$EmployeeAttendenceCopyWithImpl<$Res, _$EmployeeAttendenceImpl>
    implements _$$EmployeeAttendenceImplCopyWith<$Res> {
  __$$EmployeeAttendenceImplCopyWithImpl(_$EmployeeAttendenceImpl _value,
      $Res Function(_$EmployeeAttendenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? dateTime = null,
    Object? bonus = null,
    Object? taxDebit = null,
    Object? totalPayment = null,
  }) {
    return _then(_$EmployeeAttendenceImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EmployeeAttendenceStatus,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as int,
      taxDebit: null == taxDebit
          ? _value.taxDebit
          : taxDebit // ignore: cast_nullable_to_non_nullable
              as int,
      totalPayment: null == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeAttendenceImpl implements _EmployeeAttendence {
  const _$EmployeeAttendenceImpl(
      {this.status = EmployeeAttendenceStatus.present,
      this.dateTime = '',
      this.bonus = 0,
      this.taxDebit = 0,
      this.totalPayment = 0});

  factory _$EmployeeAttendenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeAttendenceImplFromJson(json);

  @override
  @JsonKey()
  final EmployeeAttendenceStatus status;
  @override
  @JsonKey()
  final String dateTime;
  @override
  @JsonKey()
  final int bonus;
  @override
  @JsonKey()
  final int taxDebit;
  @override
  @JsonKey()
  final int totalPayment;

  @override
  String toString() {
    return 'EmployeeAttendence(status: $status, dateTime: $dateTime, bonus: $bonus, taxDebit: $taxDebit, totalPayment: $totalPayment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendenceImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.bonus, bonus) || other.bonus == bonus) &&
            (identical(other.taxDebit, taxDebit) ||
                other.taxDebit == taxDebit) &&
            (identical(other.totalPayment, totalPayment) ||
                other.totalPayment == totalPayment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, dateTime, bonus, taxDebit, totalPayment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeAttendenceImplCopyWith<_$EmployeeAttendenceImpl> get copyWith =>
      __$$EmployeeAttendenceImplCopyWithImpl<_$EmployeeAttendenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeAttendenceImplToJson(
      this,
    );
  }
}

abstract class _EmployeeAttendence implements EmployeeAttendence {
  const factory _EmployeeAttendence(
      {final EmployeeAttendenceStatus status,
      final String dateTime,
      final int bonus,
      final int taxDebit,
      final int totalPayment}) = _$EmployeeAttendenceImpl;

  factory _EmployeeAttendence.fromJson(Map<String, dynamic> json) =
      _$EmployeeAttendenceImpl.fromJson;

  @override
  EmployeeAttendenceStatus get status;
  @override
  String get dateTime;
  @override
  int get bonus;
  @override
  int get taxDebit;
  @override
  int get totalPayment;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeAttendenceImplCopyWith<_$EmployeeAttendenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

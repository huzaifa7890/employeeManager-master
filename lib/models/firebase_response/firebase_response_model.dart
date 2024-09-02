import 'package:equatable/equatable.dart';

class FirebaseResponse<T> extends Equatable {
  final T? data;
  final String errorMessage;

  const FirebaseResponse({this.data, required this.errorMessage});

  @override
  List<Object?> get props => [data, errorMessage];
  FirebaseResponse copyWith({
    T? data,
    String? errorMessage,
  }) {
    return FirebaseResponse(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

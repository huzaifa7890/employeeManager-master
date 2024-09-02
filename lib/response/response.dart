import 'package:equatable/equatable.dart';

class Response<T> extends Equatable {
  final bool isSuccess;
  final String errorMessage;

  const Response({required this.isSuccess, required this.errorMessage});

  @override
  List<Object?> get props => [isSuccess, errorMessage];
  Response copyWith({
    bool? isSuccess,
    String? errorMessage,
  }) {
    return Response(
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

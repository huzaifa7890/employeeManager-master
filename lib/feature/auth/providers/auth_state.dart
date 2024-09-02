// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_provider.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isLoading;
  final String? errorMessage;
  final bool navigateToHome;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
    required this.navigateToHome,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
    bool? navigateToHome,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      navigateToHome: navigateToHome ?? this.navigateToHome,
    );
  }

  @override
  List<Object?> get props => [user, isLoading, errorMessage];
  factory AuthState.initial() => const AuthState(
        isLoading: false,
        navigateToHome: false,
      );
}

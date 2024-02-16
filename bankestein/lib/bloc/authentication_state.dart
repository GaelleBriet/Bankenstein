part of 'authentication_cubit.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationUnknown extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String accessToken;
  final String name;

  const AuthenticationAuthenticated(
      {required this.accessToken, required this.name});
}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message);
}

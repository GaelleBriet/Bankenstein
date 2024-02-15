part of 'authentication_cubit.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationUnknown extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String accessToken;

  const AuthenticationAuthenticated({required this.accessToken});
}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message);
}
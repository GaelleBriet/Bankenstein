part of 'authentication_cubit.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationUnknown extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String user;

  const AuthenticationAuthenticated({required this.user});
}

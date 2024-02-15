import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationUnknown()) {
    void login(String email, String password) {
      if (email == 'student@oclock.io' && password == 'password@student') {
        emit(AuthenticationAuthenticated(user: email));
      } else {
        emit(AuthenticationUnauthenticated());
      }
    }

    void logout() {
      emit(AuthenticationUnauthenticated());
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/authentication_data_source.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationUnknown());

  Future<void> login(String email, String password) async {
    try {
      String accessToken = await AuthenticationDataSource.login(
        email: email,
        password: password,
      );
      emit(AuthenticationAuthenticated(accessToken: accessToken));
    } catch (e) {
      emit(AuthenticationError('Failed to login'));
    }
  }

  void logout() {
    emit(AuthenticationUnauthenticated());
  }
}

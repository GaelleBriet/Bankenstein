import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/authentication_data_source.dart';
import 'account_cubit.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationUnknown());

  Future<void> login(String email, String password) async {
    try {
      final accessToken = await AuthenticationDataSource.login(
        email: email,
        password: password,
      );
      final userInfo = await AuthenticationDataSource.getUserInfo(accessToken);
      emit(AuthenticationAuthenticated(
          accessToken: accessToken,
          name: userInfo['name'],
          id: userInfo['id']));
    } catch (e) {
      emit(AuthenticationError('Failed to login'));
    }
  }

  void logout() {
    emit(AuthenticationUnauthenticated());
  }
}

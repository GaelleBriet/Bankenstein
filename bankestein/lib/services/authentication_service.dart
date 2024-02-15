import 'package:bankestein/data/authentication_data_source.dart';

abstract class AuthenticationService {
  static Future<void> login({
    required String email,
    required String password,
  }) =>
      AuthenticationDataSource.login(
        email: email,
        password: password,
      );

  static Stream<String?> authChanges() =>
      AuthenticationDataSource.authChanges();
}

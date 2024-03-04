import 'package:bankestein/bloc/account_cubit.dart';
import '../data/file_data_source.dart';

abstract class AccountService {
  static Future<void> exportRIB(
      AccountCubit accountCubit, String accessToken, int id) async {
    final account = await accountCubit.getAccountIban(accessToken, id);
    print('IBAN: $account.iban');
    print('Name: $account.name');
    await FileDataSource.exportAndSave(account.name, account.iban);
  }
}

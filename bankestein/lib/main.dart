import 'package:bankestein/bloc/authentication_cubit.dart';
import 'package:bankestein/bloc/recipient_cubit.dart';
import 'package:bankestein/bloc/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/account_cubit.dart';
import 'core/app_router.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String title = 'Bankenstein';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingCubit>(
          create: (context) => SettingCubit(),
        ),
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider<AccountCubit>(
          create: (context) =>
              AccountCubit(context.read<AuthenticationCubit>()),
        ),
        BlocProvider<RecipientCubit>(
          create: (context) => RecipientCubit(context.read<AuthenticationCubit>()),
        ),
      ],
      child: BlocBuilder<SettingCubit, ThemeData>(
        builder: (context, state) {
          // return Builder(builder: (context) {
          return MaterialApp.router(
            title: title,
            theme: state,
            routerConfig: AppRouter.routerOf(context),
          );
          // });
        },
      ),
    );
  }
}

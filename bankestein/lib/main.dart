import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return MaterialApp.router(
      title: title,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF711CCC),
        ),
        useMaterial3: false,
      ),
      routerConfig: AppRouter.router,
    );
  }
}

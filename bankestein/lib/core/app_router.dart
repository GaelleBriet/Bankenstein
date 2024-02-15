import 'package:go_router/go_router.dart';

import 'package:bankestein/views/login_view.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: LoginView.pageName,
        builder: (context, state) => const LoginView(),
      ),
    ],
  );
}
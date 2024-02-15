import 'dart:async';

import 'package:flutter/foundation.dart';

/// {@template go_router_refresh_stream}
/// A [ChangeNotifier] that notifies its listeners when a stream emits a value.
/// {@endtemplate}
class GoRouterRefreshStream extends ChangeNotifier {
  /// {@macro go_router_refresh_stream}
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

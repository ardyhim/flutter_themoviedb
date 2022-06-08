import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/model.dart';
import '../../routes/router.dart';
import '../state.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  RouterNotifier(this._ref) {
    _ref.listen<ModelUser?>(
      userProvider, // In our case, we're interested in the log in / log out events.
      (_, __) => notifyListeners(), // Obviously more logic can be added here
    );
  }

  /// IMPORTANT: conceptually, we want to use `ref.read` to read providers, here.
  /// GoRouter is already aware of state changes through `refreshListenable`
  /// We don't want to trigger a rebuild of the surrounding provider.
  String? redirectLogic(GoRouterState state) {
    final user = _ref.read(userProvider);

    // From here we can use the state and implement our custom logic
    final areWeLoggingIn = state.location == '/login';

    if (user == null) {
      // We're not logged in
      // So, IF we aren't in the login page, go there.
      return areWeLoggingIn ? null : '/login';
    }
    // We're logged in

    // At this point, IF we're in the login page, go to the home page
    if (areWeLoggingIn) return '/';

    // There's no need for a redirect at this point.
    return null;
  }

  List<GoRoute> get routes => router;
}

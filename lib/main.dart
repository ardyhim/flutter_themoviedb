import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/api.dart';
import 'provider/state.dart';
import 'shared/color_schemes.dart';
import 'shared/error.dart';
import 'shared/scroll_behavior.dart';
import 'shared/splash.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final hive = ref.watch(hiveProvider);
    return hive.when(
      data: (data) => MaterialApp.router(
        title: 'Flutter Movies',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        debugShowCheckedModeBanner: false,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        scrollBehavior: AppScrollBehavior(),
      ),
      error: (err, stack) {
        // print(err);
        return CustomError(
          error: err,
        );
      },
      loading: () => const Splash(),
    );
  }
}

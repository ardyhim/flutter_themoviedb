import 'package:contoh/routes/router.dart';
import 'package:contoh/shared/color_schemes.dart';
import 'package:contoh/shared/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        debugShowCheckedModeBanner: false,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        scrollBehavior: AppScrollBehavior(),
      ),
    );
  }
}

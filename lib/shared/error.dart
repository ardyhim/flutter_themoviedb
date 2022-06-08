import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'color_schemes.dart';

class CustomError extends StatelessWidget {
  CustomError({Key? key, required this.error}) : super(key: key);
  var error;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: Scaffold(
        body: Center(child: Text("$error")),
      ),
    );
  }
}

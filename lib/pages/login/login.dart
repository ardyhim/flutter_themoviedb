import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

import '../../shared/drawer_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://images.unsplash.com/photo-1478720568477-152d9b164e26?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black87.withOpacity(0.8),
                  // Colors.transparent,
                  // Colors.transparent,
                  Colors.black87.withOpacity(0.8),
                ],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth / 12,
                        ),
                        child: Text(
                          "Movies can and do have tremendous influence in shaping young lives in the realm of entertainment towards the ideals and objectives of normal adulthood.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth / 12,
                          vertical: 10,
                        ),
                        child: Text(
                          "Walt Disney",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 200,
                    // color: Theme.of(context).colorScheme.background,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // width: constraints,
                          // height: 100,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: TextFormField(
                            // controller: search,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) async {},
                            decoration: InputDecoration(
                              labelText: "Email",
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.email),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                                vertical: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  40,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // width: constraints,
                          // height: 100,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: TextFormField(
                            // controller: search,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.send,
                            obscureText: true,
                            onFieldSubmitted: (String value) async {},
                            decoration: InputDecoration(
                              labelText: "Password",
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.lock),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                                vertical: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  40,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          height: 70,
                          child: DrawerButton(
                            active: true,
                            onPressed: () {
                              GoRouter.of(context).goNamed("home");
                            },
                            text: "LOGIN",
                            textAlignment: TextAlignment.center,
                            // icon: const Icon(Icons.login_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

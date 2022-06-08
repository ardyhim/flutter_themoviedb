import 'package:contoh/provider/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../provider/api.dart';
import '../../shared/drawer_button.dart';
import '../../shared/text_button.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController(text: "");
  TextEditingController _password = TextEditingController(text: "");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter.of(context);
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return Stack(
          children: [
            Container(
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
                      child: Form(
                        key: _formKey,
                        onChanged: () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(validationLoginProvider.state).state =
                                true;
                          } else {
                            ref.read(validationLoginProvider.state).state =
                                false;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: TextFormField(
                                controller: _username,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: (String? v) {
                                  if (v == "") return "Username required";
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: "Username",
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: TextFormField(
                                controller: _password,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.send,
                                obscureText: true,
                                validator: (String? v) {
                                  if (v == "" || v!.length <= 4) {
                                    return "Invalid Password";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (String value) async {
                                  ref.read(isLoadingProvider.state).state =
                                      true;
                                  var api = ref.read(tmdbRepositoryProvider);
                                  final user = ref.read(userProvider.notifier);
                                  try {
                                    await user.login(
                                        tmdb: api.tmdb,
                                        username: _username.text,
                                        password: _password.text);
                                    ref.refresh(accountFutureProvider);
                                    ref.read(isLoadingProvider.state).state =
                                        false;
                                    router.goNamed("home");
                                  } catch (e) {
                                    ref.read(isLoadingProvider.state).state =
                                        false;
                                  }
                                },
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
                              child: SizedBox.expand(
                                child: Consumer(
                                    builder: (context, WidgetRef validator, _) {
                                  bool validation = ref
                                      .watch(validationLoginProvider.state)
                                      .state;
                                  return CustomTextButton(
                                    active: validation,
                                    onPressed: () async {
                                      ref.read(isLoadingProvider.state).state =
                                          true;
                                      var api =
                                          ref.read(tmdbRepositoryProvider);
                                      final user =
                                          ref.read(userProvider.notifier);
                                      try {
                                        await user.login(
                                            tmdb: api.tmdb,
                                            username: _username.text,
                                            password: _password.text);
                                        ref.refresh(accountFutureProvider);
                                        ref
                                            .read(isLoadingProvider.state)
                                            .state = false;
                                        router.goNamed("home");
                                      } catch (e) {
                                        print(e);
                                        ref
                                            .read(isLoadingProvider.state)
                                            .state = false;
                                      }
                                    },
                                    text: "LOGIN",
                                    // icon: const Icon(Icons.login_rounded),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer(
              builder: ((context, ref, child) {
                final isLoading = ref.watch(isLoadingProvider.state).state;
                return isLoading
                    ? Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        color: Colors.black87.withOpacity(0.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container();
              }),
            ),
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/state.dart';
import 'drawer_button.dart';
import 'icon_button.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter.of(context);
    return Consumer(
      builder: (context, ref, _) {
        bool isSidebar = ref.watch(sidebarProvider.state).state;
        final user = ref.read(userProvider.notifier);
        return SizedBox(
          width: isSidebar ? 300 : 80,
          height: size.height,
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: isSidebar
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        Tooltip(
                          verticalOffset: 40,
                          message: "Home",
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 20),
                            child: isSidebar
                                ? DrawerButton(
                                    active:
                                        router.location == "/" ? true : false,
                                    onPressed: () => router.goNamed("home"),
                                    text: "Home",
                                    icon: const Icon(
                                      Icons.home,
                                    ),
                                  )
                                : CustomIconButton(
                                    active:
                                        router.location == "/" ? true : false,
                                    icon: const Icon(Icons.home),
                                    onPressed: () => router.goNamed("home"),
                                  ),
                          ),
                        ),
                        Tooltip(
                          verticalOffset: 40,
                          message: "Tv Series",
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 20),
                            child: isSidebar
                                ? DrawerButton(
                                    active:
                                        router.location == "/tv" ? true : false,
                                    onPressed: () {
                                      router.goNamed(
                                        "tv",
                                      );
                                    },
                                    text: "Tv Series",
                                    icon: const Icon(
                                      Icons.tv,
                                    ),
                                  )
                                : CustomIconButton(
                                    active:
                                        router.location == "/tv" ? true : false,
                                    icon: const Icon(Icons.tv),
                                    onPressed: () {
                                      router.goNamed("tv");
                                    },
                                  ),
                          ),
                        ),
                        Tooltip(
                          verticalOffset: 40,
                          message: "Movies",
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 20),
                            child: isSidebar
                                ? DrawerButton(
                                    active: router.location == "/movies"
                                        ? true
                                        : false,
                                    onPressed: () => router.goNamed("movie"),
                                    text: "Movies",
                                    icon: const Icon(
                                      Icons.movie,
                                    ),
                                  )
                                : CustomIconButton(
                                    active: router.location == "/movies"
                                        ? true
                                        : false,
                                    icon: const Icon(Icons.movie),
                                    onPressed: () => router.goNamed("movie"),
                                  ),
                          ),
                        ),
                        Tooltip(
                          verticalOffset: 40,
                          message: "Categories",
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 20),
                            child: isSidebar
                                ? DrawerButton(
                                    active: router.location == "/categories"
                                        ? true
                                        : false,
                                    onPressed: () {},
                                    text: "Genres",
                                    icon: const Icon(
                                      Icons.category,
                                    ),
                                  )
                                : CustomIconButton(
                                    active: router.location == "/categories"
                                        ? true
                                        : false,
                                    icon: const Icon(Icons.category),
                                    onPressed: () {},
                                  ),
                          ),
                        ),
                        Tooltip(
                          verticalOffset: 40,
                          message: "Account",
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 20),
                            child: isSidebar
                                ? DrawerButton(
                                    active: router.location == "/account"
                                        ? true
                                        : false,
                                    onPressed: () {
                                      router.goNamed(
                                        "account",
                                      );
                                    },
                                    text: "Account",
                                    icon: const Icon(
                                      Icons.person,
                                    ),
                                  )
                                : CustomIconButton(
                                    active: router.location == "/account"
                                        ? true
                                        : false,
                                    icon: const Icon(Icons.person),
                                    onPressed: () {
                                      router.goNamed(
                                        "account",
                                      );
                                    },
                                  ),
                          ),
                        ),
                        Tooltip(
                          verticalOffset: 40,
                          message: "Minimize",
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 20),
                            child: isSidebar
                                ? DrawerButton(
                                    active: false,
                                    onPressed: () {
                                      final readSide =
                                          ref.read(sidebarProvider.state);
                                      readSide.state = false;
                                    },
                                    text: "Minimize",
                                    icon: const Icon(
                                      Icons.menu,
                                    ),
                                  )
                                : CustomIconButton(
                                    active: false,
                                    icon: const Icon(Icons.menu_open),
                                    onPressed: () {
                                      final readSide =
                                          ref.read(sidebarProvider.state);
                                      readSide.state = true;
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Tooltip(
                  verticalOffset: 40,
                  message: user.sessionId != "" ? "Sign Out" : "Sign In",
                  child: Container(
                    width: isSidebar ? 300 : 80,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Theme.of(context).colorScheme.surfaceTint),
                      ),
                    ),
                    child: isSidebar
                        ? DrawerButton(
                            active: router.location == "/login" ? true : false,
                            onPressed: () {
                              if (user.sessionId != "") {
                                user.logout();
                              } else {
                                router.goNamed("login");
                              }
                            },
                            text: user.sessionId != "" ? "Sign Out" : "Sign In",
                            icon: user.sessionId != ""
                                ? const Icon(Icons.logout_rounded)
                                : const Icon(Icons.login_rounded),
                          )
                        : CustomIconButton(
                            active: router.location == "/login" ? true : false,
                            icon: user.sessionId != ""
                                ? const Icon(Icons.logout_rounded)
                                : const Icon(Icons.login_rounded),
                            onPressed: () {
                              if (user.sessionId != "") {
                                user.logout();
                                router.goNamed("login");
                              } else {
                                router.goNamed("login");
                              }
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

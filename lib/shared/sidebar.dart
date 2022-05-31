import 'package:contoh/provider/state.dart';
import 'package:contoh/routes/router.dart';
import 'package:contoh/shared/drawer_button.dart';
import 'package:contoh/shared/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
        return SizedBox(
          width: isSidebar ? 300 : 80,
          height: size.height,
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: isSidebar
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: isSidebar
                      ? DrawerButton(
                          active: router.location == "/" ? true : false,
                          onPressed: () => router.goNamed("home"),
                          text: "Home",
                          icon: const Icon(
                            Icons.home,
                          ),
                        )
                      : CustomIconButton(
                          active: router.location == "/" ? true : false,
                          icon: const Icon(Icons.home),
                          onPressed: () => router.goNamed("home"),
                        ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: isSidebar
                      ? DrawerButton(
                          active: router.location == "/favorite" ? true : false,
                          onPressed: () {},
                          text: "Favorite",
                          icon: const Icon(
                            Icons.favorite,
                          ),
                        )
                      : CustomIconButton(
                          active: router.location == "/favorite" ? true : false,
                          icon: const Icon(Icons.favorite),
                          onPressed: () {},
                        ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: isSidebar
                      ? DrawerButton(
                          active: router.location == "/movies" ? true : false,
                          onPressed: () => router.goNamed("movie"),
                          text: "Movies",
                          icon: const Icon(
                            Icons.movie,
                          ),
                        )
                      : CustomIconButton(
                          active: router.location == "/movies" ? true : false,
                          icon: const Icon(Icons.movie),
                          onPressed: () => router.goNamed("movie"),
                        ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: isSidebar
                      ? DrawerButton(
                          active:
                              router.location == "/categories" ? true : false,
                          onPressed: () {},
                          text: "Genres",
                          icon: const Icon(
                            Icons.category,
                          ),
                        )
                      : CustomIconButton(
                          active:
                              router.location == "/categories" ? true : false,
                          icon: const Icon(Icons.category),
                          onPressed: () {},
                        ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: isSidebar
                      ? DrawerButton(
                          active: false,
                          onPressed: () {
                            final readSide = ref.read(sidebarProvider.state);
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
                            final readSide = ref.read(sidebarProvider.state);
                            readSide.state = true;
                          },
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

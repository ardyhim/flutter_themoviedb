import 'package:contoh/provider/state.dart';
import 'package:contoh/shared/drawer_button.dart';
import 'package:contoh/shared/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          active: false,
                          onPressed: () {},
                          text: "Home",
                          icon: const Icon(
                            Icons.home,
                          ),
                        )
                      : CustomIconButton(
                          active: false,
                          icon: const Icon(Icons.home),
                          onPressed: () {},
                        ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: isSidebar
                      ? DrawerButton(
                          active: false,
                          onPressed: () {},
                          text: "Favorite",
                          icon: const Icon(
                            Icons.favorite,
                          ),
                        )
                      : CustomIconButton(
                          active: false,
                          icon: const Icon(Icons.favorite),
                          onPressed: () {},
                        ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: isSidebar
                      ? DrawerButton(
                          active: true,
                          onPressed: () {},
                          text: "Movies",
                          icon: const Icon(
                            Icons.movie,
                          ),
                        )
                      : CustomIconButton(
                          active: true,
                          icon: const Icon(Icons.movie),
                          onPressed: () {},
                        ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: isSidebar
                      ? DrawerButton(
                          active: false,
                          onPressed: () {},
                          text: "Genres",
                          icon: const Icon(
                            Icons.category,
                          ),
                        )
                      : CustomIconButton(
                          active: false,
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

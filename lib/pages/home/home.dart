import 'dart:ui';

import 'package:contoh/pages/home/list_horizontal_movie_popular.dart';
import 'package:contoh/pages/home/page_view_movie_popular.dart';
import 'package:contoh/provider/api.dart';
import 'package:contoh/provider/state.dart';
import 'package:contoh/shared/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Flutter Movies"),
      //   centerTitle: true,
      //   backgroundColor: Theme.of(context).colorScheme.surface,
      //   leading: GestureDetector(
      //     onTap: () {
      //       final readSide = ref.read(sidebarProvider.state);
      //       readSide.state = !readSide.state;
      //     },
      //     child: Consumer(
      //       builder: (context, ref, child) {
      //         bool isSidebar = ref.watch(sidebarProvider.state).state;
      //         return isSidebar
      //             ? const Icon(Icons.menu)
      //             : const Icon(Icons.menu_open);
      //       },
      //     ),
      //   ),
      // ),
      body: Row(
        children: [
          Sidebar(size: size),
          Expanded(
            child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: PageViewMoviesUpcoming(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                        ),
                      ),
                      Positioned(
                        bottom: 250,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            // vertical: 5,
                          ),
                          child: Text(
                            "POPULAR MOVIES",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: listHorizontalMoviePopular(
                          width: constraints.maxWidth,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
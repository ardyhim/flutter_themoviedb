import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/api.dart';
import '../../shared/sidebar.dart';
import 'list_horizontal_movie_popular.dart';
import 'page_view_movie_popular.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final homeData = ref.watch(homeProvider);
    return Scaffold(
      body: Row(
        children: [
          Sidebar(size: size),
          Expanded(
            child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: homeData.when(
                    data: (data) {
                      return Stack(
                        children: [
                          Positioned(
                            top: 0,
                            child: PageViewMoviesUpcoming(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              data: data.upComing,
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: ListHorizontalMoviePopular(
                              width: constraints.maxWidth,
                              data: data.popular,
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (err, stack) => const Text("ERROR"),
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

import 'package:contoh/pages/home/list_horizontal_movie_popular.dart';
import 'package:contoh/pages/home/page_view_movie_popular.dart';
import 'package:contoh/shared/sidebar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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

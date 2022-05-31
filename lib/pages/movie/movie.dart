import 'package:contoh/pages/movie/movie_content.dart';
import 'package:contoh/provider/api.dart';
import 'package:contoh/shared/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

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
                  child: MoviesView(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
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

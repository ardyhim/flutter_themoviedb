import 'package:contoh/provider/api.dart';
import 'package:contoh/provider/notifierr.dart';
import 'package:contoh/repository/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/state.dart';

class MoviesView extends ConsumerWidget {
  MoviesView({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  double width;
  double height;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var crossAxisSpacing = 8;
    var crossAxisCount = 6;
    var widthCard =
        (width - ((crossAxisCount - 1) * crossAxisSpacing)) / crossAxisCount;
    var cellHeight = 420;
    var aspectRatio = widthCard / cellHeight;

    if (width <= 500) {
      crossAxisCount = 1;
      cellHeight = 80;
      aspectRatio = widthCard / cellHeight;
      widthCard =
          (width - ((crossAxisCount - 1) * crossAxisSpacing)) / crossAxisCount;
    } else if (width <= 769) {
      crossAxisCount = 3;
      cellHeight = 180;
      aspectRatio = widthCard / cellHeight;
      widthCard =
          (width - ((crossAxisCount - 1) * crossAxisSpacing)) / crossAxisCount;
    } else if (width <= 833) {
      crossAxisCount = 3;
      cellHeight = 220;
      aspectRatio = widthCard / cellHeight;
      widthCard =
          (width - ((crossAxisCount - 1) * crossAxisSpacing)) / crossAxisCount;
    } else if (width <= 993) {
      crossAxisCount = 3;
      cellHeight = 220;
      aspectRatio = widthCard / cellHeight;
      widthCard =
          (width - ((crossAxisCount - 1) * crossAxisSpacing)) / crossAxisCount;
    } else if (width <= 1024) {
      crossAxisCount = 4;
      cellHeight = 220;
      aspectRatio = widthCard / cellHeight;
      widthCard =
          (width - ((crossAxisCount - 1) * crossAxisSpacing)) / crossAxisCount;
    } else if (width <= 1280) {
      crossAxisCount = 5;
      cellHeight = 300;
      aspectRatio = widthCard / cellHeight;
      widthCard =
          (width - ((crossAxisCount - 1) * crossAxisSpacing)) / crossAxisCount;
    }
    AsyncValue movies = ref.watch(movieProvider);
    List movieList = ref.watch(movieListProvider);
    final movieRepository = ref.read(movieRepositoryProvider);
    TextEditingController search =
        TextEditingController(text: movieRepository.keyword);
    return movies.when(
      data: (data) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: width,
                height: 100,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: TextFormField(
                  controller: search,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (String value) async {
                    ref.read(movieRepositoryProvider).keyword = value;
                    ref.read(movieTypeProvider.state).state = MovieType.search;
                    movieRepository.type = MovieType.search;
                    // ref.refresh(movieProvider);
                    ref.refresh(movieListProvider);
                    movieRepository.page = movieRepository.page + 1;
                    var result = await movieRepository.fetchSearch();
                    ref.read(movieListProvider.notifier).addMovie(result);
                  },
                  decoration: InputDecoration(
                    labelText: "Search Movies",
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        ref.refresh(movieListProvider);
                        if (movieRepository.type == MovieType.trending) {
                          movieRepository.type = MovieType.search;
                          movieRepository.page = movieRepository.page + 1;
                          var result = await movieRepository.fetchSearch();
                          ref.read(movieListProvider.notifier).addMovie(result);
                        } else {
                          movieRepository.type = MovieType.trending;
                          movieRepository.keyword = "";
                          movieRepository.page = movieRepository.page + 1;
                          var result = await movieRepository.fetchPopular();
                          ref.read(movieListProvider.notifier).addMovie(result);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: movieRepository.type == MovieType.trending
                            ? const Icon(Icons.search)
                            : const Icon(Icons.close),
                      ),
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
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: aspectRatio,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 19,
                      vertical: 10,
                    ),
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500${movieList[i]["poster_path"]}",
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                child: Text(
                                  "${movieList[i]["vote_average"]}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 100,
                                width: widthCard - 40,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "${movieList[i]["title"]}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: movieList.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: movieRepository.isMore
                    ? TextButton(
                        onPressed: () async {
                          movieRepository.page = movieRepository.page + 1;
                          if (movieRepository.type == MovieType.trending) {
                            var result = await movieRepository.fetchPopular();
                            ref
                                .read(movieListProvider.notifier)
                                .addMovie(result);
                          } else {
                            var result = await movieRepository.fetchSearch();
                            ref
                                .read(movieListProvider.notifier)
                                .addMovie(result);
                          }
                        },
                        child: Text(
                          "PAGINATION",
                        ),
                      )
                    : Text("NO MORE"),
              ),
            ),
          ],
        );
      },
      error: (err, stack) {
        return Container();
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

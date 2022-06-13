import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../provider/api.dart';
import '../../provider/state.dart';
import '../../shared/icon_button.dart';
import '../../utils/mapping.dart';
import 'item_people.dart';
import 'item_review.dart';

class DetailMoviePage extends ConsumerWidget {
  DetailMoviePage({Key? key, required this.id}) : super(key: key);
  late int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter.of(context);
    final detailWatch = ref.watch(detailMovieProvider(id));
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return detailWatch.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (err, stack) => const Text("ERROR"),
            data: (data) {
              Future.delayed(
                const Duration(milliseconds: 500),
                (() => ref.read(isFavoriteState.state).state =
                    data.state["favorite"]),
              );
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/original${data.movie["backdrop_path"]}",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxWidth,
                    decoration: const BoxDecoration(
                      // gradient: RadialGradient(
                      //   colors: [
                      //     Colors.black,
                      //     Colors.black87,
                      //     Colors.transparent,
                      //     Colors.transparent,
                      //   ],
                      //   center: Alignment(-1.4, 1),
                      //   radius: 4,
                      // ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black87,
                          Colors.black87,
                        ],
                        tileMode: TileMode.mirror,
                      ),
                    ),
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        leading: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () => router.pop(),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: constraints.maxHeight / 2.9,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          padding: EdgeInsets.only(
                              right: constraints.maxWidth / 2.5),
                          child: Text(
                            "${data.movie["title"]}",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.only(
                            right: constraints.maxWidth / 2.5,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text(
                            "${data.movie["overview"]}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.only(
                            right: constraints.maxWidth / 2.5,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Wrap(
                            children: [
                              ...data.movie["genres"].map(
                                (genre) => Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Chip(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    label: Text(
                                      "${genre["name"]}",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          // width: size.width / 1.5,
                          margin: const EdgeInsets.only(
                            left: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  var cast =
                                      MappingMovie().cast(data.credit["cast"]);
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 20,
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                  ),
                                ),
                                child: Text(
                                  "PLAY NOW",
                                  style: Theme.of(context).textTheme.button,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Text(
                                  "IMDb: ${data.movie["vote_average"]}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                child: Text(
                                  "${data.movie["release_date"]}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              Consumer(
                                builder: ((context, ref, child) {
                                  final isFavorite =
                                      ref.watch(isFavoriteState.state).state;
                                  return CustomIconButton(
                                    icon: const Icon(Icons.favorite),
                                    active: isFavorite,
                                    onPressed: () async {
                                      final user =
                                          ref.read(userProvider.notifier);
                                      final accountProvider =
                                          ref.read(accountRepositoryProvider);
                                      try {
                                        await accountProvider.markAsFavorite(
                                          user.sessionId,
                                          user.user.id!,
                                          id,
                                          MediaType.movie,
                                          !isFavorite,
                                        );
                                        ref.read(isFavoriteState.state).state =
                                            !isFavorite;
                                      } on DioError catch (e) {
                                        SnackBar snackBar = SnackBar(
                                          content: Text(
                                            '${e.response!.data["status_message"]}',
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          padding: EdgeInsets.only(
                              right: constraints.maxWidth / 2.5),
                          child: Text(
                            "Video",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          width: constraints.maxWidth,
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.video["results"].length,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                margin: i == 0
                                    ? const EdgeInsets.only(
                                        left: 20,
                                        right: 10,
                                      )
                                    : const EdgeInsets.only(right: 10),
                                width: 400,
                                height: 250,
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "https://img.youtube.com/vi/${data.video["results"][i]["key"]}/0.jpg",
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black87.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 5,
                                                // vertical: 5,
                                              ),
                                              child: MaterialButton(
                                                hoverColor: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant
                                                    .withOpacity(0.3),
                                                splashColor: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer
                                                    .withOpacity(0.3),
                                                padding:
                                                    const EdgeInsets.all(20),
                                                shape: const CircleBorder(),
                                                onPressed: () => {},
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  size: 50,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSecondaryContainer,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: 380,
                                              height: 150,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${data.video["results"][i]["name"]}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: constraints.maxWidth,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          color: Theme.of(context).colorScheme.background,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: constraints.maxWidth -
                                        ((constraints.maxWidth / 2) / 1.8) -
                                        40,
                                    margin: const EdgeInsets.symmetric(
                                      // horizontal: 20,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      "Movie Reviews",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ),
                                  ...data.review["results"].map(
                                    (review) => DetailItemReview(
                                      constraints: constraints,
                                      data: review,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "Director",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    ...MappingMovie()
                                        .crew(data.credit["crew"])
                                        .map(
                                          (crew) => DetailItemPeople(
                                            constraints: constraints,
                                            data: crew,
                                            role: PeopleRole.crew,
                                          ),
                                        ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "Top Cast",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                    ...MappingMovie()
                                        .cast(data.credit["cast"])
                                        .map(
                                          (cast) => DetailItemPeople(
                                            constraints: constraints,
                                            data: cast,
                                            role: PeopleRole.cast,
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

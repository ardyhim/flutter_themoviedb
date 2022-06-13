import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../provider/api.dart';
import '../../repository/repository.dart';
import '../../provider/state.dart';

class TvView extends ConsumerWidget {
  TvView({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  double width;
  double height;
  ScrollController scrollController = ScrollController();
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
    final router = GoRouter.of(context);
    AsyncValue tv = ref.watch(tvProvider);
    List tvList = ref.watch(tvListProvider);
    final tvRepository = ref.read(tvRepositoryProvider);
    TextEditingController search =
        TextEditingController(text: tvRepository.keyword);
    return tv.when(
      data: (data) {
        return NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              if (tvRepository.isMore && !tvRepository.isLoading) {
                if (tvRepository.type == MovieType.search) {
                  tvRepository.searchPage++;
                  tvRepository.fetchSearch();
                } else {
                  tvRepository.trendingPage++;
                  tvRepository.fetchPopular();
                }
              }
            }
            return true;
          },
          child: CustomScrollView(
            controller: scrollController,
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
                      ref.refresh(movieListProvider);
                      tvRepository.keyword = value;
                      tvRepository.type = TvType.search;
                      tvRepository.searchPage = 1;
                      var result = await tvRepository.fetchSearch();
                      ref.read(movieListProvider.notifier).addMovie(result);
                    },
                    decoration: InputDecoration(
                      labelText: "Search Tv Series",
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          ref.refresh(tvListProvider);
                          if (tvRepository.type == TvType.trending) {
                            tvRepository.type = TvType.search;
                            tvRepository.searchPage =
                                tvRepository.searchPage + 1;
                            var result = await tvRepository.fetchSearch();
                            ref.read(tvListProvider.notifier).addTv(result);
                          } else {
                            tvRepository.type = TvType.trending;
                            tvRepository.keyword = "";
                            tvRepository.trendingPage =
                                tvRepository.trendingPage + 1;
                            var result = await tvRepository.fetchPopular();
                            ref.read(tvListProvider.notifier).addTv(result);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: tvRepository.type == TvType.trending
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
                        child: GestureDetector(
                          onTap: () {
                            router.goNamed(
                              "detail_tv",
                              params: {
                                "id": tvList[i]["id"].toString(),
                              },
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${tvList[i]["poster_path"]}",
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
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                    child: Text(
                                      "${tvList[i]["vote_average"]}",
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
                                        "${tvList[i]["name"]}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
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
                  childCount: tvList.length,
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     child: tvRepository.isMore
              //         ? TextButton(
              //             onPressed: () async {
              //               tvRepository.page = tvRepository.page + 1;
              //               if (tvRepository.type == TvType.trending) {
              //                 var result = await tvRepository.fetchPopular();
              //                 ref.read(tvListProvider.notifier).addTv(result);
              //               } else {
              //                 var result = await tvRepository.fetchSearch();
              //                 ref.read(tvListProvider.notifier).addTv(result);
              //               }
              //             },
              //             child: const Text(
              //               "PAGINATION",
              //             ),
              //           )
              //         : const Text("NO MORE"),
              //   ),
              // ),
            ],
          ),
        );
      },
      error: (err, stack) {
        return Container();
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

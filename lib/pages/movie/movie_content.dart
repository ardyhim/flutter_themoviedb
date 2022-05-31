import 'package:contoh/provider/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

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

    TextEditingController _search = TextEditingController(text: "");
    AsyncValue<Map> movies = ref.watch(movieProvider);
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
                  controller: _search,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (String value) {
                    print(value);
                    print(widthCard);
                  },
                  decoration: InputDecoration(
                    labelText: "Search Movies",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print(_search.text);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.search),
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
                              "https://image.tmdb.org/t/p/w500${data["results"][i]["poster_path"]}",
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
                                  "${data["results"][i]["vote_average"]}",
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
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "${data["results"][i]["title"]}",
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
                childCount: 20,
              ),
            )
          ],
        );
      },
      error: (err, stack) {
        return Container();
      },
      loading: () {
        return CircularProgressIndicator();
      },
    );
  }
}

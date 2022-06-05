import 'package:contoh/provider/api.dart';
import 'package:contoh/provider/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageViewMoviesUpcoming extends ConsumerWidget {
  PageViewMoviesUpcoming({
    Key? key,
    required this.width,
    required this.height,
    required this.data,
  }) : super(key: key);

  double width;
  double height;
  Map data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageController pageController = PageController(initialPage: 0);
    String homeBackgroundImage =
        ref.watch(homeBackgroundImageProvider.state).state;
    return SizedBox(
      height: height,
      width: width,
      child: PageView.builder(
        controller: pageController,
        itemCount: 5,
        onPageChanged: (int currentPage) {
          ref.read(homeBackgroundImageProvider.state).state =
              "https://image.tmdb.org/t/p/w1280${data["results"][currentPage]["poster_path"]}";
        },
        itemBuilder: ((context, int i) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  homeBackgroundImage == "unknown"
                      ? "https://image.tmdb.org/t/p/original${data["results"][0]["poster_path"]}"
                      : homeBackgroundImage,
                ),
              ),
            ),
            child: Container(
              height: height,
              width: width,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black87,
                  ],
                  tileMode: TileMode.mirror,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data["results"][i]["title"]}",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    "${data["results"][i]["overview"]}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

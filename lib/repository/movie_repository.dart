import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../provider/state.dart';

enum MovieType {
  search,
  trending,
}

class MovieRepository {
  MovieRepository({
    required this.read,
    required this.type,
    required this.tmdb,
  });
  final Reader read;
  final TMDB tmdb;
  MovieType type;
  int trendingPage = 1;
  int searchPage = 1;
  String keyword = "";
  bool isMoreTrending = true;
  bool isMoreSearch = true;
  bool isLoading = false;
  late Map trending;

  Future<List> fetchPopular() async {
    isLoading = true;
    if (!isMoreTrending) return List.empty();
    if (trendingPage == 1) {
      Map result = await tmdb.v3.trending.getTrending(
        mediaType: MediaType.movie,
        timeWindow: TimeWindow.day,
        page: trendingPage,
      );
      if (result["results"].length <= 19) isMoreTrending = false;
      trending = result;
      isLoading = false;
      return trending["results"];
    } else {
      Map result = await tmdb.v3.trending.getTrending(
        mediaType: MediaType.movie,
        timeWindow: TimeWindow.day,
        page: trendingPage,
      );
      if (result["results"].length <= 19) isMoreTrending = false;
      trending["results"].addAll(result["results"]);
      isLoading = false;
      final movieList = read(movieListProvider.notifier);
      movieList.addMovie(result["results"]);
      return result["results"];
    }
  }

  Future<List> fetchSearch() async {
    isLoading = true;
    if (!isMoreSearch) return [];
    if (searchPage == 1) {
      Map result = await tmdb.v3.search.queryMovies(keyword, page: searchPage);
      if (result["results"].length <= 19) isMoreSearch = false;
      isLoading = false;
      return result["results"];
    } else {
      Map result = await tmdb.v3.search.queryMovies(keyword, page: searchPage);
      if (result["results"].length <= 19) isMoreSearch = false;
      isLoading = false;
      final movieList = read(movieListProvider.notifier);
      movieList.addMovie(result["results"]);
      return result["results"];
    }
  }
}

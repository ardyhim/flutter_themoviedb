import 'package:contoh/provider/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

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
  int page = 1;
  String keyword = "";
  bool isMore = true;
  bool isLoading = false;
  late Map trending;

  Future<List> fetchPopular() async {
    isLoading = true;
    if (type != MovieType.trending) page = 1;
    if (!isMore) return List.empty();
    if (page == 1) {
      Map result = await tmdb.v3.trending.getTrending(
        mediaType: MediaType.movie,
        page: page,
      );
      if (result["results"].length <= 19) isMore = false;
      trending = result;
      isLoading = false;
      return trending["results"];
    } else {
      Map result = await tmdb.v3.trending.getTrending(
        mediaType: MediaType.movie,
        page: page,
      );
      if (result["results"].length <= 19) isMore = false;
      trending["results"].addAll(result["results"]);
      isLoading = false;
      final movieList = read(movieListProvider.notifier);
      movieList.addMovie(result["results"]);
      return result["results"];
    }
  }

  Future<List> fetchSearch() async {
    isLoading = true;
    if (type != MovieType.search) page = 1;
    if (!isMore) return [];
    if (page == 1) {
      Map result = await tmdb.v3.search.queryMovies(keyword, page: page);
      if (result["results"].length <= 19) isMore = false;
      isLoading = false;
      return result["results"];
    } else {
      Map result = await tmdb.v3.search.queryMovies(keyword, page: page);
      if (result["results"].length <= 19) isMore = false;
      isLoading = false;
      final movieList = read(movieListProvider.notifier);
      movieList.addMovie(result["results"]);
      return result["results"];
    }
  }
}

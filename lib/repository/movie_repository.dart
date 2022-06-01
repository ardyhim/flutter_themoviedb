import 'package:flutter/material.dart';
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

  late Map trending;
  Future<List> fetchPopular() async {
    if (!isMore) return List.empty();
    if (page == 1) {
      Map result = await tmdb.v3.trending.getTrending(
        mediaType: MediaType.movie,
        page: page,
      );
      if (result["results"].length <= 19) isMore = false;
      trending = result;
      return trending["results"];
    } else {
      Map result = await tmdb.v3.trending.getTrending(
        mediaType: MediaType.movie,
        page: page,
      );
      if (result["results"].length <= 19) isMore = false;
      trending["results"].addAll(result["results"]);
      return result["results"];
    }
  }

  Future<List> fetchSearch() async {
    if (!isMore) return [];
    if (page == 1) {
      Map result = await tmdb.v3.search.queryMovies(keyword, page: page);
      if (result["results"].length <= 19) isMore = false;
      return result["results"];
    } else {
      Map result = await tmdb.v3.search.queryMovies(keyword, page: page);
      if (result["results"].length <= 19) isMore = false;
      return result["results"];
    }
  }
}

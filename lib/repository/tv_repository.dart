import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../provider/state.dart';

enum TvType {
  search,
  trending,
}

class TvRepository {
  TvRepository({
    required this.read,
    required this.type,
    required this.tmdb,
  });
  final Reader read;
  final TMDB tmdb;
  TvType type;
  int page = 1;
  String keyword = "";
  bool isMore = true;
  bool isLoading = false;
  late Map trending;

  // Future<List> fetchPopular() async {
  //   isLoading = true;
  //   if (type != TvType.trending) page = 1;
  //   if (!isMore) return List.empty();
  //   if (page == 1) {
  //     Map result = await tmdb.v3.trending.getTrending(
  //       mediaType: MediaType.tv,
  //       page: page,
  //     );
  //     if (result["results"].length <= 19) isMore = false;
  //     trending = result;
  //     return trending["results"];
  //   } else {
  //     Map result = await tmdb.v3.trending.getTrending(
  //       mediaType: MediaType.tv,
  //       page: page,
  //     );
  //     if (result["results"].length <= 19) isMore = false;
  //     trending["results"].addAll(result["results"]);
  //     final tvList = read(tvListProvider.notifier);
  //     tvList.addTv(result["results"]);
  //     return result["results"];
  //   }
  // }

  // Future<List> fetchSearch() async {
  //   isLoading = true;
  //   if (type != TvType.trending) page = 1;
  //   if (!isMore) return [];
  //   if (page == 1) {
  //     Map result = await tmdb.v3.search.queryTvShows(keyword, page: page);
  //     if (result["results"].length <= 19) isMore = false;
  //     return result["results"];
  //   } else {
  //     Map result = await tmdb.v3.search.queryTvShows(keyword, page: page);
  //     if (result["results"].length <= 19) isMore = false;
  //     final tvList = read(tvListProvider.notifier);
  //     tvList.addTv(result["results"]);
  //     return result["results"];
  //   }
  // }

  Future<List> fetchPopular() async {
    isLoading = true;
    if (type != TvType.trending) page = 1;
    if (!isMore) return List.empty();
    if (page == 1) {
      Map result = await tmdb.v3.trending.getTrending(
        mediaType: MediaType.tv,
        page: page,
      );
      if (result["results"].length <= 19) isMore = false;
      trending = result;
      isLoading = false;
      return trending["results"];
    } else {
      Map result = await tmdb.v3.trending.getTrending(
        mediaType: MediaType.tv,
        page: page,
      );
      if (result["results"].length <= 19) isMore = false;
      trending["results"].addAll(result["results"]);
      isLoading = false;
      final movieList = read(tvListProvider.notifier);
      movieList.addTv(result["results"]);
      return result["results"];
    }
  }

  Future<List> fetchSearch() async {
    isLoading = true;
    if (type != TvType.search) page = 1;
    if (!isMore) return [];
    if (page == 1) {
      Map result = await tmdb.v3.search.queryTvShows(keyword, page: page);
      if (result["results"].length <= 19) isMore = false;
      isLoading = false;
      return result["results"];
    } else {
      Map result = await tmdb.v3.search.queryTvShows(keyword, page: page);
      if (result["results"].length <= 19) isMore = false;
      isLoading = false;
      final movieList = read(tvListProvider.notifier);
      movieList.addTv(result["results"]);
      return result["results"];
    }
  }
}

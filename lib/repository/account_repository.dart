import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../model/model.dart';
import '../provider/state.dart';

class AccountRepository {
  AccountRepository({
    required this.read,
    required this.tmdb,
  });
  final Reader read;
  final TMDB tmdb;

  late Map movieFavorite;
  late Map tvFavorite;
  late Map movieWatchList;
  late Map tvWatchList;

  Future<Map> markAsFavorite(
    String session,
    int accountId,
    int id,
    MediaType mediaType,
    bool isFavorite,
  ) async {
    var response = await tmdb.v3.account.markAsFavorite(
      session,
      accountId,
      id,
      mediaType,
      isFavorite: isFavorite,
    );
    final account = read(accountProvider.notifier);
    if (mediaType == MediaType.movie) {
      var movie = await tmdb.v3.account.getFavoriteMovies(
        session,
        accountId,
        sortBy: SortBy.createdAtDes,
      );
      var data = account.data;
      data.movie = movie["results"];
      account.add(data);
    } else {
      var tv = await tmdb.v3.account.getFavoriteTvShows(
        session,
        accountId,
        sortBy: SortBy.createdAtDes,
      );
      var data = account.data;
      data.tv = tv["results"];
      account.add(data);
    }
    return response;
  }

  Future<void> fetchAccountApi(String session) async {
    final tmdb = read(tmdbRepositoryProvider).tmdb;
    final user = read(userProvider.notifier);
    final account = read(accountProvider.notifier);
    var movie = await tmdb.v3.account.getFavoriteMovies(
      session,
      user.user.id!,
      sortBy: SortBy.createdAtDes,
    );
    var tv = await tmdb.v3.account.getFavoriteTvShows(
      session,
      user.user.id!,
      sortBy: SortBy.createdAtDes,
    );
    var tvWatchList = await tmdb.v3.account.getTvShowWatchList(
      session,
      user.user.id!,
      sortBy: SortBy.createdAtDes,
    );
    var movieWatchList = await tmdb.v3.account.getMovieWatchList(
      session,
      user.user.id!,
      sortBy: SortBy.createdAtDes,
    );
    ModelAccount data = ModelAccount(
      movie: movie["results"],
      tv: tv["results"],
      movieWatchList: movieWatchList["results"],
      tvWatchList: tvWatchList["results"],
    );
    account.add(data);
  }

  Future<Map> getTvFavorite(String session, int id) async {
    tvFavorite = await tmdb.v3.account.getFavoriteTvShows(session, id);
    return tvFavorite;
  }

  Future<Map> getTvWatchList(String session, int id) async {
    tvWatchList = await tmdb.v3.account.getTvShowWatchList(session, id);
    return tvWatchList;
  }
}

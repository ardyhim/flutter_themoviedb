import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

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

  Future<Map> getMovieFavorite(String session, int id) async {
    movieFavorite = await tmdb.v3.account.getFavoriteMovies(session, id);
    return movieFavorite;
  }

  Future<Map> getMovieWatchList(String session, int id) async {
    movieWatchList = await tmdb.v3.account.getMovieWatchList(session, id);
    return movieWatchList;
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

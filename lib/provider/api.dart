import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:contoh/provider/state.dart';
import '../model/detail.dart';
import './notifier/notifier.dart';

import '../repository/repository.dart';

final moviePopularProvider = FutureProvider(((ref) async {
  final tmdb = ref.read(tmdbRepositoryProvider).tmdb;
  return tmdb.v3.movies.getPopular(page: 1);
}));

final movieLatestProvider = FutureProvider(((ref) async {
  final tmdb = ref.read(tmdbRepositoryProvider).tmdb;
  return tmdb.v3.movies.getLatest();
}));

final movieUpcomingProvider = FutureProvider(((ref) async {
  final tmdb = ref.read(tmdbRepositoryProvider).tmdb;
  return tmdb.v3.movies.getUpcoming();
}));

final movieProvider = FutureProvider(
  ((ref) async {
    final movieRepository = ref.read(movieRepositoryProvider);
    final movieList = ref.read(movieListProvider.notifier);
    final MovieType type = movieRepository.type;
    switch (type) {
      case MovieType.trending:
        var result = await movieRepository.fetchPopular();
        movieList.addMovie(result);
        return movieList;
      case MovieType.search:
        var result = await movieRepository.fetchSearch();
        movieList.addMovie(result);
        return movieList;
      default:
        var result = await movieRepository.fetchPopular();
        movieList.addMovie(result);
        return movieList;
    }
  }),
);

final movieListProvider =
    StateNotifierProvider<MovieListNotifier, List<dynamic>>((ref) {
  return MovieListNotifier();
});

final detailProvider = FutureProvider.family<ModelDetail, int>((ref, id) async {
  final tmdb = ref.read(tmdbRepositoryProvider).tmdb;
  final credit = await tmdb.v3.movies.getCredits(id);
  final movie = await tmdb.v3.movies.getDetails(id);
  final review = await tmdb.v3.movies.getReviews(id);
  final video = await tmdb.v3.movies.getVideos(id);
  return ModelDetail(
    credit: credit,
    movie: movie,
    review: review,
    video: video,
  );
});

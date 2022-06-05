import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'state.dart';

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

final tvProvider = FutureProvider(
  ((ref) async {
    final tvRepository = ref.read(tvRepositoryProvider);
    final tvList = ref.read(tvListProvider.notifier);
    final TvType type = tvRepository.type;
    switch (type) {
      case TvType.trending:
        var result = await tvRepository.fetchPopular();
        tvList.addTv(result);
        return tvList;
      case TvType.search:
        var result = await tvRepository.fetchSearch();
        tvList.addTv(result);
        return tvList;
      default:
        var result = await tvRepository.fetchPopular();
        tvList.addTv(result);
        return tvList;
    }
  }),
);

final homeProvider = FutureProvider((ref) async {
  final tmdb = ref.read(tmdbRepositoryProvider).tmdb;
  final upComing = await tmdb.v3.movies.getUpcoming();
  final popular = await tmdb.v3.movies.getPopular();
  return ModelHome(
    upComing: upComing,
    popular: popular,
  );
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

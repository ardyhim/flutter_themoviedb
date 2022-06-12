import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
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

final detailMovieProvider =
    FutureProvider.family<ModelDetailMovie, int>((ref, id) async {
  final tmdb = ref.read(tmdbRepositoryProvider).tmdb;
  final credit = await tmdb.v3.movies.getCredits(id);
  final movie = await tmdb.v3.movies.getDetails(id);
  final review = await tmdb.v3.movies.getReviews(id);
  final video = await tmdb.v3.movies.getVideos(id);
  return ModelDetailMovie(
    credit: credit,
    movie: movie,
    review: review,
    video: video,
  );
});

final detailTvProvider =
    FutureProvider.family<ModelDetailTv, int>((ref, id) async {
  final tmdb = ref.read(tmdbRepositoryProvider).tmdb;
  final credit = await tmdb.v3.tv.getCredits(id);
  final tv = await tmdb.v3.tv.getDetails(id);
  final review = await tmdb.v3.tv.getReviews(id);
  final video = await tmdb.v3.tv.getVideos("$id/videos");
  List session = [];
  for (var i = 1; i < tv["number_of_seasons"] + 1; i++) {
    session.add(await tmdb.v3.tvSeasons.getDetails(id, i));
  }
  return ModelDetailTv(
    credit: credit,
    tv: tv,
    review: review,
    video: video,
    session: session,
  );
});

final hiveProvider = FutureProvider(((ref) async {
  final tmdb = ref.read(tmdbRepositoryProvider).tmdb;
  final user = ref.read(userProvider.notifier);
  Hive.init("./data");
  var box = await Hive.openBox('setting');
  var session = box.get("sessionId");
  if (session != null) {
    var account = await tmdb.v3.account.getDetails(box.get("sessionId"));
    user.sessionId = session;
    user.setUser(ModelUser.fromJson(account as Map<String, dynamic>));
  }
}));

final accountFutureProvider = FutureProvider(((ref) async {
  final tmdb = ref.read(tmdbRepositoryProvider).tmdb;
  final user = ref.read(userProvider.notifier);
  final account = ref.read(accountProvider.notifier);
  var session = await user.getSession();
  if (session != null || session == "") {
    user.sessionId = session;
    try {
      var movie =
          await tmdb.v3.account.getFavoriteMovies(session, user.user.id!);
      var tv = await tmdb.v3.account.getFavoriteTvShows(session, user.user.id!);
      var tvWatchList =
          await tmdb.v3.account.getTvShowWatchList(session, user.user.id!);
      var movieWatchList =
          await tmdb.v3.account.getMovieWatchList(session, user.user.id!);
      ModelAccount data = ModelAccount(
        movie: movie["results"],
        tv: tv["results"],
        movieWatchList: movieWatchList["results"],
        tvWatchList: tvWatchList["results"],
      );
      account.add(data);
      if (user.user == null) print("");
      var accountData = await tmdb.v3.account.getDetails(session);
      user.sessionId = session;
      user.setUser(ModelUser.fromJson(accountData as Map<String, dynamic>));
      return true;
    } catch (e) {
      return false;
    }
  } else {
    return false;
  }
}));

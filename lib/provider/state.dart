import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/repository.dart';
import 'notifier/notifier.dart';

final sidebarProvider = StateProvider((ref) => false);

final tmdbRepositoryProvider = Provider(
  (ref) => TMDBRepository(
    read: ref.read,
  ),
);

final movieRepositoryProvider = Provider(
  (ref) => MovieRepository(
    read: ref.read,
    type: MovieType.trending,
    tmdb: TMDBRepository(read: ref.read).tmdb,
  ),
);

final tvRepositoryProvider = Provider(
  (ref) => TvRepository(
    read: ref.read,
    type: TvType.trending,
    tmdb: TMDBRepository(read: ref.read).tmdb,
  ),
);
final movieTypeProvider =
    StateProvider<MovieType>(((ref) => MovieType.trending));
final tvTypeProvider = StateProvider<TvType>(((ref) => TvType.trending));

final movieListProvider =
    StateNotifierProvider<MovieListNotifier, List<dynamic>>((ref) {
  return MovieListNotifier();
});

final tvListProvider =
    StateNotifierProvider<TvListNotifier, List<dynamic>>((ref) {
  return TvListNotifier();
});

final homeBackgroundImageProvider = StateProvider(((ref) {
  return "unknown";
}));

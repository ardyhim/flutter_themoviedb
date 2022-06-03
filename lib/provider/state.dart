import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/repository.dart';

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

final homeBackgroundImageProvider = StateProvider(((ref) {
  return "unknown";
}));

final movieTypeProvider =
    StateProvider<MovieType>(((ref) => MovieType.trending));

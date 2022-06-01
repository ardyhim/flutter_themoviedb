import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/repository.dart';

final sidebarProvider = StateProvider((ref) => false);

// final tmdbApiKeyProvider =
//     StateProvider((ref) => "e3759057a7b881a632632b371ca441d5");
// final tmdbApiTokenProvider = StateProvider((ref) =>
//     "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMzc1OTA1N2E3Yjg4MWE2MzI2MzJiMzcxY2E0NDFkNSIsInN1YiI6IjU5NDNhMDE4OTI1MTQxN2Y1NzAyMDNjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wYCsR7Y6OLoL3HL5I8Ds_25MLJX5jGP3i4nPaqYeO3Q");

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

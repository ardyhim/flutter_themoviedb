import 'package:contoh/provider/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviePopularProvider = FutureProvider(((ref) async {
  final tmdb = ref.read(tmdbProvider).tmdb;
  return tmdb.v3.movies.getPopular(page: 1);
}));

final movieLatestProvider = FutureProvider(((ref) async {
  final tmdb = ref.read(tmdbProvider).tmdb;
  return tmdb.v3.movies.getLatest();
}));

final movieUpcomingProvider = FutureProvider(((ref) async {
  final tmdb = ref.read(tmdbProvider).tmdb;
  return tmdb.v3.movies.getUpcoming();
}));

import 'package:contoh/provider/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbRepository {
  TmdbRepository(this.read);
  final Reader read;
  final tmdb = TMDB(
    ApiKeys("e3759057a7b881a632632b371ca441d5",
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMzc1OTA1N2E3Yjg4MWE2MzI2MzJiMzcxY2E0NDFkNSIsInN1YiI6IjU5NDNhMDE4OTI1MTQxN2Y1NzAyMDNjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wYCsR7Y6OLoL3HL5I8Ds_25MLJX5jGP3i4nPaqYeO3Q'), //ApiKeys instance with your keys,
  );

  Future fetchMoviePopular() async {
    Map result = await tmdb.v3.movies.getPopular();
    return result;
  }
}

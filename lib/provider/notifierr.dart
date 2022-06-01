import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieListNotifier extends StateNotifier<List<dynamic>> {
  MovieListNotifier() : super([]);

  addMovie(List<dynamic> data) {
    state = [...state, ...data];
  }

  clear() {
    print(List.empty(growable: true));
    state = [...state, List.empty(growable: true)];
  }
}

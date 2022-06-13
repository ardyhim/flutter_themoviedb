import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/home.dart';

class HomeListNotifier extends StateNotifier<List<ModelHome>> {
  HomeListNotifier() : super([]);

  addMovie(ModelHome data) {
    state = [...state, data];
  }
}

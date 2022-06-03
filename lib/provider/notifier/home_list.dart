import 'package:contoh/model/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeListNotifier extends StateNotifier<List<ModelHome>> {
  HomeListNotifier() : super([]);

  addMovie(ModelHome data) {
    state = [...state, data];
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TvListNotifier extends StateNotifier<List<dynamic>> {
  TvListNotifier() : super([]);

  addTv(List<dynamic> data) {
    state = [...state, ...data];
  }
}

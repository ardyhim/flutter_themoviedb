import 'package:flutter/material.dart';

@immutable
class ModelHome {
  const ModelHome({required this.popular, required this.upComing});
  final List<Map> popular;
  final List<Map> upComing;

  ModelHome copyWith({
    List<Map>? popular,
    List<Map>? upComing,
  }) {
    return ModelHome(popular: this.popular, upComing: this.upComing);
  }
}

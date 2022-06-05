import 'package:flutter/material.dart';

@immutable
class ModelHome {
  const ModelHome({required this.popular, required this.upComing});
  final Map popular;
  final Map upComing;
}

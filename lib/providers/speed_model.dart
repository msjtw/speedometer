import 'package:flutter/material.dart';

@immutable
class Speed {
  final double dist;
  final int time;

  const Speed({required this.dist, required this.time});

  double get speed {
    return (dist / time) * 3600;
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_provider.g.dart';

@riverpod
class RandomColor extends _$RandomColor {

  /// return initial value of provider
  @override
  Color build() {
    return Colors.white;
  }

  void changeColor() {
    state = Color.fromRGBO(
        Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  }
}

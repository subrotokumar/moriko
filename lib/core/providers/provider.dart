import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentTheme extends _$CurrentTheme {
  @override
  ThemeMode build() => ThemeMode.light;

  void change(ThemeMode mode) {
    if (mode == state) return;
    state = mode;
  }

  void toggle() {
    switch (state) {
      case ThemeMode.light:
        state = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        state = ThemeMode.light;
        break;
      default:
    }
  }
}

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) => Dio();

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:moriko/core/core.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentTheme extends _$CurrentTheme {
  @override
  ThemeMode build() {
    final sharedPref = ref.watch(sharedPrefProvider).requireValue;
    return sharedPref.currentThemeMode;
  }

  void toggle() async {
    final sharedPref = ref.read(sharedPrefProvider).requireValue;
    state = await sharedPref.toggleThemeMode();
  }
}

@Riverpod(keepAlive: true)
class DataSaverMode extends _$DataSaverMode {
  @override
  bool build() {
    final sharedPref = ref.watch(sharedPrefProvider).requireValue;
    return sharedPref.dataSaverMode;
  }

  void toggle() async {
    final sharedPref = ref.read(sharedPrefProvider).requireValue;
    state = await sharedPref.toggleDataSaverMode();
  }
}

@Riverpod(keepAlive: true)
Dio dio(DioRef ref, {bool useIsolate = false}) {
  final dio = Dio()..interceptors.add(PrettyDioLogger());
  if (useIsolate) {
    dio.transformer = BackgroundTransformer()..jsonDecodeCallback = parseJson;
  }
  return dio;
}

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPref(SharedPrefRef ref) async =>
    await SharedPreferences.getInstance();

Map<String, dynamic> _parseAndDecode(String response) {
  return jsonDecode(response) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> parseJson(String text) {
  return compute(_parseAndDecode, text);
}

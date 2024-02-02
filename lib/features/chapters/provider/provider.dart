import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:moriko/core/providers/provider.dart';
import 'package:moriko/model/chapter_list_res.dart';
import 'package:moriko/service/manga_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'provider.g.dart';

Map<String, dynamic> _parseAndDecode(String response) {
  return jsonDecode(response) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> parseJson(String text) {
  return compute(_parseAndDecode, text);
}

@Riverpod(keepAlive: true)
Future<List<CoverListResData>> chapterListResData(ChapterListResDataRef ref,
    {required String mangaId}) async {
  final dio = ref.watch(dioProvider(useIsolate: true));
  final res = await ref
      .watch(mangaServiceClientProvider(dio: dio))
      .chapterList(mangaId);
  return res.data.data;
}

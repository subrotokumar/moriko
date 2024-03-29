import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:moriko/core/providers/provider.dart';
import 'package:moriko/model/searched_manga_res.dart';
import 'package:moriko/service/manga_service.dart';

part 'searched_manga.provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<SearchedManga>> searchedManga(
  SearchedMangaRef ref, {
  required String title,
}) async {
  final dio = ref.watch(dioProvider(useIsolate: true));
  final res = await ref
      .watch(mangaServiceClientProvider(dio: dio))
      .searchManga(title.isEmpty ? ' ' : title);
  return res.data.data;
}

@Riverpod(keepAlive: true)
Future<String?> mangaCover(
  MangaCoverRef ref, {
  required String coverId,
}) async {
  final dio = ref.watch(dioProvider());
  final res =
      await ref.read(mangaServiceClientProvider(dio: dio)).cover(coverId);
  return res.data.data.attributes.fileName;
}

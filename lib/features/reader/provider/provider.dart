import 'package:flutter/material.dart';
import 'package:moriko/core/providers/provider.dart';
import 'package:moriko/model/chapter_pages_res.dart';
import 'package:moriko/service/manga_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod()
Future<ChapterPagesRes> chapterPagesRes(ChapterPagesResRef ref,
    {required String chapterId}) async {
  final dio = ref.watch(dioProvider(logger: true));
  final res = await ref
      .watch(mangaServiceClientProvider(dio: dio))
      .chapterPages(chapterId);
  return res.data;
}

@riverpod
class BottomNavVisibilty extends _$BottomNavVisibilty {
  @override
  bool build() => true;
  void set(bool value) => state = value;
  void toogle() => state = !state;
}

@Riverpod(keepAlive: true)
class ReaderScrollDirection extends _$ReaderScrollDirection {
  @override
  Axis build() => Axis.horizontal;
  void set(Axis value) => state = value;
  void toogle() =>
      state = state == Axis.horizontal ? Axis.vertical : Axis.horizontal;
}

@Riverpod(keepAlive: true)
class HorizontalBoxFit extends _$HorizontalBoxFit {
  @override
  BoxFit build() => BoxFit.fitWidth;
  void set(BoxFit value) => state = value;
  void toogle() =>
      state = BoxFit.fitHeight == state ? BoxFit.fitWidth : BoxFit.fitHeight;
}

@riverpod
class PageNumber extends _$PageNumber {
  @override
  int build() {
    return 0;
  }

  void set(int value) => state = value;
  void increment() {
    state = state + 1;
  }

  void decrement() {
    if (state == 0) return;
    state = state - 1;
  }
}

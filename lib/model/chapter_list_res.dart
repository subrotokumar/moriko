import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
part 'chapter_list_res.freezed.dart';
part 'chapter_list_res.g.dart';

@freezed
@collection
class ChapterListRes with _$ChapterListRes {
  factory ChapterListRes({
    required String? result,
    required String? response,
    required List<CoverListResData> data,
  }) = _ChapterListRes;

  factory ChapterListRes.fromJson(Map<String, dynamic> json) =>
      _$ChapterListResFromJson(json);
}

@freezed
class CoverListResData with _$CoverListResData {
  factory CoverListResData({
    required String id,
    required String? type,
    required ChapterAttributes attributes,
  }) = _CoverListResData;

  factory CoverListResData.fromJson(Map<String, dynamic> json) =>
      _$CoverListResDataFromJson(json);
}

@freezed
class ChapterAttributes with _$ChapterAttributes {
  factory ChapterAttributes({
    required String? volume,
    required String? chapter,
    required String? title,
    required String? publishAt,
    required int? page,
  }) = _ChapterAttributes;

  factory ChapterAttributes.fromJson(Map<String, dynamic> json) =>
      _$ChapterAttributesFromJson(json);
}

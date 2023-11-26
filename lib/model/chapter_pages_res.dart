import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_pages_res.freezed.dart';
part 'chapter_pages_res.g.dart';

@freezed
class ChapterPagesRes with _$ChapterPagesRes {
  const factory ChapterPagesRes({
    required String? result,
    required String baseUrl,
    required ChapterData chapter,
  }) = _ChapterPagesRes;

  factory ChapterPagesRes.fromJson(Map<String, dynamic> json) =>
      _$ChapterPagesResFromJson(json);
}

@freezed
class ChapterData with _$ChapterData {
  const factory ChapterData({
    required String hash,
    required List<String> data,
    @JsonKey(name: 'dataSaver') required List<String> dataSaver,
  }) = _ChapterData;

  factory ChapterData.fromJson(Map<String, dynamic> json) =>
      _$ChapterDataFromJson(json);
}

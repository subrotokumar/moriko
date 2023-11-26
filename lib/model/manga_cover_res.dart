import 'package:freezed_annotation/freezed_annotation.dart';
part 'manga_cover_res.freezed.dart';
part 'manga_cover_res.g.dart';

@freezed
class MangaCoverResponse with _$MangaCoverResponse {
  const factory MangaCoverResponse({
    required String? result,
    required String response,
    required MangaCoverResponseData data,
  }) = _MangaCoverResponse;

  factory MangaCoverResponse.fromJson(Map<String, dynamic> json) =>
      _$MangaCoverResponseFromJson(json);
}

@freezed
class MangaCoverResponseData with _$MangaCoverResponseData {
  const factory MangaCoverResponseData({
    required String id,
    required String? type,
    required CoverAttribute attributes,
  }) = _MangaCoverResponseData;

  factory MangaCoverResponseData.fromJson(Map<String, dynamic> json) =>
      _$MangaCoverResponseDataFromJson(json);
}

@freezed
class CoverAttribute with _$CoverAttribute {
  const factory CoverAttribute({
    required String? fileName,
  }) = _CoverAttribute;

  factory CoverAttribute.fromJson(Map<String, dynamic> json) =>
      _$CoverAttributeFromJson(json);
}

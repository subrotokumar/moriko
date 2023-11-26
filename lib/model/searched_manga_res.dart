// ignore_for_file: constant_identifier_names
import 'package:freezed_annotation/freezed_annotation.dart';

part 'searched_manga_res.freezed.dart';
part 'searched_manga_res.g.dart';

@freezed
class SearchedMangaRes with _$SearchedMangaRes {
  const factory SearchedMangaRes({
    required String? result,
    required String? response,
    required List<SearchedManga> data,
    required int? limit,
    required int? offset,
    required int? total,
  }) = _SearchedMangaRes;

  factory SearchedMangaRes.fromJson(Map<String, dynamic> json) =>
      _$SearchedMangaResFromJson(json);
}

@freezed
class SearchedManga with _$SearchedManga {
  const factory SearchedManga({
    required String id,
    required RelationshipType type,
    required SearchedMangaAttributes attributes,
    required List<Relationship> relationships,
  }) = _SearchedManga;

  factory SearchedManga.fromJson(Map<String, dynamic> json) =>
      _$SearchedMangaFromJson(json);
}

extension CoverId on SearchedManga {
  String get coverId {
    for (var relation in relationships) {
      if (relation.type == RelationshipType.cover_art) {
        return relation.id;
      }
    }
    return '';
  }
}

@freezed
class SearchedMangaAttributes with _$SearchedMangaAttributes {
  const factory SearchedMangaAttributes({
    required Title title,
    required List<AltTitle> altTitles,
    required PurpleDescription? description,
    required bool? isLocked,
    required Links? links,
    required String originalLanguage,
    required String? lastVolume,
    required String? lastChapter,
    required String? publicationDemographic,
    required Status? status,
    required int? year,
    required ContentRating? contentRating,
    required List<Tag> tags,
    required State? state,
    required bool? chapterNumbersResetOnNewVolume,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required int? version,
    required List<String>? availableTranslatedLanguages,
    required String? latestUploadedChapter,
  }) = _SearchedMangaAttributes;

  factory SearchedMangaAttributes.fromJson(Map<String, dynamic> json) =>
      _$SearchedMangaAttributesFromJson(json);
}

@freezed
class AltTitle with _$AltTitle {
  const factory AltTitle({
    String? ja,
    String? en,
    String? ru,
    String? sr,
    String? hi,
    String? bn,
    String? th,
    String? my,
    String? zhHk,
    String? zh,
    String? ko,
    String? he,
    String? ar,
    String? ta,
    String? ka,
    String? jaRo,
    String? es,
    String? id,
    String? ptBr,
    String? fr,
    String? uk,
  }) = _AltTitle;

  factory AltTitle.fromJson(Map<String, dynamic> json) =>
      _$AltTitleFromJson(json);
}

enum ContentRating { safe, suggestive, erotica, pornographic }

@freezed
class PurpleDescription with _$PurpleDescription {
  const factory PurpleDescription({
    String? en,
    String? ja,
    String? bg,
    String? cs,
    String? de,
    String? es,
    String? fi,
    String? fr,
    String? id,
    String? it,
    String? pl,
    String? pt,
    String? ru,
    String? sr,
    String? tr,
    String? uk,
    String? ptBr,
  }) = _PurpleDescription;

  factory PurpleDescription.fromJson(Map<String, dynamic> json) =>
      _$PurpleDescriptionFromJson(json);
}

@freezed
class Links with _$Links {
  const factory Links({
    String? ap,
    String? kt,
    String? mu,
    String? mal,
    String? raw,
    String? engtl,
    String? al,
    String? bw,
    String? amz,
    String? ebj,
  }) = _Links;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
}

enum State { published }

enum Status { completed, ongoing, hiatus, cancelled }

@freezed
class Tag with _$Tag {
  const factory Tag({
    required String id,
    required TagType type,
    required TagAttributes attributes,
    required List<dynamic> relationships,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@freezed
class TagAttributes with _$TagAttributes {
  const factory TagAttributes({
    required Title name,
    required FluffyDescription description,
    required Group group,
    required int version,
  }) = _TagAttributes;

  factory TagAttributes.fromJson(Map<String, dynamic> json) =>
      _$TagAttributesFromJson(json);
}

@freezed
class FluffyDescription with _$FluffyDescription {
  const factory FluffyDescription() = _FluffyDescription;

  factory FluffyDescription.fromJson(Map<String, dynamic> json) =>
      _$FluffyDescriptionFromJson(json);
}

enum Group { format, genre, theme, content }

@freezed
class Title with _$Title {
  const factory Title({
    required String en,
  }) = _Title;
  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
}

enum TagType { tag }

@freezed
class Relationship with _$Relationship {
  const factory Relationship({
    required String id,
    required RelationshipType type,
    Related? related,
  }) = _Relationship;

  factory Relationship.fromJson(Map<String, dynamic> json) =>
      _$RelationshipFromJson(json);
}

enum Related {
  adapted_from,
  alternate_story,
  alternate_version,
  based_on,
  colored,
  doujinshi,
  main_story,
  monochrome,
  prequel,
  preserialization,
  same_franchise,
  shared_universe,
  sequel,
  serialization,
  side_story,
  spin_off
}

enum RelationshipType { artist, author, cover_art, creator, manga }

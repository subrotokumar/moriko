import 'package:dio/dio.dart';
import 'package:moriko/core/constants/constants.dart';
import 'package:moriko/model/chapter_list_res.dart';
import 'package:moriko/model/chapter_pages_res.dart';
import 'package:moriko/model/manga_cover_res.dart';
import 'package:moriko/model/searched_manga_res.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'manga_service.g.dart';

@Riverpod(keepAlive: true)
MangaService mangaServiceClient(MangaServiceClientRef ref,
        {required Dio dio}) =>
    MangaService(dio);

@RestApi(baseUrl: mangaApiBaseUrl)
abstract class MangaService {
  factory MangaService(Dio dio, {String baseUrl}) = _MangaService;

  @GET('/manga')
  Future<HttpResponse<SearchedMangaRes>> searchManga(
    @Query('title') String title,
  );

  @GET('/cover/{coverId}')
  Future<HttpResponse<MangaCoverResponse>> cover(
    @Path('coverId') String coverId,
  );

  @GET('/manga/{mangaId}/feed?translatedLanguage[]=en')
  Future<HttpResponse<ChapterListRes>> chapterList(
      @Path('mangaId') String mangaId);

  @GET('/at-home/server/{chapterId}')
  Future<HttpResponse<ChapterPagesRes>> chapterPages(
      @Path('chapterId') String chapterId);
}

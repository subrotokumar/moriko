// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:moriko/config/config.dart';
import 'package:moriko/core/core.dart';
import 'package:moriko/features/chapters/provider/provider.dart';
import 'package:moriko/features/reader/presentation/screen/reader_screen.dart';
import 'package:moriko/features/search/presentation/widget/cover_image.dart';
import 'package:moriko/model/chapter_list_res.dart';
import 'package:moriko/model/searched_manga_res.dart';

class ChaptersScreen extends ConsumerStatefulWidget {
  final SearchedManga searchedManga;
  const ChaptersScreen(this.searchedManga, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ChaptersScreenState();
}

class ChaptersScreenState extends ConsumerState<ChaptersScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final width = context.width;
    final isDarkMode = context.isDarkMode;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 55,
            collapsedHeight: 70,
            expandedHeight: 350,
            pinned: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(PhosphorIconsRegular.shareFat, size: 20),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(PhosphorIconsRegular.squaresFour),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(PhosphorIconsRegular.bookmarkSimple),
              ),
              const SizedBox(width: 8),
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: CoverImage(
                        coverId: widget.searchedManga.coverId,
                        mangaId: widget.searchedManga.id,
                        radius: 30,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.1, 0.4, .5, .8, 1],
                        colors: [
                          theme.scaffoldBackgroundColor.withOpacity(0.9),
                          theme.scaffoldBackgroundColor.withOpacity(0.2),
                          theme.scaffoldBackgroundColor.withOpacity(0.5),
                          theme.scaffoldBackgroundColor.withOpacity(0.7),
                          theme.scaffoldBackgroundColor,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      width: width,
                      height: 200,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Material(
                                  color: transparent,
                                  child: Text(
                                    widget.searchedManga.attributes.title.en,
                                    textAlign: TextAlign.start,
                                    maxLines: 3,
                                    style: poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: CoverImage(
                                coverId: widget.searchedManga.coverId,
                                mangaId: widget.searchedManga.id,
                                radius: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 300,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: context.width,
                      height: 28,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.searchedManga.attributes.tags.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final tag = widget.searchedManga.attributes.tags
                              .elementAt(index)
                              .attributes
                              .name
                              .en;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: theme.inputDecorationTheme.fillColor!
                                  .withOpacity(0.4),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: widget.searchedManga.attributes.description?.en != null,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: context.width,
                child: Text(
                  widget.searchedManga.attributes.description?.en ?? '',
                  textAlign: TextAlign.justify,
                  style: poppins(
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer(builder: (ctx, ref, child) {
              final chapterListResData = ref.watch(
                ChapterListResDataProvider(mangaId: widget.searchedManga.id),
              );
              return chapterListResData.when(error: (e, s) {
                logger.f(s);
                return Text(s.toString());
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              }, data: (d) {
                List<CoverListResData> data = List.from(d);
                data.sort((a, b) {
                  final aa = double.tryParse(a.attributes.chapter ?? '0') ?? 0;
                  final bb = double.tryParse(b.attributes.chapter ?? '0') ?? 0;
                  if (aa < bb)
                    return -1;
                  else if (aa > bb)
                    return 1;
                  else
                    return 0;
                });
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 70),
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (ctx, index) {
                    final chapterItem = data.elementAt(index);
                    final title = chapterItem.attributes.title;
                    final date = DateTime.tryParse(
                      chapterItem.attributes.publishAt ?? '',
                    );
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: ListTile(
                        dense: true,
                        tileColor: isDarkMode ? Colors.white12 : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ReaderScreen(
                              chapterItem.id,
                            ),
                          ));
                        },
                        leading: Text(
                          chapterItem.attributes.chapter ?? '?',
                          style: poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        title: Visibility(
                          visible: title != null && title.isNotEmpty,
                          replacement: Text(
                            'Chapter ${chapterItem.attributes.chapter ?? '?'}',
                            style: poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: Text(
                            chapterItem.attributes.title ??
                                'Chapter ${chapterItem.attributes.chapter ?? '?'}',
                            style: poppins(fontWeight: FontWeight.w500),
                          ),
                        ),
                        subtitle: Builder(builder: (context) {
                          if (date == null) {
                            return const SizedBox();
                          } else {
                            final d = date.toLocal().toString();
                            return Text(d.substring(0, d.indexOf(' ')));
                          }
                        }),
                        // trailing: Icon(
                        //   Icons.downloading,
                        //   size: 25,
                        //   color: theme.inputDecorationTheme.fillColor,
                        // ),
                      ),
                    );
                  },
                );
              });
            }),
          ),
        ],
      ),
    );
  }
}

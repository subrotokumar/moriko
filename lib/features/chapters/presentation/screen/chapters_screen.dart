// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.play_arrow),
      ),
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
                icon: const Icon(Icons.share, size: 20),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.library_add),
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
                      height: 30,
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
                              color: theme.inputDecorationTheme.fillColor!
                                  .withOpacity(0.9),
                            ),
                            child: Text(tag),
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
                  style: poppins(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer(builder: (ctx, ref, child) {
              final chapterListResData = ref.watch(
                  ChapterListResDataProvider(mangaId: widget.searchedManga.id));
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
                    return ListTile(
                      dense: true,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ReaderScreen(chapterItem.id),
                        ));
                      },
                      leading: Chip(
                          label: Text(chapterItem.attributes.chapter ?? '?')),
                      title: Builder(builder: (context) {
                        final title = chapterItem.attributes.title;
                        if (title != null && title.isNotEmpty) {
                          return Text(chapterItem.attributes.title ??
                              'Chapter ${chapterItem.attributes.chapter ?? '?'}');
                        } else {
                          return Text(
                            'Chapter ${chapterItem.attributes.chapter ?? '?'}',
                          );
                        }
                      }),
                      subtitle: Builder(builder: (context) {
                        final date = DateTime.tryParse(
                            chapterItem.attributes.publishAt ?? '');
                        if (date == null)
                          return const SizedBox();
                        else {
                          final d = date.toLocal().toString();
                          return Text(d.substring(0, d.indexOf(' ')));
                        }
                      }),
                      trailing: Icon(
                        Icons.downloading,
                        size: 25,
                        color: theme.inputDecorationTheme.fillColor,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/config.dart';
import 'package:moriko/core/core.dart';
import 'package:moriko/features/search/presentation/widget/cover_image.dart';
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
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20)
                    .copyWith(top: 10),
                height: 50,
                color: theme.bottomNavigationBarTheme.backgroundColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.heart_fill),
                    ),
                    const Spacer(),
                    Consumer(builder: (context, ref, child) {
                      final themeMode = ref.watch(currentThemeProvider);
                      return Visibility(
                        visible: themeMode != ThemeMode.system,
                        child: Switch(
                          value: themeMode == ThemeMode.light,
                          onChanged: (v) {
                            ref.read(currentThemeProvider.notifier).toggle();
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 40,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.topCenter,
                height: 10,
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                icon: const Icon(
                  Icons.ios_share_rounded,
                  weight: 40,
                ),
              ),
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.searchedManga.id,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CoverImage(
                        coverId: widget.searchedManga.coverId,
                        mangaId: widget.searchedManga.id,
                        radius: 30,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0, .1, .5, 1],
                          colors: [
                            theme.scaffoldBackgroundColor.withOpacity(0.2),
                            theme.scaffoldBackgroundColor.withOpacity(0.5),
                            theme.scaffoldBackgroundColor.withOpacity(0.7),
                            theme.scaffoldBackgroundColor,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 20,
                      right: 20,
                      child: SizedBox(
                        height: 200,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.searchedManga.attributes.title.en,
                                    textAlign: TextAlign.start,
                                    maxLines: 3,
                                    style: poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: CoverImage(
                                coverId: widget.searchedManga.coverId,
                                mangaId: widget.searchedManga.id,
                                radius: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 280,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: context.width,
                        height: 30,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.searchedManga.attributes.tags.length,
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
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: context.width,
              child: Text(
                widget.searchedManga.attributes.description.en ?? '',
                style: poppins(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

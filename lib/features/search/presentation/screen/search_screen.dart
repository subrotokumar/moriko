import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/config.dart';
import 'package:moriko/core/core.dart';
import 'package:moriko/core/providers/provider.dart';
import 'package:moriko/features/search/presentation/widget/cover_image.dart';
import 'package:moriko/features/search/presentation/widget/shimmering_gridview.dart';
import 'package:moriko/features/search/provider/searched_manga.provider.dart';
import 'package:moriko/model/searched_manga_res.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final searchCtr = TextEditingController();
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_rounded),
        title: TextField(
          onSubmitted: (_) => setState(() {}),
          onTapOutside: (_) => context.removeFocus(),
          controller: searchCtr,
          decoration: InputDecoration(
            constraints: const BoxConstraints(maxHeight: 45),
            hintText: 'Search Manga',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final searchedManga =
            ref.watch(searchedMangaProvider(title: searchCtr.text));
        return searchedManga.when(
          data: (data) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 4 / 7,
                mainAxisSpacing: 25,
                crossAxisSpacing: 16,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      bottom: 40,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final mangaId = data[index].id;
                          String coverId = data[index].coverId;
                          return GestureDetector(
                            onTap: () =>
                                ChaptersScreenRoute(data[index]).push(context),
                            child: Hero(
                              tag: data[index].id,
                              child: CoverImage(
                                coverId: coverId,
                                mangaId: mangaId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        alignment: Alignment.topLeft,
                        child: Text(
                          data.elementAt(index).attributes.title.en,
                          maxLines: 2,
                          style: poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          error: (e, s) {
            debugPrint('Error ${s.toString()}');
            return Center(child: Text(e.toString()));
          },
          loading: () => const ShimmeringGridView(),
        );
      }),
    );
  }
}

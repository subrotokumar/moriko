// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:moriko/core/core.dart';
import 'package:moriko/features/reader/presentation/widgets/horizontal_reader.dart';
import 'package:moriko/features/reader/presentation/widgets/reader_bottom_navbar.dart';
import 'package:moriko/features/reader/presentation/widgets/vertical_reader.dart';
import 'package:moriko/features/reader/provider/provider.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  final String chapterId;
  const ReaderScreen(this.chapterId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chapterPages =
        ref.watch(ChapterPagesResProvider(chapterId: widget.chapterId));
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          //* READER
          GestureDetector(
            onTap: () => ref.read(bottomNavVisibiltyProvider.notifier).toogle(),
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: Consumer(builder: (context, ref, child) {
                final readerScrollDirection =
                    ref.watch(readerScrollDirectionProvider);
                return chapterPages.when(
                  error: (e, s) {
                    return const Center(
                      child: Text(
                        'Request returned an Invalid staus code of 404',
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  data: (res) {
                    if (readerScrollDirection == Axis.vertical) {
                      return VerticleReader(response: res);
                    } else {
                      return HorizontalReader(
                        response: res,
                        pageController: pageController,
                      );
                    }
                  },
                );
              }),
            ),
          ),
          //* Appbar
          const Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 80,
              child: PreferredSize(
                preferredSize: Size.fromHeight(45),
                child: ReaderAppBar(),
              ),
            ),
          ),
          //* Bottom Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer(builder: (context, ref, chidl) {
              final bottomNavVisibilty = ref.watch(bottomNavVisibiltyProvider);
              final pageNumber = ref.watch(pageNumberProvider);
              final chapterPages = ref
                  .watch(ChapterPagesResProvider(chapterId: widget.chapterId));
              return chapterPages.maybeWhen(
                orElse: () => const SizedBox(width: 0, height: 0),
                data: (d) => Visibility(
                  visible: bottomNavVisibilty,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //* Page Number Indicator
                      Consumer(builder: (context, ref, child) {
                        final scrollDir =
                            ref.watch(readerScrollDirectionProvider);
                        final dataSavedEnabled =
                            ref.watch(dataSaverModeProvider);
                        final data = dataSavedEnabled
                            ? d.chapter.dataSaver
                            : d.chapter.data;
                        return Visibility(
                          visible: scrollDir == Axis.horizontal,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20)
                                .copyWith(bottom: 20),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: context
                                    .theme.inputDecorationTheme.fillColor!
                                    .withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (pageNumber == 0) return;
                                      pageController.jumpToPage(pageNumber - 1);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 15,
                                    ),
                                  ),
                                  Flexible(
                                    child: Slider(
                                      label:
                                          '${pageNumber + 1} / ${data.length}',
                                      divisions: data.length - 1,
                                      allowedInteraction:
                                          SliderInteraction.tapAndSlide,
                                      min: 0,
                                      max: data.length.toDouble(),
                                      value: pageNumber.toDouble(),
                                      onChanged: (v) =>
                                          pageController.jumpToPage(v.toInt()),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (data.length == pageNumber) return;
                                      pageController.jumpToPage(pageNumber + 1);
                                    },
                                    icon: const Icon(Icons.arrow_forward_ios,
                                        size: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      //* Reader Bottom Nav Bar
                      const ReaderBottomNavBar(),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ReaderAppBar extends StatelessWidget {
  const ReaderAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final visible = ref.watch(bottomNavVisibiltyProvider);
      final theme = context.theme;
      return GestureDetector(
        onTap: () => ref.read(bottomNavVisibiltyProvider.notifier).toogle(),
        child: Visibility(
          visible: visible,
          child: AppBar(
            backgroundColor: theme.appBarTheme.backgroundColor,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(PhosphorIconsBold.arrowUpLeft),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(PhosphorIconsRegular.bookmarks),
              )
            ],
          ),
        ),
      );
    });
  }
}

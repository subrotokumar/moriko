import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/config.dart';
import 'package:moriko/core/core.dart';
import 'package:moriko/features/reader/provider/provider.dart';
import 'package:moriko/model/chapter_pages_res.dart';

class HorizontalReader extends ConsumerWidget {
  final ChapterPagesRes response;
  final PageController pageController;
  const HorizontalReader({
    super.key,
    required this.pageController,
    required this.response,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataSavedEnabled = ref.watch(dataSaverModeProvider);
    final data =
        dataSavedEnabled ? response.chapter.dataSaver : response.chapter.data;
    final baseUrl = response.baseUrl;
    final hash = response.chapter.hash;

    final height = context.height;
    final width = context.width;
    return Stack(
      children: [
        Positioned.fill(
          child: PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: pageController,
            onPageChanged: (v) => ref.read(pageNumberProvider.notifier).set(v),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final horizontalBoxFit =
                          ref.watch(horizontalBoxFitProvider);
                      double? ww = switch (horizontalBoxFit) {
                        BoxFit.fitWidth => width,
                        BoxFit.fill => width,
                        _ => null,
                      };
                      double? hh = switch (horizontalBoxFit) {
                        BoxFit.fitHeight => height,
                        BoxFit.fill => height,
                        _ => null,
                      };
                      return ExtendedImage.network(
                        '$baseUrl/${dataSavedEnabled ? 'data-saver' : 'data'}/$hash/${data.elementAt(index)}',
                        fit: horizontalBoxFit,
                        height: hh,
                        width: ww,
                        enableSlideOutPage: true,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Consumer(
            builder: (context, ref, child) {
              final pageNumber = ref.watch(pageNumberProvider);
              return GestureDetector(
                onTap: () {
                  if (pageNumber == 0) return;
                  pageController.animateToPage(
                    pageNumber - 1,
                    duration: 300.milliseconds,
                    curve: Curves.linear,
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  width: 50,
                  height: height,
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Consumer(
            builder: (context, ref, child) {
              final pageNumber = ref.watch(pageNumberProvider);
              return GestureDetector(
                onTap: () {
                  if (data.length == pageNumber) return;
                  pageController.animateToPage(
                    pageNumber + 1,
                    duration: 300.milliseconds,
                    curve: Curves.linear,
                  );
                },
                child: Container(
                  color: transparent,
                  width: 50,
                  height: height,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

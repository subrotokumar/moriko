import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/config.dart';
import 'package:moriko/core/core.dart';
import 'package:moriko/model/chapter_pages_res.dart';

class VerticleReader extends ConsumerStatefulWidget {
  final ChapterPagesRes response;
  const VerticleReader({super.key, required this.response});

  @override
  ConsumerState<VerticleReader> createState() => _VerticleReaderState();
}

class _VerticleReaderState extends ConsumerState<VerticleReader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final dataSavedEnabled = ref.watch(dataSaverModeProvider);
    final baseUrl = widget.response.baseUrl;
    final hash = widget.response.chapter.hash;
    final data = dataSavedEnabled
        ? widget.response.chapter.dataSaver
        : widget.response.chapter.data;
    final width = context.width;
    return InteractiveViewer(
      maxScale: 5,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: data.length,
        separatorBuilder: (c, i) => PageDivider(i + 1),
        itemBuilder: (ctx, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: white,
            child: ExtendedImage.network(
              '$baseUrl/${dataSavedEnabled ? 'data-saver' : 'data'}/$hash/${data.elementAt(index)}',
              width: width,
              // enableSlideOutPage: true,
            ),
          );
        },
      ),
    );
  }
}

class PageDivider extends StatelessWidget {
  const PageDivider(this.i, {super.key});
  final int i;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          const SizedBox(width: 20),
          const Icon(Icons.keyboard_arrow_up_outlined),
          Text('$i'),
          const Spacer(),
          const Text('Pages'),
          const Spacer(),
          Text((i + 1).toString()),
          const Icon(Icons.keyboard_arrow_down_outlined),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

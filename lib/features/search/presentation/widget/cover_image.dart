import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/config.dart';
import 'package:moriko/core/core.dart';
import 'package:moriko/features/search/provider/searched_manga.provider.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    super.key,
    required this.coverId,
    required this.mangaId,
    this.radius = 10,
  });

  final String coverId;
  final String mangaId;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Consumer(
        builder: (context, ref, child) {
          final mangaCover = ref.watch(mangaCoverProvider(coverId: coverId));
          return mangaCover.when(
            data: (fileName) => CachedNetworkImage(
              imageUrl: '$coverImageUrl/$mangaId/$fileName',
              fit: BoxFit.cover,
            ),
            error: (e, s) => Container(
              color: grey.shade300,
              child: const Center(
                child: Icon(Icons.image, color: grey),
              ),
            ),
            loading: () => Shimmer(
              child: Container(
                color: grey.shade300,
                child: const Center(
                  child: Icon(
                    Icons.image,
                    color: grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

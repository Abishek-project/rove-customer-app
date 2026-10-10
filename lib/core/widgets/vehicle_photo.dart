import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../app/theme/rove_tokens.dart';
import 'skeleton.dart';

/// A vehicle photo from a backend-provided URL, cached, with a skeleton while
/// loading and a quiet fallback when there is no image or it fails. The
/// layout never depends on the network.
class VehiclePhoto extends StatelessWidget {
  const VehiclePhoto({
    super.key,
    required this.url,
    required this.semanticLabel,
    this.aspectRatio = 16 / 10,
    this.radius = RoveRadius.card,
    this.memCacheWidth = 900,
  });

  final String? url;
  final String semanticLabel;
  final double aspectRatio;
  final double radius;
  final int memCacheWidth;

  @override
  Widget build(BuildContext context) {
    final fallback = DecoratedBox(
      decoration: BoxDecoration(color: context.colors.inputFill),
      child: Center(
        child: Icon(
          Icons.directions_car_outlined,
          size: 40,
          color: context.colors.textTertiary,
          semanticLabel: semanticLabel,
        ),
      ),
    );
    final image = (url == null || url!.isEmpty)
        ? fallback
        : CachedNetworkImage(
            imageUrl: url!,
            fit: BoxFit.cover,
            memCacheWidth: memCacheWidth,
            fadeInDuration: RoveMotion.normal,
            placeholder: (_, _) => Skeleton(radius: radius),
            errorWidget: (_, _, _) => fallback,
            imageBuilder: (context, provider) => Semantics(
              image: true,
              label: semanticLabel,
              child: Image(image: provider, fit: BoxFit.cover),
            ),
          );
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: image,
      ),
    );
  }
}

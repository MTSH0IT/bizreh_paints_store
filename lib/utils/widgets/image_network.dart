import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/consts/const_key.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    super.key,
    required this.image,
    this.icon = Icons.image_not_supported,
    this.fit = BoxFit.contain,
  });
  final String image;
  final IconData icon;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: JsonKey.urlImageUploads + image,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          Icon(icon, size: 40, color: Colors.black54),
      fit: fit,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

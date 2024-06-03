import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hidjab_user/screens/global_widgets/simmer_item.dart';
import 'package:hidjab_user/utils/image/appimage.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: BoxFit.fill,
      placeholder: (context, s) {
        return ShimmerItem(
          width: width,
          height: height,
        );
      },
      errorWidget: (context, s, w) {
        return Image.asset(
          AppImages.errorForImage,
          width: width,
          height: height,
          fit: BoxFit.fill,
        );
      },
    );
  }
}

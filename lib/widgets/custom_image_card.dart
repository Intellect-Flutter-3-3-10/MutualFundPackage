import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../res/app_dimens.dart';

class CustomImageCard extends StatelessWidget {
  final double? radius;
  final double? height;
  final double? width;
  final String image;

  CustomImageCard({
    super.key,
    this.radius = AppDimens.appRadius6,
    this.height = 250,
    this.width = 250,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.appRadius6),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        height: height,
        width: width,
      ),
    );
  }
}

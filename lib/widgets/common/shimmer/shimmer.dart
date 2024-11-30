import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget squareShimmer({double? width, double? height, double? borderRadius = 6}) {
  return SizedBox(
    width: width,
    height: height,
    child: Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.5),
      highlightColor: Colors.grey.withOpacity(0.2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey, // Background color for the shimmer effect
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        alignment: Alignment.center,
      ),
    ),
  );
}

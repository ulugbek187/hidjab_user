import 'package:flutter/material.dart';
import 'package:hidjab_user/utils/styles/size.dart';
import 'package:shimmer/shimmer.dart';

class GlobalShimmerWidget extends StatelessWidget {
  const GlobalShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width/3,
        height: height/4,
        color: Colors.white,
        child: const Center(
          child: Text(
            'Loading...',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

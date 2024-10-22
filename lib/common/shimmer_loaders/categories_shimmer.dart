
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Container(
            width: 150.0,
            height: 20.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            height: 20.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

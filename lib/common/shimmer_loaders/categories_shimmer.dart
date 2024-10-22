import 'package:flutter/material.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/gaps.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.symmetric(horizontal: Gaps.smallGap),
              child: Container(
                decoration: BoxDecoration(
                  // color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: size.height * 0.18,
                width: size.height * 0.18,
                margin: EdgeInsets.symmetric(horizontal: Gaps.smallGap),
                // color: AppColors.cardBgColor,
              ),
            ),
          );
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/progress_indicator.dart';
import 'package:myrecipediary/constants/gaps.dart';

import '../constants/colors.dart';
import '../constants/font_sizes.dart';

Widget loadingButton(
        {required onPressed, required String text, required double width}) =>
    SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              const MaterialStatePropertyAll(AppColors.secondaryColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppProgressIndicator.circularProgressIndicator(
              width: 20.0,
              height: 20.0,
            ),
            horizontalGap(Gaps.smallGap),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontSize: FontSizes.smallFont),
            ),
          ],
        ),
      ),
    );

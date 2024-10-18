import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/constants/gaps.dart';

import '../constants/font_sizes.dart';

Widget elevatedButton(
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
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: FontSizes.smallFont),
        ),
      ),
    );

Widget googleElevatedButton(
        {required onPressed, required String text, required double width}) =>
    SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(AppColors.lightGreyColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 20,
                width: 20,
                child: Image.asset("assets/images/google.png")),
            Container(
              margin: EdgeInsets.only(left: Gaps.mediumGap),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black45, fontSize: FontSizes.smallFont),
              ),
            ),
          ],
        ),
      ),
    );

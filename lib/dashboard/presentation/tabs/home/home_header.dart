


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/gaps.dart';
import '../../../../common/text_form_field.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/font_sizes.dart';
import '../../../../constants/gaps.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      height: size.height * 0.29,
      width: size.width,
      padding: EdgeInsets.symmetric(
          vertical: Gaps.bigMediumGap, horizontal: Gaps.smallGap),
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // verticalGap(Gaps.extraLargeGap),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Adedoyin,",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.arsenal(
                        fontSize: FontSizes.mediumFont,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalGap(Gaps.extraSmallGap),
                    Text(
                      "What would you like to\ncook today?",
                      style: GoogleFonts.arsenal(
                        fontSize: FontSizes.largeFont,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipOval(
                        child: Image.asset(
                          "assets/images/onboarding.jpg",
                          fit: BoxFit.cover,
                        )))
              ],
            ),
          ),
          // verticalGap(Gaps.mediumGap),
          TextFormField_.textFormField(
              prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
              isObscured: false, filledColor: Colors.white)
        ],
      ),
    );
  }
}

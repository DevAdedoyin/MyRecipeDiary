import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/text_form_field.dart';
import 'package:myrecipediary/constants/gaps.dart';
import 'package:myrecipediary/dashboard/presentation/tabs/home/home_header.dart';
import 'package:myrecipediary/dashboard/presentation/tabs/home/recipe_category.dart';
import 'package:myrecipediary/dashboard/presentation/tabs/home/recommended.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/font_sizes.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height, // Set height constraint
          maxWidth: size.width
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            verticalGap(Gaps.mediumGap),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: Gaps.mediumGap),
              child: Text("Categories", style: textTheme.headlineSmall),
            ),
            const HomeCategory(),
            verticalGap(Gaps.mediumGap),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: Gaps.mediumGap),
              child: Text("Recommended", style: textTheme.headlineSmall),
            ),
            const RecommendedRecipes()
          ],
        ),
      ),
    );
  }
}

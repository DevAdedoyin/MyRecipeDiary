import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/recipe_card.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/constants/font_sizes.dart';
import 'package:myrecipediary/constants/gaps.dart';

class MyRecipeTab extends ConsumerStatefulWidget {
  const MyRecipeTab({super.key});

  @override
  ConsumerState<MyRecipeTab> createState() => _MyRecipeTabState();
}

class _MyRecipeTabState extends ConsumerState<MyRecipeTab> {
  int len = 3;
  int extraLen = 6;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "My recipes",
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: FontSizes.mediumFont),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: ListView.builder( itemBuilder: (_, index) {
        return RecipeCard(
          index: index,
        );
      }, itemCount: 6),
    );
  }
}

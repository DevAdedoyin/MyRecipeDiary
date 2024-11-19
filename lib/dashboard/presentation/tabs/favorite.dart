import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/recipe_card.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_sizes.dart';
import '../../../constants/gaps.dart';

class FavoriteTab extends ConsumerStatefulWidget {
  const FavoriteTab({super.key});

  @override
  ConsumerState<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends ConsumerState<FavoriteTab> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Favourite recipes",
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

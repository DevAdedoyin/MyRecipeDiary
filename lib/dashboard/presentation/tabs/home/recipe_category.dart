import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myrecipediary/common/shimmer_loaders/categories_shimmer.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/constants/gaps.dart';
import 'package:myrecipediary/dashboard/domain/category.dart';
import 'package:myrecipediary/routing/app_routes.dart';
import 'package:myrecipediary/routing/go_router_provider.dart';

import '../../../../constants/font_sizes.dart';
import '../../../data/data_sources/recipe_category_data_source.dart';
import '../../../domain/recipe_category_image.dart';
import '../../../repository/category_repo.dart';

class HomeCategory extends ConsumerStatefulWidget {
  const HomeCategory({super.key});

  @override
  ConsumerState<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends ConsumerState<HomeCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final selectedCategory_ = ref.watch(selectedCategory);
    return Container(
      margin: EdgeInsets.symmetric(vertical: Gaps.smallGap),
      height: size.height * 0.18,
      child: FutureBuilder<ListOfCategoryModel>(
          future: RecipeCategoriesDataSource.fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerLoader();
            } else if (snapshot.hasError) {
              return const ShimmerLoader();
            }
            return ListView.builder(
                itemBuilder: (_, index) {
                  final data = snapshot.data?.listOfCategoryModel[index];
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedCategory.notifier).state =
                          data.strCategory;
                      goRouter.push(AppRoutes.categoryMealScreen);
                    },
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.symmetric(horizontal: Gaps.smallGap),
                      child: Container(
                        height: size.height * 0.18,
                        width: size.height * 0.18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              RecipeCategoryImages
                                  .recipeCategoryImages[index].images,
                            ),
                          ),
                        ),
                        child: Container(
                          width: size.height * 0.18,
                          height: size.height * 0.04,
                          color: Colors.black.withOpacity(0.65),
                          alignment: Alignment.center,
                          child: Text(
                            data!.strCategory,
                            style: GoogleFonts.openSans(
                              fontSize: FontSizes.mediumFont,
                              shadows: [
                                const Shadow(
                                  offset: Offset(2.0, 2.0), // Shadow position
                                  blurRadius: 3.0, // Shadow blur effect
                                  color: Colors.black, // Shadow color
                                ),
                              ],
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: 14);
          }),
    );
  }
}

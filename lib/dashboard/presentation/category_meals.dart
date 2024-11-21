import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myrecipediary/constants/gaps.dart';

import '../../common/shimmer_loaders/categories_shimmer.dart';
import '../../constants/colors.dart';
import '../../constants/font_sizes.dart';
import '../data/data_sources/category_items_data.dart';
import '../repository/category_repo.dart';

class CategoryMealsScreen extends ConsumerStatefulWidget {
  const CategoryMealsScreen({super.key});

  @override
  ConsumerState<CategoryMealsScreen> createState() =>
      _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends ConsumerState<CategoryMealsScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedCategory_ = ref.watch(selectedCategory);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "$selectedCategory_ Meals",
          style: GoogleFonts.roboto(
              color: Colors.white, fontSize: FontSizes.mediumFont),
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: FutureBuilder(
          future: RecipeCategoriesMealsDataSource.fetchCategoryMeals(
              category: selectedCategory_),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerLoader();
            } else if (snapshot.hasError) {
              return const ShimmerLoader();
            }

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1,
                    mainAxisSpacing: 14),
                itemCount: snapshot.data?.listOfCategoryItemsModel.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemBuilder: (_, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        // Background
                        Container(
                          child: Image.network(snapshot.data!
                              .listOfCategoryItemsModel[index].strMealThumb),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              // Handle the like button action here
                              print('Liked: ${snapshot.data!.listOfCategoryItemsModel[index].strMeal}');
                            },
                            child: Icon(
                              Icons.favorite, // Use Icons.favorite for a filled heart
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                        // Overlayed text
                        Positioned(
                          bottom: 1,

                          // alignment: Alignment.bottomRight,
                          child: Container(
                            height: 50,
                            width: size.width / 2 - 14,
                            color: Colors.black.withOpacity(0.5),
                            alignment: Alignment.center,
                            child: Text(
                              snapshot.data!.listOfCategoryItemsModel[index]
                                  .strMeal,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                fontSize: FontSizes.mediumFont,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(2.0, 2.0),
                                    // Shadow position
                                    blurRadius: 3.0,
                                    // Shadow blur effect
                                    color: Colors.black, // Shadow color
                                  ),
                                ],
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}

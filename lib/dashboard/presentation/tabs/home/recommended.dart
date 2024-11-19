import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/shimmer_loaders/recommended_shimmer.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/constants/gaps.dart';

import '../../../../constants/font_sizes.dart';

class RecommendedRecipes extends StatefulWidget {
  const RecommendedRecipes({super.key});

  @override
  State<RecommendedRecipes> createState() => _RecommendedRecipesState();
}

class _RecommendedRecipesState extends State<RecommendedRecipes> {
  @override
  Widget build(BuildContext context) {
    final recommendedKey = dotenv.env['RECOMMENDED'];
    CollectionReference recommended =
        FirebaseFirestore.instance.collection('recommended');
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
        future: recommended.doc(recommendedKey).get(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            print("ERROR ${snapshot.error}");
            return const RecommendedShimmerLoader();
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const RecommendedShimmerLoader();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print("DATA ${snapshot.data!.data()}");
            Map<String, dynamic> recommendedData =
                snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> data = recommendedData["breakfast"] as List<dynamic>;
            print("BREAKFAST2 ${data[2]} ");
            print("LENGTH ${data.length}");
            return CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                enableInfiniteScroll: true,
                enlargeFactor: 0.3,
                initialPage: 0,
              ),
              items: data.map((mealObject) {
                return Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        mealObject["meal_image"] ?? mealObject["meal_image "],
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.accentColor.shade300,
                                borderRadius: BorderRadius.circular(15)),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite),
                                color: Colors.redAccent.shade700,
                                iconSize: 35),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: double.maxFinite,
                          height: size.height * 0.04,
                          color: Colors.black.withOpacity(0.65),
                          child: Text(
                            "${mealObject["meal_name"] ?? mealObject["meal_name "]}",
                            style: GoogleFonts.openSans(
                              fontSize: FontSizes.bigMediumFont,
                              shadows: [
                                const Shadow(
                                  offset: Offset(3.0, 3.0), // Shadow position
                                  blurRadius: 3.0, // Shadow blur effect
                                  color: Colors.black, // Shadow color
                                ),
                              ],
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          height: size.height * 0.04,
                          color: Colors.black.withOpacity(0.65),
                          child: Text(
                            "${mealObject["meal_ingredients"].length} Ingredients | 45 mins",
                            style: GoogleFonts.openSans(
                              fontSize: FontSizes.smallFont,
                              shadows: [
                                const Shadow(
                                  offset: Offset(3.0, 3.0), // Shadow position
                                  blurRadius: 3.0, // Shadow blur effect
                                  color: Colors.black, // Shadow color
                                ),
                              ],
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        verticalGap(Gaps.mediumGap)
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }
          return const RecommendedShimmerLoader();
        });
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

import '../../../../common/alert_dialogs/error_alert_dialog.dart';
import '../../../../common/alert_dialogs/success_alert_dialog.dart';
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

    return StreamBuilder<QuerySnapshot>(
        stream: recommended.snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            print("ERROR ${snapshot.error}");
            return const RecommendedShimmerLoader();
          }

          if (!snapshot.hasData) {
            print("TEST ${snapshot}");
            return const RecommendedShimmerLoader();
          }
          if (snapshot.hasData) {
            // print("DATA ${snapshot.data!.data()}");
            print("RECOM ${snapshot.data?.docs[0].data()}");
            final recommendedData = snapshot.data!.docs;
            print("RECOMMENDED $recommendedData");
            // List<dynamic> data = recommendedData["breakfast"] as List<dynamic>;
            // print("BREAKFAST2 ${data[2]} ");
            // print("LENGTH ${data.length}");
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
              items: recommendedData.map((mealObject_) {
                // Object jsonData = jsonDecode(mealObject as String);
                // print(
                //     "TEST OBJECT ${mealObject_.data() as Map<String, dynamic>}");
                final mealObject = mealObject_.data() as Map<String, dynamic>;
                return Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        mealObject["strMealThumb"] ??
                            mealObject["strMealThumb "],
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
                                onPressed: () async {
                                  toggleFavorite(mealObject, mealObject_.id);
                                },
                                icon: Icon(
                                  mealObject["isFavorite"] ??
                                          mealObject["isFavorite "]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                color: Colors.redAccent.shade700,
                                iconSize: 35),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: double.maxFinite,
                          // height: size.height * 0.04,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.75),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Column(
                            children: [
                              Text(
                                "${mealObject["strMeal"] ?? mealObject["strMeal "]}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  fontSize: FontSizes.bigMediumFont,
                                  shadows: [
                                    const Shadow(
                                      offset: Offset(3.0, 3.0),
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
                              Text(
                                "${mealObject["strCategory"] ?? mealObject["strCategory "]}",
                                style: GoogleFonts.openSans(
                                  fontSize: FontSizes.smallFont,
                                  shadows: [
                                    const Shadow(
                                      offset: Offset(3.0, 3.0),
                                      // Shadow position
                                      blurRadius: 3.0,
                                      // Shadow blur effect
                                      color: Colors.black, // Shadow color
                                    ),
                                  ],
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   width: double.maxFinite,
                        //   height: size.height * 0.04,
                        //   color: Colors.black.withOpacity(0.65),
                        //   child: Text(
                        //     "${mealObject["meal_ingredients"].length} Ingredients | 45 mins",
                        //     style: GoogleFonts.openSans(
                        //       fontSize: FontSizes.smallFont,
                        //       shadows: [
                        //         const Shadow(
                        //           offset: Offset(3.0, 3.0), // Shadow position
                        //           blurRadius: 3.0, // Shadow blur effect
                        //           color: Colors.black, // Shadow color
                        //         ),
                        //       ],
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //   ),
                        // ),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isFavorite = false;

  Future<void> toggleFavorite(
      Map<String, dynamic> mealObject, String mealObjectId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      print("User not logged in");
      return;
    }

    setState(() {
      isFavorite = !isFavorite;
    });

    final recipesRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('recipes');

    final recipeName = mealObject["strMeal"] ?? mealObject["strMeal "];
    final favorite =
        mealObject["isFavorite"] ?? mealObject["isFavorite "] == true
            ? false
            : true; // Ensure 'isFavorite' exists

    try {
      // Check if the item exists
      final querySnapshot = await recipesRef
          .where("strMeal", isEqualTo: recipeName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update isFavorite if the item exists
        FirebaseFirestore.instance
            .collection('recommended')
            .doc(mealObjectId)
            .update({"isFavorite": favorite});
        final docId = querySnapshot.docs.first.id;
        await recipesRef.doc(docId).update({'isFavorite': favorite});
        print("Updated existing recipe with name: $recipeName");
      } else {
        // Add the new item if it doesn't exist
        FirebaseFirestore.instance
            .collection('recommended')
            .doc(mealObjectId)
            .update({"isFavorite": true});
        mealObject.remove("isFavorite ");
        mealObject['isFavorite'] = true;
        await recipesRef.add(mealObject);
        print("Added new recipe with name: $recipeName");
      }
    } catch (e) {
      print("Error adding or updating recipe: $e");
    }
  }
}

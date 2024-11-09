import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myrecipediary/common/shimmer_loaders/recommended_shimmer.dart';
import 'package:myrecipediary/constants/colors.dart';

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
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        mealObject["meal_image"] ?? mealObject["meal_image "],
                      ),
                    ),
                  ),
                  child: Text(
                      "${mealObject["meal_name"] ?? mealObject["meal_name "]}"),
                );
              }).toList(),
            );
          }
          return const RecommendedShimmerLoader();
        });
  }
}

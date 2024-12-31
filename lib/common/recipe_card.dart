import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/font_sizes.dart';
import '../constants/gaps.dart';
import 'gaps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeCard extends StatefulWidget {
  final index;
  final String recipeId; // ID of the recipe
  final Map<String, dynamic> recipeData; // Recipe details to save

  const RecipeCard({
    required this.index,
    required this.recipeData,
    required this.recipeId,
    super.key,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  List<String> tempImages = [
    "assets/images/chicken.jpg",
    "assets/images/dessert.jpg",
    "assets/images/lamb.jpg",
    "assets/images/pork.jpg",
    "assets/images/seafood.jpg",
    "assets/images/vegan.jpg",
  ];

  @override
  void initState() {
    super.initState();
    isFavorite = widget.recipeData['isFavorite'] ?? widget.recipeData['isFavorite '] ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    print("RECIPE DATA ${widget.recipeData['strMeal	']}");

    // print("RECIPES PRINT ${snapshot.docs}");

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(
            horizontal: Gaps.smallGap, vertical: Gaps.smallGap),
        elevation: 5,
        child: Container(
          // width: size.width * 0.5,
          height: size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.recipeData["strMealThumb	"] ?? widget.recipeData["strMealThumb "] ?? widget.recipeData["strMealThumb"],
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text(
                      widget.recipeData["strCategory	"] ?? widget.recipeData["strCategory"],
                      style: GoogleFonts.openSans(
                        fontSize: FontSizes.mediumFont,
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
                    )),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.accentColor.shade300,
                            borderRadius: BorderRadius.circular(15)),
                        child: IconButton(
                            onPressed: toggleFavorite,
                            icon: Icon(
                              widget.recipeData["isFavorite"] ?? widget.recipeData["isFavorite "]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            color: Colors.redAccent.shade700,
                            iconSize: 35),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                  width: double.maxFinite,
                  height: size.height * 0.06,
                  color: Colors.black.withOpacity(0.55),
                  padding: EdgeInsets.only(left: Gaps.smallGap),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.recipeData["strMeal	"] ?? widget.recipeData["strMeal"] ?? widget.recipeData["strMeal "] ,
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
                  ))
            ],
          ),
        ),
      ),
    );
  }

  bool isFavorite = false;

  void checkIfFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(widget.recipeId)
        .get();

    setState(() {
      // isFavorite = doc.exists;
    });
  }

  Future<void> toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      isFavorite = !isFavorite;
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('recipes')
        .doc(widget.recipeId)
      .update({'isFavorite': isFavorite});

    // if (docSnapshot.exists) {
    //   setState(() {
    //     isFavorite = docSnapshot.data()?['isFavorite'] ?? false;
    //   });
    // }
  }
}

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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    final user = FirebaseAuth.instance.currentUser;

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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .collection('recipes')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("You have no recipes yet"));
            }

            final myRecipes_ = snapshot.data!.docs;
            // final data_ = FirebaseFirestore.instance
            //     .collection('users')
            //     .doc(user?.uid)
            //     .collection('recipes').get();

            return ListView.builder(
                itemBuilder: (_, index) {
                  final recipe =
                      myRecipes_[index].data() as Map<String, dynamic>;
                    // print("RECIPE ${recipe}");
                  return RecipeCard(
                    index: index,
                    recipeData: recipe,
                    recipeId: myRecipes_[index].id,
                  );
                },
                itemCount: myRecipes_.length);
          }),
    );
  }
}

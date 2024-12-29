import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Stream<List<Map<String, dynamic>>> getFavoriteRecipesStream() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('recipes')
          .where('isFavorite', isEqualTo: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                final data = doc.data();
                data['id'] = doc.id; // Include the document ID
                return data;
              }).toList());
    }

    // Return an empty stream if the user is null
    return const Stream<List<Map<String, dynamic>>>.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Favourite recipes",
            style: GoogleFonts.roboto(
                color: Colors.white, fontSize: FontSizes.mediumFont),
          ),
          backgroundColor: AppColors.secondaryColor,
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: getFavoriteRecipesStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No favorite recipes found.'));
              } else {
                final recipes = snapshot.data!;
                return ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    print("REC $recipe");
                    print("RECID ${recipes[index]["id"]}");
                    return RecipeCard(
                        index: index,
                        recipeData: recipe,
                        recipeId: recipe["id"]);
                  },
                );
              }
            }));
  }
}

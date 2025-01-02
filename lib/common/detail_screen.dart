import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/constants/gaps.dart';

import '../constants/colors.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({super.key});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  bool _expanded = false;
  late List validIngredients = [];
  late List validIngredientsQty = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validIngredients = ref
        .read(recipeDetailData.notifier)
        .state
        .entries
        .where((entry) =>
            entry.key.startsWith('strIngredient') &&
            entry.value?.isNotEmpty == true)
        .toList();

    validIngredientsQty = ref
        .read(recipeDetailData.notifier)
        .state
        .entries
        .where((entry) =>
            entry.key.startsWith('strMeasure') &&
            entry.value?.isNotEmpty == true)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final recipeData = ref.watch(recipeDetailData);
    Size size = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    int visibleItemCount = _expanded ? validIngredients.length : 3;

    double itemHeight = 70.0; // Approximate height of each ListTile
    double containerHeight = visibleItemCount * itemHeight;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: SizedBox(
                    height: size.height * 0.45,
                    width: double.maxFinite,
                    child: Image.network(
                      recipeData["strMealThumb"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            verticalGap(Gaps.smallGap),
            Container(
                alignment: Alignment.center,
                width: size.width * 0.9,
                child: Text(
                  recipeData["strMeal"],
                  style: textTheme.headlineLarge,
                )),
            verticalGap(Gaps.extraSmallGap),
            Container(
                alignment: Alignment.center,
                width: size.width * 0.9,
                child: Text(recipeData["strCategory"],
                    style: textTheme.labelLarge)),
            verticalGap(Gaps.smallGap),
            Container(
              alignment: Alignment.center,
              width: size.width * 0.9,
              child: Row(
                children: [
                  const Text("Ingredients"),
                  const Spacer(),
                  GestureDetector(
                    child: Text(
                      _expanded ? 'See Less' : 'See More',
                      style: textTheme.labelMedium,
                    ),
                    onTap: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                  ),
                  horizontalGap(Gaps.extraSmallGap),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    child: Icon(
                      _expanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_circle_down_outlined,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: containerHeight,
              width: double.maxFinite,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: validIngredients.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.kitchen,
                          color: AppColors.secondaryColor,
                        ),
                        title: Text("${recipeData['strIngredient$index']}"),
                        subtitle: Text(
                          'Quantity: ${recipeData['strMeasure$index']}',
                          style: textTheme.labelMedium,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: Gaps.smallGap),
                alignment: Alignment.centerLeft,
                width: size.width * 0.9,
                child: const Text("Description")),
            Container(
                width: size.width * 0.9,
                child: Text(
                  recipeData['strInstructions'],
                  style: textTheme.labelMedium,
                )),
          ],
        ),
      ),
    );
  }
}

final recipeDetailData = StateProvider<Map<String, dynamic>>((ref) => {});

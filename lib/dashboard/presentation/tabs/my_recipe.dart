import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/constants/font_sizes.dart';
import 'package:myrecipediary/constants/gaps.dart';

class MyRecipeTab extends ConsumerStatefulWidget {
  const MyRecipeTab({super.key});

  @override
  ConsumerState<MyRecipeTab> createState() => _MyRecipeTabState();
}

class _MyRecipeTabState extends ConsumerState<MyRecipeTab> {
  int len = 3;
  int extraLen = 6;
  List<String> tempImages = [
    "assets/images/chicken.jpg",
    "assets/images/dessert.jpg",
    "assets/images/lamb.jpg",
    "assets/images/pork.jpg",
    "assets/images/seafood.jpg",
    "assets/images/vegan.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: false,
          elevation: 5,
          expandedHeight: 200.0,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              height: size.height * 0.04,
              color: Colors.black.withOpacity(0.65),
              width: size.width * 0.5,
              alignment: Alignment.center,
              child: Text(
                "My Recipes",
                textAlign: TextAlign.start,
                style: GoogleFonts.lobster(
                  fontSize: FontSizes.bigMediumFont,
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
            background: Image.asset("assets/images/myrecipe1.jpg", fit: BoxFit.cover),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                        image: AssetImage(
                          tempImages[index],
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
                                "Menu for dinner",
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
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite),
                                      color: Colors.redAccent.shade700,
                                      iconSize: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                            width: double.maxFinite,
                            height: size.height * 0.04,
                            color: Colors.black.withOpacity(0.65),
                            padding: EdgeInsets.only(left: Gaps.smallGap),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Chicken Bread",
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
                          width: double.maxFinite,
                          height: size.height * 0.04,
                          padding: EdgeInsets.only(left: Gaps.smallGap),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.65),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "30 min",
                                style: GoogleFonts.openSans(
                                  fontSize: FontSizes.smallFont,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              horizontalGap(Gaps.smallGap),
                              Container(
                                child: Icon(
                                  FontAwesomeIcons.fireBurner,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Easy lvl",
                                style: GoogleFonts.openSans(
                                  fontSize: FontSizes.smallFont,
                                  shadows: [
                                    const Shadow(
                                      offset:
                                          Offset(3.0, 3.0), // Shadow position
                                      blurRadius: 3.0, // Shadow blur effect
                                      color: Colors.black, // Shadow color
                                    ),
                                  ],
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: 6,
          ),
        ),
        // SliverToBoxAdapter(
        //   child: SizedBox(
        //     child: ListView.builder(
        //       physics: NeverScrollableScrollPhysics(),
        //       itemBuilder: (_, index) {
        //         return
        //       },
        //       itemCount: extraLen,
        //     ),
        //   ),
        // )
      ],
    );
  }
}

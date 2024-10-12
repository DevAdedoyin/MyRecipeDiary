import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(width: double.maxFinite,
      child: Onboarding(
        swipeableBody: [], //[List<Widget>] - List of swipeable widgets
        startIndex: 0, //[int] - the starting index of the swipeable widgets
        onPageChanges:(netDragDistance,pagesLength,currentIndex, slideDirection){
          //1) [pagesLength] The drage distance from swipping
          //2) [pagesLength] The length of the swipeable widgets
          //3) [currentIndex] The currect index
          //4) [slideDirection] The slide direction
        },
        buildHeader:(context, netDragDistance, pagesLength, currentIndex, setIndex, slideDirection){
          //Use this to build a header in your onboarding that will display at all times. (Used to build routing buttons, indicators, etc)
          //This is same as onPageChanges but with [setIndex] added to allow u to change the index from this header
          return const Placeholder();
        },
        buildFooter:(context, netDragDistance, pagesLength, currentIndex, setIndex, slideDirection){
          //Use this to build a footer in your onboarding that will display at all times. (Used to build routing buttons, indicators, etc)
          return const Placeholder();
        },
        animationInMilliseconds: 500, //[int] - the speed of animations in ms
      )
      ),
    );
  }
}

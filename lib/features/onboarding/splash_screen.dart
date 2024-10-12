import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/themes/text_theme.dart';
import '../../../common/gaps.dart';
import '../../routing/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _visible = false;

  // final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _visible = true;
      });
      Future.delayed(
        const Duration(milliseconds: 5000),
        () {
          // if (FirebaseAuth.instance.currentUser == null) {
          // context.go(AppRoutes.onboarding);
          // } else {
          //   context.go(AppRoutes.userLocatorPage);
          // }
        },
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
              height: 112,
              width: 112,
            ),
            verticalGap(10),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 4000),
              child: Text(
                "My Recipe Diary",
                style: AppTextTheme.splashScreenTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

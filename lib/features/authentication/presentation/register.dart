import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myrecipediary/constants/gaps.dart';
import 'package:myrecipediary/features/authentication/presentation/login_form.dart';
import 'package:myrecipediary/features/authentication/presentation/register_form.dart';
import 'package:myrecipediary/themes/text_theme.dart';

import '../../../routing/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: EdgeInsets.all(Gaps.mediumGap),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    child: Image.asset("assets/images/register.jpg"),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Create Account",
                    style: textTheme.headlineLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    // color: Colors.red,
                    child: const RegisterForm(),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(text: "Already Registered & Verified? ",
                                style: textTheme.bodySmall),
                            TextSpan(text: "Login",
                                style: AppTextTheme.metaTextTheme,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => context.push(AppRoutes.login))
                          ]),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

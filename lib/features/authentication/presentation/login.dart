import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myrecipediary/constants/gaps.dart';
import 'package:myrecipediary/features/authentication/presentation/login_form.dart';
import 'package:myrecipediary/routing/app_routes.dart';
import 'package:myrecipediary/themes/text_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: EdgeInsets.all(Gaps.mediumGap),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    child: Image.asset("assets/images/login.jpg"),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Login",
                    style: textTheme.headlineLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    // color: Colors.red,
                    child: const LoginForm(),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "New to My Recipe Diary? ",
                                style: textTheme.bodySmall),
                            TextSpan(
                                text: "Register",
                                style: AppTextTheme.metaTextTheme,
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => context.push(AppRoutes.register))
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

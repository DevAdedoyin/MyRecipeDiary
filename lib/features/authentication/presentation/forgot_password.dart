import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/constants/gaps.dart';
import 'package:myrecipediary/features/authentication/presentation/login_form.dart';
import 'package:myrecipediary/themes/text_theme.dart';

import '../../../common/elevated_button.dart';
import '../../../common/text_form_field.dart';
import '../../../routing/app_routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

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
            child: Form(
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      child: Image.asset("assets/images/fpassword.jpg"),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    child: Text(
                      "Forgot Password",
                      style: textTheme.headlineLarge,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  verticalGap(Gaps.mediumGap),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.red,
                          child: TextFormField_.textFormField(
                              prefixIcon: const Icon(FontAwesomeIcons.envelope),
                              controller: _emailController,
                              textInputType: TextInputType.emailAddress,
                              hint: "Email address"),
                        ),
                        verticalGap(Gaps.mediumGap),
                        elevatedButton(
                            text: "Request password reset",
                            onPressed: () {},
                            width: size.width),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Remembered your password? ",
                              style: textTheme.bodySmall),
                          TextSpan(
                              text: "Login",
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
      ),
    );
  }
}

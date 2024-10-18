import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:myrecipediary/common/dividers.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/text_form_field.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/routing/app_routes.dart';
import 'package:myrecipediary/themes/text_theme.dart';
import 'package:myrecipediary/utils/validators/email_validators.dart';

import '../../../common/elevated_button.dart';
import '../../../constants/gaps.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          verticalGap(Gaps.bigMediumGap),
          TextFormField_.textFormField(
              prefixIcon: const Icon(FontAwesomeIcons.envelope),
              controller: _emailController,
              textInputType: TextInputType.emailAddress,
              hint: "Email address",
              validator: (email) => EmailInputValidator.validateEmail(email: email)),
          verticalGap(Gaps.bigMediumGap),
          TextFormField_.textFormField(
            controller: _passwordController,
            prefixIcon: const Icon(FontAwesomeIcons.lock),
            suffixIcon: const Icon(FontAwesomeIcons.eye),
            textInputType: TextInputType.visiblePassword,
            hint: "Password",
          ),
          verticalGap(Gaps.bigMediumGap),
          GestureDetector(
            onTap: () => context.push(AppRoutes.forgotPassword),
            child: SizedBox(
              width: size.width,
              child: Text(
                "Forgot Password?",
                style: AppTextTheme.metaTextTheme,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          verticalGap(Gaps.bigMediumGap),
          elevatedButton(
              text: "Login",
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  // ref.read(isAuthLoading.notifier).state = true;
                  // await FireAuth.signInUsingEmailPassword(
                  //   context: context,
                  //   email: _emailController.text,
                  //   password: _passwordController.text,
                  // );
                  // ref.read(isAuthLoading.notifier).state =
                  // false;
                }
              },
              width: size.width),
          verticalGap(Gaps.bigMediumGap),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: divider()),
              Text(
                "OR",
                style: TextStyle(color: AppColors.midGreyColor),
              ),
              Expanded(child: divider()),
            ],
          ),
          verticalGap(Gaps.bigMediumGap),
          googleElevatedButton(
              onPressed: () {}, text: "Login with Google", width: size.width),
        ],
      ),
    );
  }
}

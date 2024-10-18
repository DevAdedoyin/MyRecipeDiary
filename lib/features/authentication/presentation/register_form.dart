import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myrecipediary/common/dividers.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/text_form_field.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/themes/text_theme.dart';
import 'package:myrecipediary/utils/validators/password_validators.dart';

import '../../../common/elevated_button.dart';
import '../../../constants/gaps.dart';
import '../../../utils/validators/email_validators.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
              validator: (email) =>
                  EmailInputValidator.validateEmail(email: email)),
          verticalGap(Gaps.mediumGap),
          TextFormField_.textFormField(
              controller: _passwordController,
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              suffixIcon: const Icon(FontAwesomeIcons.eye),
              textInputType: TextInputType.visiblePassword,
              hint: "Password",
              validator: (password) =>
                  PasswordValidators.validatePassword(password: password)),
          verticalGap(Gaps.mediumGap),
          TextFormField_.textFormField(
              controller: _confirmPasswordController,
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              suffixIcon: const Icon(FontAwesomeIcons.eye),
              textInputType: TextInputType.visiblePassword,
              hint: "Confirm password",
              validator: (confirmPassword) =>
                  PasswordValidators.validateConfirmPassword(
                      password: _passwordController.text,
                      confirmPassword: confirmPassword)),
          verticalGap(Gaps.mediumGap),
          elevatedButton(
              text: "Register",
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
          verticalGap(Gaps.mediumGap),
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
          verticalGap(Gaps.mediumGap),
          googleElevatedButton(
              onPressed: () {},
              text: "Register with Google",
              width: size.width),
        ],
      ),
    );
  }
}

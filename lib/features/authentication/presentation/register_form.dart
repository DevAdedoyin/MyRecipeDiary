import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myrecipediary/common/dividers.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/text_form_field.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/themes/text_theme.dart';

import '../../../common/elevated_button.dart';
import '../../../constants/gaps.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
              hint: "Email address"),
          verticalGap(Gaps.bigMediumGap),
          TextFormField_.textFormField(
              controller: _passwordController,
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              suffixIcon: const Icon(FontAwesomeIcons.eye),
              textInputType: TextInputType.visiblePassword,
              hint: "Password"),
          verticalGap(Gaps.bigMediumGap),
          TextFormField_.textFormField(
              controller: _passwordController,
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              suffixIcon: const Icon(FontAwesomeIcons.eye),
              textInputType: TextInputType.visiblePassword,
              hint: "Confirm password"),
          verticalGap(Gaps.bigMediumGap),
          elevatedButton(text: "Register", onPressed: () {}, width: size.width),
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
              onPressed: () {}, text: "Register with Google", width: size.width),
        ],
      ),
    );
  }
}

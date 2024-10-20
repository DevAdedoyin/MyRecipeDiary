import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myrecipediary/common/dividers.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/loading_button.dart';
import 'package:myrecipediary/common/text_form_field.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/features/authentication/data/auth_source/register.dart';
import 'package:myrecipediary/themes/text_theme.dart';
import 'package:myrecipediary/utils/validators/password_validators.dart';

import '../../../common/elevated_button.dart';
import '../../../common/progress_indicator.dart';
import '../../../constants/gaps.dart';
import '../../../utils/validators/email_validators.dart';
import '../data/repositories/auth_loading_repo.dart';
import '../repository/password_visibility_repo.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    final isPasswordVisible = ref.watch(isRegisterPasswordVisible);
    final isRegistering_ = ref.watch(isRegistering);
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
              isObscured: false,
              validator: (email) =>
                  EmailInputValidator.validateEmail(email: email),
              textInputAction: TextInputAction.next),
          verticalGap(Gaps.mediumGap),
          TextFormField_.textFormField(
              controller: _passwordController,
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              suffixIcon: GestureDetector(
                  onTap: () {
                    ref.read(isRegisterPasswordVisible.notifier).state =
                        ref.read(isRegisterPasswordVisible.notifier).state
                            ? false
                            : true;
                  },
                  child: Icon(isPasswordVisible
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash)),
              textInputType: TextInputType.visiblePassword,
              isObscured: isPasswordVisible,
              hint: "Password",
              validator: (password) =>
                  PasswordValidators.validatePassword(password: password),
              textInputAction: TextInputAction.next),
          verticalGap(Gaps.mediumGap),
          TextFormField_.textFormField(
              controller: _confirmPasswordController,
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              suffixIcon: GestureDetector(
                  onTap: () {
                    ref.read(isRegisterPasswordVisible.notifier).state =
                        ref.read(isRegisterPasswordVisible.notifier).state
                            ? false
                            : true;
                  },
                  child: Icon(isPasswordVisible
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash)),
              textInputType: TextInputType.visiblePassword,
              hint: "Confirm password",
              isObscured: isPasswordVisible,
              validator: (confirmPassword) =>
                  PasswordValidators.validateConfirmPassword(
                      password: _passwordController.text,
                      confirmPassword: confirmPassword),
              textInputAction: TextInputAction.done),
          verticalGap(Gaps.mediumGap),
          isRegistering_ == true
              ? loadingButton(
                  onPressed: () {},
                  text: "Registration in progress",
                  width: size.width)
              : elevatedButton(
                  text: "Register",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ref.read(isRegistering.notifier).state = true;
                      await RegisterAuth.registerUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      ref.read(isRegistering.notifier).state = false;
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

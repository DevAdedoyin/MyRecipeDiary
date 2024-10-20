import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:myrecipediary/common/dividers.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/common/text_form_field.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/features/authentication/data/auth_source/login.dart';
import 'package:myrecipediary/features/authentication/repository/password_visibility_repo.dart';
import 'package:myrecipediary/routing/app_routes.dart';
import 'package:myrecipediary/themes/text_theme.dart';
import 'package:myrecipediary/utils/validators/email_validators.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import '../../../common/elevated_button.dart';
import '../../../common/loading_button.dart';
import '../../../constants/gaps.dart';
import '../data/repositories/auth_loading_repo.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    final isPasswordVisible = ref.watch(isLoginPasswordVisible);
    final isLoginIn_ = ref.watch(isLoginIn);
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
                  EmailInputValidator.validateEmail(email: email),
              isObscured: false,
              textInputAction: TextInputAction.next),
          verticalGap(Gaps.bigMediumGap),
          TextFormField_.textFormField(
              controller: _passwordController,
              prefixIcon: const Icon(FontAwesomeIcons.lock),
              suffixIcon: GestureDetector(
                  onTap: () {
                    ref.read(isLoginPasswordVisible.notifier).state =
                        ref.read(isLoginPasswordVisible.notifier).state
                            ? false
                            : true;
                  },
                  child: Icon(isPasswordVisible
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash)),
              textInputType: TextInputType.visiblePassword,
              hint: "Password",
              isObscured: isPasswordVisible,
              textInputAction: TextInputAction.done),
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
          isLoginIn_
              ? loadingButton(
                  onPressed: () {},
                  text: "Login in progress",
                  width: size.width)
              : elevatedButton(
                  text: "Login",
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      ref.read(isLoginIn.notifier).state = true;
                      LoginAuth.loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      ref.read(isRegistering.notifier).state = false;
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

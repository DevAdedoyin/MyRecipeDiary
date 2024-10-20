import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:myrecipediary/common/gaps.dart';
import 'package:myrecipediary/constants/gaps.dart';
import 'package:myrecipediary/features/authentication/data/auth_source/forgot_password.dart';
import 'package:myrecipediary/features/authentication/presentation/login_form.dart';
import 'package:myrecipediary/themes/text_theme.dart';
import 'package:myrecipediary/utils/validators/email_validators.dart';

import '../../../common/elevated_button.dart';
import '../../../common/loading_button.dart';
import '../../../common/text_form_field.dart';
import '../../../routing/app_routes.dart';
import '../data/repositories/auth_loading_repo.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    final isPasswordUpdateRequest_ = ref.watch(isPasswordUpdateRequest);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: size.height,
            child: Padding(
              padding: EdgeInsets.all(Gaps.mediumGap),
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
                              hint: "Email address",
                              isObscured: false,
                              validator: (email) =>
                                  EmailInputValidator.validateEmail(
                                      email: email)),
                        ),
                        verticalGap(Gaps.mediumGap),
                        isPasswordUpdateRequest_
                            ? loadingButton(
                                onPressed: () {},
                                text: "Requesting password reset",
                                width: size.width)
                            : elevatedButton(
                                text: "Request password reset",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ref
                                        .read(isPasswordUpdateRequest.notifier)
                                        .state = true;
                                    await ForgotPassword.forgotPassword(
                                      email: _emailController.text,
                                    );
                                    ref
                                        .read(isPasswordUpdateRequest.notifier)
                                        .state = false;
                                  }
                                },
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

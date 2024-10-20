import 'package:firebase_auth/firebase_auth.dart';
import 'package:myrecipediary/common/app_alert_dialog.dart';
import 'package:myrecipediary/constants/auth_text_constants.dart';
import 'package:get/get.dart';

import '../../../../routing/app_routes.dart';

class ForgotPassword {
  static Future<bool?> forgotPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      AppAlertDialog.successfulAlert(
          title: "PASSWORD RESET REQUESTED",
          message: AuthTextConstants.forgotPasswordMessage);
      Future.delayed(const Duration(seconds: 2), () => Get.to(AppRoutes.login));
    } on FirebaseAuthException catch (e) {
      AppAlertDialog.failedAlert(
          title: "PASSWORD RESET REQUEST FAILED",
          message: e.message!);
    } catch (e) {
      AppAlertDialog.failedAlert(
          title: "PASSWORD RESET REQUEST FAILED",
          message: AuthTextConstants.forgotPasswordFailedMessage);
    }
    return false;
  }
}

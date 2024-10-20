import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myrecipediary/common/app_alert_dialog.dart';
import 'package:myrecipediary/constants/auth_text_constants.dart';

import '../../../../routing/app_routes.dart';

class UpdatePassword {
  static Future<bool?> updatePasword({required String newPassword}) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await user?.updatePassword(newPassword);

      AppAlertDialog.successfulAlert(
          title: "PASSWORD UPDATED SUCCESSFULLY",
          message: AuthTextConstants.updatePasswordMessage);

      Future.delayed(const Duration(seconds: 4), () => Get.to(AppRoutes.login));
    } on FirebaseAuthException catch (e) {
      AppAlertDialog.failedAlert(
          title: "PASSWORD UPDATE FAILED",
          message: e.message!);
    } catch (e) {
      AppAlertDialog.failedAlert(
          title: "PASSWORD UPDATE FAILED",
          message: AuthTextConstants.updatePasswordFailedMessage);
    }
    return false;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myrecipediary/common/app_alert_dialog.dart';
import 'package:myrecipediary/constants/auth_text_constants.dart';

import '../../../../routing/app_routes.dart';

class DeleteUserAccount {
  static Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();

      AppAlertDialog.successfulAlert(
          title: "ACCOUNT DELETED SUCCESSFULLY",
          message: AuthTextConstants.deleteUserAccount);

      Future.delayed(
          const Duration(seconds: 4), () => Get.to(AppRoutes.register));
    } on FirebaseAuthException catch (e) {
      AppAlertDialog.failedAlert(
          title: "ACCOUNT DELETION FAILED", message: e.message!);
    } catch (e) {
      AppAlertDialog.failedAlert(
          title: "PASSWORD RESET REQUEST FAILED",
          message: AuthTextConstants.deleteUserAccountFailed);

      // Handle general exception
    }
  }
}

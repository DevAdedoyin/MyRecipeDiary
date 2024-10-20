import 'package:firebase_auth/firebase_auth.dart';
import 'package:myrecipediary/common/app_alert_dialog.dart';
import 'package:myrecipediary/constants/auth_text_constants.dart';
import 'package:get/get.dart';

import '../../../../routing/app_routes.dart';
import '../../../../routing/go_router_provider.dart';

class RegisterAuth {
  static Future<User?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user?.sendEmailVerification();
      await user?.reload();
      user = auth.currentUser;

      AppAlertDialog.successfulAlert(
          title: "REGISTRATION SUCCESSFUL",
          message: AuthTextConstants.successfulRegistrationMessage);

      Future.delayed(const Duration(seconds: 4), () => goRouter.go(AppRoutes.login));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppAlertDialog.failedAlert(
            title: "WEAK PASSWORD", message: AuthTextConstants.weakPasswordMessage);
      } else if (e.code == 'email-already-in-use') {
        AppAlertDialog.infoAlert(
            title: "EMAIL ALREADY REGISTERED",
            message: AuthTextConstants.emailAlreadyRegistered);
      }
    } catch (e) {
      // print(e);
    }
    return user;
  }
}

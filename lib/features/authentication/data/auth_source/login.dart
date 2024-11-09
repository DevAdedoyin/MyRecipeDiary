import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myrecipediary/common/app_alert_dialog.dart';
import 'package:myrecipediary/constants/auth_text_constants.dart';
import 'package:myrecipediary/routing/go_router_provider.dart';

import '../../../../routing/app_routes.dart';

class LoginAuth {
  static Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      if (!user!.emailVerified) {
        AppAlertDialog.infoAlert(
            title: "EMAIL NOT VERIFIED",
            message: AuthTextConstants.emailNotVerifiedMessage);
        return user;
      }
      // Future.delayed(Duration(milliseconds: ))
      AppAlertDialog.successfulAlert(
          title: "LOGIN SUCCESSFUL",
          message: AuthTextConstants.successfulLoginMessage);
      Future.delayed(
          const Duration(seconds: 4), () => goRouter.push(AppRoutes.dashboard));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppAlertDialog.infoAlert(
            title: "USER NOT FOUND",
            message: AuthTextConstants.userNotFoundMessage);
      } else if (e.code == 'wrong-password') {
        AppAlertDialog.failedAlert(
            title: "WRONG PASSWORD",
            message: AuthTextConstants.incorrectPasswordMessage);
      } else {
        AppAlertDialog.failedAlert(
            title: "INCORRECT LOGIN DETAILS",
            message: AuthTextConstants.incorrectLoginDetails);
      }
    } catch (e) {
      // print(e);
    }

    return user;
  }
}

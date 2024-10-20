import 'package:firebase_auth/firebase_auth.dart';

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

//       final message = """
// Hi ${user!.displayName},
//
// Your registration is almost complete.
//
// Please, kindly check your email for a verification link.
//
// Thank you
// """;
//       const messageHeader = "REGISTRATION SUCCESSFUL";
//       successAuthAlertWidget(context!, message, messageHeader);
//       Future.delayed(
//           const Duration(seconds: 4), () => context.go(AppRoutes.login));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // failedAuthAlertWidget(context!, e.message!, "REGISTRATION FAILED");
      } else if (e.code == 'email-already-in-use') {
        // failedAuthAlertWidget(context!, e.message!, "REGISTRATION FAILED");
      }
    } catch (e) {
      // print(e);
    }
    return user;
  }

}
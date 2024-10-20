class AuthTextConstants {
  // REGISTRATION: SUCCESSFUL REGISTRATION MESSAGE
  static String successfulRegistrationMessage = """
Thank you for signing up for My Recipe Diary!

To complete your registration, please check your email for a verification link. Once verified, you'll have full access to your Recipe Diary account.

If you don't see the email, be sure to check your spam or junk folder.

Happy cooking!
""";

//  REGISTRATION: EMAIL ALREADY REGISTERED
  static String emailAlreadyRegistered = """
It looks like the email address you entered is already associated with an existing My Recipe Diary account.

If you've forgotten your password, you can use the forgot password page to reset your password. I

f you believe this is an error, please contact our support team.

Thank you.
""";

//  REGISTRATION: WEAK PASSWORD MESSAGE
  static String weakPasswordMessage = """
Oops! Your password doesn't meet our security requirements.

Please ensure your password is at least 8 characters long and includes a mix of uppercase and lowercase letters, numbers, and special characters (e.g., @, #, \$).

This helps keep your Recipe Diary account secure.
""";

//   LOGIN: EMAIL NOT VERIFIED
  static String emailNotVerifiedMessage = """
It looks like your email address hasn't been verified yet.

Please check your inbox for a verification link we sent when you registered. 

You'll need to verify your email to access your My Recipe Diary account.
""";

  // LOGIN: SUCCESSFUL LOGIN MESSAGE
  static String successfulLoginMessage = """
Welcome back to Recipe Diary! 

You're now logged in and ready to explore and manage your recipes.

Happy cooking!
  """;

  // LOGIN: USER NOT FOUND MESSAGE
  static String userNotFoundMessage = """
We couldn't find an account with the email or username you entered.

Please check your details and try again, or sign up if you don't have an account yet.
  """;

  // LOGIN: INCORRECT PASSWORD
  static String incorrectPasswordMessage = """
Oops! The password you entered is incorrect.

Please double check and try again. 

If you've forgotten your password, you can use the forgot password feature.
  """;

  // FORGOT PASSWORD: SUCCESSFUL
  static String forgotPasswordMessage = """
We've received your request to reset your password.

Please check your email for a reset link. Follow the instructions in the email to create a new password. If you don’t see it, check your spam or junk folder.
  """;

  // FORGOT PASSWORD: FAILED
  static String forgotPasswordFailedMessage = """
We encountered an issue while processing your request to reset your password.

Please ensure that the email address you entered is associated with a Recipe Diary account and try again. If the problem persists, feel free to contact our support team for assistance.
  """;

  // UPDATE PASSWORD: SUCCESSFUL
  static String updatePasswordMessage = """
Your password has been updated. You can now use your new password to log in to your Recipe Diary account.

Happy cooking!
  """;

  // UPDATE PASSWORD: FAILED
  static String updatePasswordFailedMessage = """
We encountered an issue while updating your password.

Please ensure that your new password meets our security requirements and try again. If the problem persists, contact our support team for assistance.
  """;

  // DELETE USER ACCOUNT: SUCCESSFUL
  static String deleteUserAccount = """
Your My Recipe Diary account has been deleted. We're sorry to see you go!

If you change your mind, you can always sign up again.
  """;

  // DELETE USER ACCOUNT: FAILED
  static String deleteUserAccountFailed = """
We encountered an issue while trying to delete your account.

Please try again later. If the problem persists, please contact our support team for assistance.
  """;
}

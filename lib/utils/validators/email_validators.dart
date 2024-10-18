

import 'package:email_validator/email_validator.dart';

class EmailInputValidator {
  static String? validateEmail({String? email}) {
    if (!EmailValidator.validate(email!)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}


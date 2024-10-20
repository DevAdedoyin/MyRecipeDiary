class PasswordValidators {
  static String? validatePassword({required String? password}) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!regex.hasMatch(password)) {
      return 'must have atleast 1 uppercase, 1 digit & 1 special character';
    }
    return null;
  }

  static String? validateLoginPassword({required String? password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    }
    return null;
  }

  static String? validateConfirmPassword(
      {required String? password, required String? confirmPassword}) {
    if (password == null) {
      return null;
    }
    if (password != confirmPassword) {
      return "Password does not match";
    } else if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }
    return null;
  }
}



import 'package:email_validator/email_validator.dart';

class MealInputValidators {
  static String? validateMealInput({String? text}) {
    if (text!.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }
}


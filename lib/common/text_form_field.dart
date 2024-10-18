import 'package:flutter/material.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/constants/gaps.dart';

class TextFormField_ {
  static textFormField({
    required Widget prefixIcon,
    suffixIcon,
    controller,
    textInputType,
    hint,
    validator,
  }) =>
      TextFormField(
        maxLines: 1,
        controller: controller,
        keyboardType: textInputType,
        validator: validator,
        decoration: InputDecoration(
              hintText: hint,
            contentPadding:  EdgeInsets.symmetric(vertical: Gaps.smallGap, horizontal: Gaps.bigMediumGap),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(color: AppColors.secondaryColor, style: BorderStyle.solid)),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon),
      );
}

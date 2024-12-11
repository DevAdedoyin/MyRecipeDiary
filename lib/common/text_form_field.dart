import 'package:flutter/material.dart';
import 'package:myrecipediary/constants/colors.dart';
import 'package:myrecipediary/constants/gaps.dart';

class TextFormField_ {
  static textFormField(
          { prefixIcon,
          suffixIcon,
          controller,
          textInputType,
          hint,
          validator,
          isObscured,
          textInputAction,
            maxLines = 1,
          filledColor}) =>
      TextFormField(
        maxLines: maxLines,
        controller: controller,
        keyboardType: textInputType,
        validator: validator,
        obscureText: isObscured,
        textInputAction: textInputAction,

        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: Gaps.smallGap, horizontal: Gaps.bigMediumGap),
            filled: true,
            fillColor: filledColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                      color: AppColors.black, style: BorderStyle.solid)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                    color: AppColors.black, style: BorderStyle.solid)),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon),
      );
}

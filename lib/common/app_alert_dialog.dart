import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrecipediary/constants/colors.dart';

class AppAlertDialog {
  static successfulAlert({required String title, required String message}) {
    Get.snackbar(title, message,
        backgroundColor: AppColors.successGreen,
        duration: const Duration(seconds: 4),
        colorText: Colors.white);
  }

  static infoAlert({required String title, required String message}) {
    Get.snackbar(title, message,
        backgroundColor: AppColors.infoBlue,
        duration: const Duration(seconds: 4),
        colorText: Colors.white);
  }

  static failedAlert({required String title, required String message}) {
    Get.snackbar(title, message,
        backgroundColor: AppColors.failureRed,
        duration: const Duration(seconds: 4),
        colorText: Colors.white);
  }
}

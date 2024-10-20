
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppAlertDialog {
  static successfulAlert({required String title,required String message}){
    Get.snackbar(title, message);
  }

  static infoAlert({required String title,required String message}){
    Get.snackbar(title, message);
  }

  static failedAlert({required String title,required String message}){
    Get.snackbar(title, message);
  }
}
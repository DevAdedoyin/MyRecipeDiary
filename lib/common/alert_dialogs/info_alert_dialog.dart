import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../constants/colors.dart';
import '../gaps.dart';

void infoAuthAlertWidget(
    BuildContext context, String message, String messageHeader,
    {Function? onTap}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  Alert(
    context: context,
    type: AlertType.info,
    buttons: [],
    content: SizedBox(
      child: Column(
        children: [
          verticalGap(7),
          Text(
            messageHeader,
            // textAlign: TextAlign.center,
            style: textTheme.headlineMedium,
          ),
          verticalGap(12),
          Text(
            message,
            // textAlign: TextAlign.center,
            style: textTheme.bodySmall,
          ),
          verticalGap(10),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () => onTap!(),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2)),
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.secondaryColor),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: const Text("Continue",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white)),
            ),
          )
        ],
      ),
    ),
    style: const AlertStyle(
        descStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  ).show();
}

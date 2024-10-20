import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppProgressIndicator {
  static circularProgressIndicator(
          {required double width, required double height}) =>
      SizedBox(
        width: width,
        height: height,
        child: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );
}

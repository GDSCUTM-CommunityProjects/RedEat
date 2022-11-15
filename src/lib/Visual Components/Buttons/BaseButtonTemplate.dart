// A base class for buttons in the app

import 'package:flutter/material.dart';

class BaseButtonTemplate extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonTitle;
  Color color;
  Color borderColor;
  double borderWeight;
  double borderRadius;
  double height;
  double fontSize;
  double paddingValH;
  double paddingValV;
  FontWeight boldness;
  BaseButtonTemplate({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
    this.borderColor = Colors.transparent,
    this.borderWeight = 0,
    this.color = Colors.red,
    this.borderRadius = 12.0,
    this.height = 50.0,
    this.paddingValH = 30.0,
    this.paddingValV = 30.0,
    this.boldness = FontWeight.normal,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size.fromHeight(height),
          side: BorderSide(color: borderColor, width: borderWeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
      onPressed: onPressed,
      child: Text(
        buttonTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: boldness,
        ),
      ),
    );
  }
}

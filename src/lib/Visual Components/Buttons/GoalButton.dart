import 'package:flutter/material.dart';
import 'package:src/Visual%20Components/Buttons/BaseButtonTemplate.dart';

class GoalButton extends BaseButtonTemplate {
  final GestureTapCallback onPressed;
  final String buttonTitle;
  final double fontsize;
  GoalButton({required this.onPressed, required this.buttonTitle, this.fontsize=15})
      : super(
            onPressed: onPressed,
            buttonTitle: buttonTitle,
            borderRadius: 8,
            height: 50,
            fontSize: fontsize,
            paddingValH: 10,
            paddingValV: 20,
            color: Colors.redAccent);
}

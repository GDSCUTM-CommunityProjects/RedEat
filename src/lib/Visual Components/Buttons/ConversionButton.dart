import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:src/Visual%20Components/Buttons/BaseButtonTemplate.dart';

class ConversionButton extends BaseButtonTemplate{
  final GestureTapCallback onPressed;
  final String buttonTitle;
  ConversionButton({required this.onPressed, required this.buttonTitle})
      : super(
            onPressed: onPressed,
            buttonTitle: buttonTitle,
            borderRadius: 12,
            height: 50,
            fontSize: 24,
            paddingValH: 7,
            paddingValV: 25,
            color: Colors.redAccent,
            );

}
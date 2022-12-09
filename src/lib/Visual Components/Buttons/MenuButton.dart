import 'package:flutter/material.dart';
import 'package:src/Visual%20Components/Buttons/BaseButtonTemplate.dart';

class MenuButton extends BaseButtonTemplate {
  // Initializer. Needs color, onPressed event and button text
  final GestureTapCallback onPressed;
  final String buttonTitle;
  MenuButton({required this.onPressed, required this.buttonTitle})
      : super(
            onPressed: onPressed,
            buttonTitle: buttonTitle,
            color: Color.fromARGB(255, 219, 63, 63),
            borderRadius: 15,
            height: 100,
            boldness: FontWeight.bold);

}
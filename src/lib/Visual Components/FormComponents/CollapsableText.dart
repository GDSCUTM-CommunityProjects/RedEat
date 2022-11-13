import 'package:flutter/material.dart';

class CollapsableText extends StatelessWidget {
  final String text;
  final bool isTitle;
  final bool onExpanded;

  CollapsableText(
      {super.key,
      required this.text,
      this.isTitle = false,
      this.onExpanded = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (isTitle) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
    } else if (onExpanded) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          text,
        ),
      );
    } else{
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          text,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
  }
}

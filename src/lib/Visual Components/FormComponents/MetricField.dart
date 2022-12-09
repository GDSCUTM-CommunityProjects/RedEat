import 'package:flutter/material.dart';

class MetricField extends StatelessWidget {
  final TextEditingController controller;
  Color color;
  String text;
  void Function(String) onChange;
  MetricField(
      {super.key,
      required this.controller,
      required this.color,
      required this.text,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            onChanged: onChange,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
            ),
            controller: controller,
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    );
  }
}

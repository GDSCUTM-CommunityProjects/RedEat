import 'package:flutter/material.dart';

class CollapsableSection extends StatelessWidget {
  final Widget? sectionChild;

  CollapsableSection({super.key, required this.sectionChild});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: sectionChild,
        ),
      ),
    );
  }
}

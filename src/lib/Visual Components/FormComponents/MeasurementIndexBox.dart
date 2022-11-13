import 'package:flutter/material.dart';

class MeasurementIndexBox extends StatelessWidget {
  String indexValue;
  String indexName;
  MeasurementIndexBox(
      {super.key, required this.indexName, required this.indexValue});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text("Your $indexName is"),
            ),
            Text(
              indexValue,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ])),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:src/Visual%20Components/FormComponents/MetricField.dart';

import '../Visual Components/Buttons/ConversionButton.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  int weight = 180;
  int height = 71;
  double BMI = 0;
  final weightTextController = TextEditingController();
  final heightTextControllerUnit1 = TextEditingController();
  final heightTextControllerUnit2 = TextEditingController();
  int heightCoversion = 12;
  bool isLbs = true;
  bool toSave = false;

  @override
  void initState() {
    // Currently the stats are set to my weight and height
    super.initState();
    weight = 180; // Weight measurement, stored in lbs or kg
    height = 71; // Height measurement, stored in m or ft

    // Set the initial value of the weight text field to the 'weight' attribute
    weightTextController.text = weight.toString();

    // The height has two text fields, one to record feet/meters, the other to
    // records additional inches/centimeters
    heightTextControllerUnit1.text = (heightCoversion == 12)
        ? (height ~/ 12).toString()
        : (height ~/ 100).toString();
    heightTextControllerUnit2.text = (heightCoversion == 12)
        ? (height % 12).toString()
        : (height % 100).toString();

    // Keeps track of whether height is kept in meters or feet
    heightCoversion = 12;

    // Keeps track of whether weight is kept in pounds or kilograms
    isLbs = true;
    toSave = false;
    setBMI();
  }

  void setBMI() {
    int BMIweight;
    int BMIheight;
    (isLbs) ? (BMIweight = (weight / 2.20462).round()) : (BMIweight = weight);
    (heightCoversion == 12)
        ? (BMIheight = (height * 2.54).round())
        : (BMIheight = height);
    BMI = BMIweight / pow(BMIheight / 100, 2);
  }

  void changeToOtherUnit(bool changeWeight) {
    // Converts the fields for weight or height to another metric
    /*
    if changeWeight is false, the height will be converted. The attributes 'weight'
    and 'height' store the body metrics in pounds/kilograms and meters/feet. This
    function converts these measurements to a new metric

    ex. 
    heightConversion = 100; // initially, the height is recorded in meters
    height = 180;
    heightCoversion = 12; // The height should now be recorded in inches
    changeToOtherUnit(false); // Change the value of 'height' to inches
    print(height); // sudo code print statement
    >> 71 // 180cm converted to inches
    */
    if (changeWeight) {
      if (!isLbs) {
        setState(() => weight = (weight / 2.20462).round());
        weightTextController.text = weight.toString();
      } else {
        setState(() => weight = (weight * 2.20462).round());
        weightTextController.text = weight.toString();
      }
    } else {
      if (heightCoversion == 100) {
        setState(() => height = (height * 2.54).round());
        heightTextControllerUnit1.text = (height ~/ 100).toString();
        heightTextControllerUnit2.text = (height % 100).toString();
      } else {
        setState(() => height = (height / 2.54).round());
        heightTextControllerUnit1.text = (height ~/ 12).toString();
        heightTextControllerUnit2.text = (height % 12).toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("About Me"),
      ),
      body: Column(children: [
        SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "Q. Garcia",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        const Icon(
          Icons.account_circle,
          color: Colors.grey,
          size: 80,
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ExpandableNotifier(
                child: ExpandablePanel(
                  header: Text("Your body measurements"),
                  collapsed: Text(
                      "Please input your body measurements if you're comfortable with sharing"),
                  expanded:
                      // Change weight text fields
                      Column(children: [
                    Text(
                        "Please input your body measurements if you're comfortable with sharing"),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Row(children: [
                            MetricField(
                              controller: weightTextController,
                              color: (weight > 0) ? Colors.grey : Colors.red,
                              text: (isLbs) ? "lbs" : "kg",
                              onChange: (value) => setState(() {
                                setState(() => toSave = true);
                                (value.length == 0)
                                    ? weight = 0
                                    : weight = int.parse(value);
                                setBMI();
                              }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                (isLbs) ? ("lbs") : ("kg"),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Container(
                            width: 70,
                            child: ConversionButton(
                              buttonTitle: (isLbs) ? "kg" : "lbs",
                              onPressed: () {
                                setState(() => isLbs = !(isLbs));
                                changeToOtherUnit(true);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Change height fields
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      // Larger unit (m or ft)
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Row(children: [
                            MetricField(
                              controller: heightTextControllerUnit1,
                              color: (height > 0) ? Colors.grey : Colors.red,
                              text: (heightCoversion == 12) ? "ft" : "m",
                              onChange: (value) async {
                                setState(() => toSave = true);
                                if (heightTextControllerUnit2.text.isEmpty) {
                                  setState(() {
                                    (value.length == 0)
                                        ? height = 0
                                        : height = int.parse(value);
                                  });
                                  setBMI();
                                } else {
                                  setState(() {
                                    (value.length == 0)
                                        ? height = int.parse(
                                            heightTextControllerUnit2.text)
                                        : height = int.parse(value) *
                                                heightCoversion +
                                            int.parse(
                                                heightTextControllerUnit2.text);
                                  });
                                  setBMI();
                                }
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                (heightCoversion == 12) ? ("ft") : ("m"),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          child: Row(
                            children: [
                              // Smaller unit (cm or in)
                              MetricField(
                                controller: heightTextControllerUnit2,
                                color: (height > 0) ? Colors.grey : Colors.red,
                                text: (heightCoversion == 12) ? "in" : "cm",
                                onChange: (value) async {
                                  setState(() => toSave = true);
                                  if (heightTextControllerUnit1.text.isEmpty) {
                                    setState(() {
                                      (value.length == 0)
                                          ? height = 0
                                          : height = int.parse(value);
                                    });
                                    setBMI();
                                  } else {
                                    setState(() {
                                      (value.length == 0)
                                          ? height = int.parse(
                                                  heightTextControllerUnit1
                                                      .text) *
                                              heightCoversion
                                          : height = int.parse(
                                                      heightTextControllerUnit1
                                                          .text) *
                                                  heightCoversion +
                                              int.parse(value);
                                    });
                                    setBMI();
                                  }
                                },
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  (heightCoversion == 12) ? ("in") : ("cm"),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Container(
                              width: 70,
                              child: ConversionButton(
                                buttonTitle:
                                    (heightCoversion == 12) ? "m" : "ft",
                                onPressed: () {
                                  setState(() => (heightCoversion == 12)
                                      ? heightCoversion = 100
                                      : heightCoversion = 12);
                                  changeToOtherUnit(false);
                                },
                              )),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text("Your BMI is"),
        ),
        Text(
          (BMI).toStringAsFixed(2),
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        ),
        if (toSave)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 25),
            child: Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onPressed: () {
                    setState(() => (heightCoversion == 12)
                        ? heightCoversion = 100
                        : heightCoversion = 12);
                    changeToOtherUnit(false);
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 24),
                  )),
            ),
          ),
      ]),
    );
  }
}

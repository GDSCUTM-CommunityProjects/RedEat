import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  double weight = 180;
  double height = 71;
  final weightTextController = TextEditingController();
  final heightTextControllerUnit1 = TextEditingController();
  final heightTextControllerUnit2 = TextEditingController();
  bool isInches = true;
  bool isLbs = true;
  bool toSave = false;

  @override
  void initState() {
    super.initState();
    weight = 180;
    height = 71;
    weightTextController.text = weight.toString();
    heightTextControllerUnit1.text =
        (isInches) ? (height ~/ 12).toString() : (height ~/ 100).toString();
    heightTextControllerUnit2.text =
        (isInches) ? (height % 12).toString() : (height % 100).toString();
    isInches = true;
    isLbs = true;
    toSave = false;
  }

  void changeToOtherUnit(bool changeWeight) {
    if (changeWeight) {
      if (!isLbs) {
        setState(() => weight = weight / 2.20462);
        weightTextController.text = weight.toString();
      } else {
        setState(() => weight = weight * 2.20462);
        weightTextController.text = weight.toString();
      }
    } else {}
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
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "P. Holder",
            style: TextStyle(fontSize: 40),
          ),
        ),
        const Icon(
          Icons.account_circle,
          color: Colors.grey,
          size: 80,
        ),
        // Change weight text fields
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: (weight > 0) ? Colors.grey : Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) => setState(() {
                      (value.length == 0) ? weight = 0 : weight = double.parse(value);
                    }),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: (isLbs) ? "lbs" : "kg",
                    ),
                    controller: weightTextController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 70,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      setState(() => isLbs = !(isLbs));
                      changeToOtherUnit(true);
                    },
                    child: Text(
                      (isLbs) ? "kg" : "lbs",
                      style: TextStyle(fontSize: 24),
                    )),
              ),
            ),
          ],
        ),
        // Change height fields
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: (height > 0) ? Colors.grey : Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: (isInches) ? "ft" : "m",
                    ),
                    controller: heightTextControllerUnit1,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: (height > 0) ? Colors.grey : Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: (isInches) ? "in" : "cm",
                    ),
                    controller: heightTextControllerUnit2,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

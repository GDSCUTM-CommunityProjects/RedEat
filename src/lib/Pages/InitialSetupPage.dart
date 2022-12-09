import 'package:flutter/material.dart';
import 'package:src/LocalDB/DBSetup/UserInfoDB.dart';
import 'package:src/LocalDB/UserInfo.dart';

class InitialSetupPage extends StatefulWidget {
  const InitialSetupPage({Key? key}) : super(key: key);

  @override
  State<InitialSetupPage> createState() => _InitialSetupPageState();
}

class _InitialSetupPageState extends State<InitialSetupPage> {
  final heightUnits = ['m', 'cm', 'in'];
  final weightUnits = ['kg', 'lb'];
  final goalList = ["Gain Weight", "Maintain Weight", "Lose Weight"];
  double weight_conversion = 2.20462;
  double height_conversion = 39.3700787;
  int goalStatus = 0;
  // final timePeriodList = ["every week", "every month"]
  String selectedHeightUnit = 'm';
  String selectedWeightUnit = 'kg';
  String selectedGoal = "Gain Weight";

  bool validHeight = true;
  bool validWeight = true;

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Text(
              "Let's get started",
              style: TextStyle(
                fontSize: 36,
                // color: Colors.red,
              ),
            ),
            SizedBox(height: 10),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Please enter the following information to complete the setup process",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: (validHeight) ? Colors.grey : Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Height input field
                    Expanded(
                      flex: 7,
                      child: Padding(
                          // padding: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Height input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: (validHeight) ? Colors.grey : Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Height input field
                    Expanded(
                      flex: 4,
                      child: Padding(
                          // padding: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextField(
                            controller: heightController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Height',
                            ),
                          )),
                    ),

                    // Height unit dropdown
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: new DropdownButton(
                            underline: SizedBox(),
                            value: selectedHeightUnit,
                            items: heightUnits
                                .map((e) => (DropdownMenuItem(
                                    child: Text(
                                      e,
                                      textAlign: TextAlign.center,
                                    ),
                                    value: e)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedHeightUnit = value as String;
                                if (selectedHeightUnit == "in") {
                                  height_conversion = 1;
                                } else if (selectedHeightUnit == "m") {
                                  height_conversion = 39.3700787;
                                } else {
                                  height_conversion = 2.54;
                                }
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Weight input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: (validWeight) ? Colors.grey : Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                          // padding: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextField(
                            controller: weightController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Weight',
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton(
                            underline: SizedBox(),
                            value: selectedWeightUnit,
                            items: weightUnits
                                .map((e) => (DropdownMenuItem(
                                    child: Text(
                                      e,
                                      textAlign: TextAlign.center,
                                    ),
                                    value: e)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedWeightUnit = value as String;
                                if (selectedWeightUnit == "kg") {
                                  weight_conversion = 2.20462;
                                } else {
                                  weight_conversion = 1;
                                }
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Select gain / lose weight
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: DropdownButtonFormField(
                  value: selectedGoal,
                  items: goalList
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: "Your Goal",
                    labelStyle: (TextStyle(color: Colors.black)),
                    // prefixIcon: Icon(
                    //   Icons.monitor_weight,
                    //   color: Colors.red,
                    // ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedGoal = value as String;
                      if (selectedGoal == "Gain Weight") {
                        goalStatus = 0;
                      } else if (selectedGoal == "Maintain Weight") {
                        goalStatus = 1;
                      } else {
                        goalStatus = 2;
                      }
                    });
                  },
                )),

            SizedBox(
              height: 20,
            ),

            // Error messages
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!validHeight) // Show invalid height message if username is incorrect
                      Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 14.0,
                          ),
                          Text(
                            ' Invalid Height',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    if (!validWeight) // Show invalid weight message if password is incorrect
                      Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 14.0,
                          ),
                          Text(
                            ' Invalid Weight',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            // Next Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onPressed: () {
                    (verifyInputs(heightController.text))
                        ? setState(() => validHeight = true)
                        : setState(() => validHeight = false);
                    (verifyInputs(weightController.text))
                        ? setState(() => validWeight = true)
                        : setState(() => validWeight = false);
                    UserInfo dbentry = UserInfo(
                        id: 0,
                        name: nameController.text,
                        weight: (double.parse(weightController.text) *
                                weight_conversion)
                            .round(),
                        height: (double.parse(heightController.text) *
                                height_conversion)
                            .round(),
                        goalStatus: goalStatus);
                    UserInfoDB.instance.createUser(dbentry);
                    Navigator.pushNamed(context, '/navbar');
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ))));
  }
}

// Return false if string cannot be converted to a number
bool verifyInputs(String input) {
  return double.tryParse(input) != null;
}

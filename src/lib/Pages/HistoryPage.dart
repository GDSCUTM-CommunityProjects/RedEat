import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:src/LocalDB/DBSetup/UserInfoDB.dart';
import 'package:src/LocalDB/HistoryInfo.dart';
import 'package:src/LocalDB/UserInfo.dart';
import 'package:src/Visual%20Components/Buttons/BaseButtonTemplate.dart';
import 'package:src/Visual%20Components/Buttons/GoalButton.dart';
import 'package:src/Visual%20Components/FormComponents/CollapsableSection.dart';
import 'package:src/Visual%20Components/FormComponents/CollapsableText.dart';
import 'package:src/Visual%20Components/FormComponents/MeasurementIndexBox.dart';
import 'package:src/Visual%20Components/FormComponents/MetricField.dart';

import '../Visual Components/Buttons/ConversionButton.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryInfo>? history;

  @override
  void initState() {
    init();
  }

  void init() async {
    List<HistoryInfo>? cpy = await UserInfoDB.instance.readHistory();
    setState(() {
      this.history = cpy;
    });
    

    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return (history == null)
        ? Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("About Me"),
      ),
      // Page is set to scrollable in case we want to add more sections that
      // overfill the page
      body: ListView.separated(
      itemCount: history!.length,
      itemBuilder: (BuildContext context, index) {
        return SizedBox(width: 200, child: ListTile(
          title: Text(history![index].name),
          subtitle:
              Text(history![index].calories.toString() + " calories"),
          trailing: SizedBox(width: 100, child:BaseButtonTemplate(
            height: 10,
            buttonTitle: "Delete",
            color: Colors.red,
            fontSize: 20,
            onPressed: () {
              int id = history![index].id!;
              UserInfoDB.instance.deleteHistoryEntry(id);
              init();
            },
          ),
        )
        )
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      )
    );
  }
}

import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:src/BackendConnection/SampleProductJson.dart';
import 'package:src/LocalDB/DBSetup/UserInfoDB.dart';
import 'package:src/LocalDB/HistoryInfo.dart';
import 'package:src/Pages/login.dart';

import '../BackendConnection/BackendURL.dart';
import 'package:http/http.dart' as http;

import '../BackendConnection/Product.dart';

class ProductInfo extends StatefulWidget {
  final Map<String, dynamic> responseJson;
  const ProductInfo(this.responseJson);
  // const ProductInfo({Key? key, this.responseJson}) : super(key: key);
  // const ProductInfo({Key? key}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  // Saves the data passed from the parameter into Product object
  late Product product;

  @override
  void initState() {
    // TODO: implement initState
    product = Product.fromJson(widget.responseJson);
    super.initState();
  }

  // Generates list of rows containing the nutrients information and is used to create a table
  List<DataRow> generateRows() {
    List<DataRow> rows = [];
    product.fields.forEach((key, value) {
      if (key.contains("nf_") && key != "nf_ingredient_statement") {
        String k = key.substring(3).replaceAll("_", " ");
        String v = (value == null) ? "none" : value.toString();
        rows.add(DataRow(cells: [
          DataCell(Text(k)),
          DataCell(Text(v)),
          // DataCell(Text(value.toString())),
        ]));
      }
    });
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(product.itemName),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Collapsable container that contains the ingredients
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.red)),
                    child: ExpansionTile(
                      collapsedIconColor: Colors.white,
                      iconColor: Colors.white,
                      title: const Text(
                        "Ingredients",
                        style: TextStyle(color: Colors.white),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                (product.fields['nf_ingredient_statement']) ??
                                    ""),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // Table of nutrient facts
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                              width: 1, color: const Color(0xff343a40)),
                        ),
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => Color(0xff343a40)),
                          headingTextStyle:
                              const TextStyle(color: Colors.white),
                          columns: const [
                            DataColumn(label: Text("Title")),
                            DataColumn(label: Text("Value"))
                          ],
                          rows: generateRows(),
                        ),
                      ),

                      // Add item to diary button
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            onPressed: () async {
                              HistoryInfo newEntry = HistoryInfo(
                                  name: product.itemName,
                                  calories:
                                      product.fields["nf_calories"]);
                              HistoryInfo res = await UserInfoDB.instance.createHistoryEntry(newEntry);
                            },
                            child: const Text(
                              "Add to today's diary",
                              style: TextStyle(fontSize: 24),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}

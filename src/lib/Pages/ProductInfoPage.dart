import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:src/BackendConnection/SampleProductJson.dart';
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
  
  late Product product;

  @override
  void initState() {
    // TODO: implement initState
    product = Product.fromJson(widget.responseJson);
    super.initState();

  }

  List<DataRow> generateRows() {
    List<DataRow> rows = [];
    product.fields.forEach((key, value) { 
      if (key.contains("nf_") && key != "nf_ingredient_statement") {
        String k = key.substring(3).replaceAll("_", " ");
        String v = (value == null) ? "none" : value.toString();
        rows.add(
          DataRow(cells: [
            DataCell(Text(k)),
            DataCell(Text(v)),
            // DataCell(Text(value.toString())),
          ])
        );
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
                SizedBox(height:50),

                // SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.red)
                    ),
                    child: ExpansionTile(
                      title: Text(
                        "Ingredients",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)
                              ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              product.fields['nf_ingredient_statement']
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                              width: 1,
                              color: Color(0xff343a40)
                          ),
                        ),
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.resolveWith((states) => Color(0xff343a40)),
                          headingTextStyle: TextStyle(
                            color: Colors.white
                          ),
                          columns: [
                            DataColumn(label: Text("Title")),
                            DataColumn(label: Text("Value"))
                          ],
                          // rows: [
                          //   DataRow(cells: [
                          //     DataCell(Text("item1")),
                          //     DataCell(Text("item2")),
                          //   ]),
                          //   DataRow(cells: [
                          //     DataCell(Text("item1")),
                          //     DataCell(Text("item2")),
                          //   ]),
                          // ]
                          rows: generateRows(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}
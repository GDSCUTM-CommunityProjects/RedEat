import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart';
import 'package:src/Pages/BarcodeFailedPage.dart';
import 'package:src/Pages/login.dart';
import 'package:src/Pages/ProductInfoPage.dart';

import '../BackendConnection/BackendURL.dart';
import '../BackendConnection/Product.dart';
import '../BackendConnection/SampleProductJson.dart';
import 'package:http/http.dart' as http;

class SearchDefaultPage extends StatefulWidget {
  const SearchDefaultPage({Key? key}) : super(key: key);

  @override
  State<SearchDefaultPage> createState() => _SearchDefaultPageState();
}

class _SearchDefaultPageState extends State<SearchDefaultPage> {
  String barcode = "";
  Future<String>? _barcodeResponse;

  // Make Post request and return product information
  Future<String> getProductInfo(String barcode) async {
    final response = await http.post(
      // uri,
      Uri.parse("${BackendURL.BACKEND_URL}api/search_product"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'upc': barcode,
        'product_name': ""
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get product information');
    }
  }


  // Scans barcode and redirect to ProductInfoPage or BarcodeFailedPage depending on the scanned results
  Future<void> scanBarcode() async {
    String result;
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          '#000000',
          'Cancel',
          true,
          ScanMode.BARCODE
      );
    } on PlatformException {
      result = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      barcode = result;
      // barcode = "060410001318";
      // barcode = "6969";
      _barcodeResponse = getProductInfo(barcode);

    });

    if (_barcodeResponse != null) {

      _barcodeResponse?.then((String response) {
        (response == "{}")
          ? Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BarcodeFailedPage())
            )
          : Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProductInfo(Product.toMap(response)))
              // MaterialPageRoute(builder: (context) => ProductInfo(product1))
            );
      });
    }
    else {
      setState(() {
        barcode = "HTTP failed";
      });
    }

  }


  // Builds a new portion of the page for a progress bar
  FutureBuilder<String> buildProgressBar() {
    return FutureBuilder<String>(
      future: _barcodeResponse,
      builder: ((context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator()
        ],);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    const IconData barcodeIcon = IconData(0xf586, fontFamily: 'iconFont', fontPackage: 'iconFontPackage');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Search ',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'for an item',
                    style: TextStyle(
                      fontSize: 36,
                      color: Color(0xff343a40),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "Select one of the following ways to search for an item",
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 50,),
              searchOptionButton(context, const IconData(0xf586, fontFamily: "CupertinoIcons.iconFont", fontPackage: "iconFontPackage"), "Scan Barcode", ""),
              const SizedBox(height: 20,),
              searchOptionButton(context, Icons.search, "Search by name", "/searchByName"),
              // SizedBox(height: 20,),
              // searchOptionButton(context, Icons.photo_library, "Choose from library", "/barcodeFailed"),

              const SizedBox(height: 30),
              Text(
                "Barcode: $barcode",
                style: const TextStyle(
                    fontSize: 24
                ),
              )
            ]
          )
        )
      )
    );
  }

  // Buttons to navigate to other search pages
  Widget searchOptionButton(BuildContext context, IconData icon, String title, String routeName) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
            height: 90,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page()));
                  (routeName != "") ? Navigator.pushNamed(context, routeName) : scanBarcode();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10, vertical: 20),
                      child: Icon(
                        icon,
                        size: 28,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 24
                          ),
                        ),
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}
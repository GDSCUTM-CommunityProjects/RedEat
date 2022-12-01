import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:src/Pages/login.dart';
import 'package:src/Pages/ProductInfoPage.dart';

import '../BackendConnection/BackendURL.dart';
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


  Future<String> getProductInfo(String barcode) async {
    final response = await http.post(
      Uri.parse("${BackendURL.BACKEND_URL}api/search_product/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'upc': barcode,
        'product_name': ""
      }),
    );
    return response.body;
    if (response.statusCode == 200) {

      // return Album.fromJson(jsonDecode(response.body));
      return response.body;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get product information');
    }
  }


  // Function to scan barcode
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
      // barcode = result;
      barcode = "060410001318";
      _barcodeResponse = getProductInfo(barcode);
      // getProductInfo(barcode).then((String response) => {
      //   barcode = "abc",
      //   Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => ProductInfo(response))
      //   )
      // });
    });

    if (_barcodeResponse != null) {

      _barcodeResponse?.then((String response) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductInfo(product1))
          // MaterialPageRoute(builder: (context) => ProductInfo("060410001318"))
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
                children: [
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
              SizedBox(height: 20,),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "Select one of the following ways to search for an item",
                  textAlign: TextAlign.center,
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
              //   child: Divider(
              //     color: Color(0xff343a40),
              //     thickness: 5,
              //   ),
              // ),
              // // SizedBox(height: 30),

              SizedBox(height: 50,),
              // searchOptionButton(context, Icons.qr_code_scanner, "Scan Barcode", "/barcodeScanner", null),
              searchOptionButton(context, Icons.qr_code_scanner, "Scan Barcode", ""),
              SizedBox(height: 20,),
              searchOptionButton(context, Icons.search, "Search by name", "/searchByName"),
              SizedBox(height: 20,),
              searchOptionButton(context, Icons.photo_library, "Choose from library", "/barcodeFailed"),

              SizedBox(height: 30),
              Text(
                "Barcode: " + barcode,
                style: TextStyle(
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
                          style: TextStyle(
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

// Buttons to navigate to other search pages
// Widget searchOptionButton(BuildContext context, IconData icon, String title, String routeName, Future<void> func) {
//   return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0),
//       child: Container(
//         height: 90,
//         child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 minimumSize: const Size.fromHeight(50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 )
//             ),
//             onPressed: () {
//               // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page()));
//               (routeName != "") ? Navigator.pushNamed(context, routeName) : func;
//             },
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal:10, vertical: 20),
//                   child: Icon(
//                     icon,
//                     size: 28,
//                   ),
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       title,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 24
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//         )
//       )
//   );
// }
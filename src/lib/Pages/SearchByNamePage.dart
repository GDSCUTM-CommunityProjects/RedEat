import 'dart:convert';

import 'package:flutter/material.dart';
import '../BackendConnection/BackendURL.dart';
import '../BackendConnection/SampleProductJson.dart';
import 'package:http/http.dart' as http;

import 'ProductInfoPage.dart';

class SearchByNamePage extends StatefulWidget {
  const SearchByNamePage({Key? key}) : super(key: key);

  @override
  State<SearchByNamePage> createState() => _SearchByNamePageState();
}

class _SearchByNamePageState extends State<SearchByNamePage> {

  String productName = "";
  TextEditingController productNameController = TextEditingController();
  Future<String>? _searchResponse;
  bool successfulSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productNameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productNameController.dispose();
    super.dispose();
  }

  Future<String> getProductInfo(String name) async {
    final response = await http.post(
      Uri.parse("${BackendURL.BACKEND_URL}api/search_product/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'upc': "",
        'product_name': name
      }),
    );
    return response.body;
    if (response.statusCode == 200) {

      setState(() {

      });
      return response.body;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get product information');
    }
  }

  Future<void> searchProduct(String name) async {
    _searchResponse = getProductInfo(name);
    if (_searchResponse != null) {
      _searchResponse?.then((String response) {
        if (response == "{}") {
          // show error message
        }
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductInfo(product1))
          // MaterialPageRoute(builder: (context) => ProductInfo("060410001318"))
        );
      });
    }
  }

  // Builds a new portion of the page for a progress bar
  FutureBuilder<String> buildProgressBar() {
    return FutureBuilder<String>(
      future: _searchResponse,
      builder: ((context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator()
        ],);
      }),
    );
  }

  // Widget for error message
  Widget errorMessage(String message) {
    return Row(
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
          size: 14.0,
        ),
        Text(
          ' ' + message,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Search by Name"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                TextField(
                  controller: productNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 18,
                      // color: Colors.grey[500],
                      color: Colors.red
                    ),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    //
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.red, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.red, width: 1.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    hintText: "Enter the name of the product",
                    fillColor: Colors.white
                  ),
                ),

                // show error message if search failed
                if (!successfulSearch)...[
                  SizedBox(height: 10),
                  errorMessage("Unable to find this product")
                ],

                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                  ),
                  onPressed: () {
                    setState(() {
                      productName = productNameController.text;
                    });
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(fontSize: 24),
                  )
                ),



              ],
            ),
          ),
        ),
      )
    );
  }
}


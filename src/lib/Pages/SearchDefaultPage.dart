import 'package:flutter/material.dart';
import 'package:src/Pages/login.dart';

class SearchDefaultPage extends StatefulWidget {
  const SearchDefaultPage({Key? key}) : super(key: key);

  @override
  State<SearchDefaultPage> createState() => _SearchDefaultPageState();
}

class _SearchDefaultPageState extends State<SearchDefaultPage> {
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
              searchOptionButton(context, Icons.qr_code_scanner, "Scan Barcode", "/barcodeScanner"),
              SizedBox(height: 20,),
              searchOptionButton(context, Icons.search, "Search by name", "/login"),
              SizedBox(height: 20,),
              searchOptionButton(context, Icons.photo_library, "Choose from library", "/login"),
            ]
          )
        )
      )
    );
  }
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
              Navigator.pushNamed(context, routeName);
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
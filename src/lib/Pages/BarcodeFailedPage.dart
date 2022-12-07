import 'package:flutter/material.dart';
import 'package:src/Pages/SearchByNamePage.dart';

class BarcodeFailedPage extends StatelessWidget {
  const BarcodeFailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Unable to find the product with the scanned barcode, please try searching with the product name",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red
                  ),
                ),

                const SizedBox(height:40),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const SearchByNamePage())
                        // MaterialPageRoute(builder: (context) => ProductInfo("060410001318"))
                      );
                    },
                    child: const Text(
                      'Search by Product Name',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white
                      ),
                    )
                ),
              ],
            )
          )
        )
      )
    );
  }
}

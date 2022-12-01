import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarCodeScanner extends StatefulWidget {
  const BarCodeScanner({Key? key}) : super(key: key);

  @override
  State<BarCodeScanner> createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {
  String _barcode = "";


  @override
  void initState() {
    super.initState();
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
      _barcode = result;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                      ),

                      onPressed: () => scanBarcode(),
                      child: Text(
                        'Scan',
                        style: TextStyle(fontSize: 24),
                      )),
                ),
                SizedBox(height: 30,),

                Text(
                  "Barcode: " + _barcode,
                  style: TextStyle(
                    fontSize: 24
                  ),
                )
              ],
            ),
          ),
        )

    );
  }
}

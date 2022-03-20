import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/styles/size.dart';
// import 'package:barcode_scanner/barcode_parsers/barcode_scanner.dart';
// import 'package:barcode_scan/barcode_scan.dart';

class ScanQRcodePage extends StatefulWidget {
  ScanQRcodePage({Key? key}) : super(key: key);

  @override
  State<ScanQRcodePage> createState() => _ScanQRcodePageState();
}

class _ScanQRcodePageState extends State<ScanQRcodePage> {
  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Scan QR Code',
                style: TextStyle(fontSize: 28, color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width(context: context) / 20,
              ),
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Result",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      qrCodeResult,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(15.0),
                      onPressed: () async {
                        // BarcodeScanner.scan();
                        // String codeSanner =
                        //     await BarcodeScanner.scan(); //barcode scnner
                        // setState(() {
                        //   qrCodeResult = codeSanner;
                        // });

                        // try{
                        //   BarcodeScanner.scan()    //this method is used to scan the QR code
                        // }catch (e){
                        //   BarcodeScanner.CameraAccessDenied;   //we can print that user has denied for the permisions
                        //   BarcodeScanner.UserCanceled;   //we can print on the page that user has cancelled
                        // }
                      },
                      child: Text(
                        "Open Scanner",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 3.0),
                          borderRadius: BorderRadius.circular(20.0)),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

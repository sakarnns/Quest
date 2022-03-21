import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quest_2/user/scanconfirm_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? hash;
String? idevent;
double? lati;
double? long;
bool isLoading = true;

class ScanQrUserPage extends StatefulWidget {
  ScanQrUserPage({Key? key}) : super(key: key);

  @override
  State<ScanQrUserPage> createState() => _ScanQrUserPageState();
}

class _ScanQrUserPageState extends State<ScanQrUserPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Position? _currentPosition;
  String? _currentAddress;
  bool isLoading = false;

  Future<Position> _getPosition() async {
    final prefs = await SharedPreferences.getInstance();

    idevent = prefs.getString('selecteventid');
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location not available");
      }
    } else {
      print("Locating...");
    }
    return await Geolocator.getCurrentPosition();
  }

  void _getAddress(latitude, longitude) async {
    try {
      List<Placemark> placemark = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemark[0];
      setState(() {
        _currentAddress = '${place.locality}, ${place.country}';
        _currentAddress = 'Latitude:$latitude, Longitude:$longitude';
        lati = latitude;
        long = longitude;
        print("latitude: $latitude");
        print("longitude: $longitude");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    print("fetch 1 ");
    isLoading = true;
    _currentPosition = await _getPosition();
    _getAddress(_currentPosition!.latitude, _currentPosition!.longitude);
    isLoading = false;
    setState(() {});
    print("fetch 2 ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Scan QR',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: isLoading != true
                ? Expanded(
                    flex: 5,
                    child: Container(child: _buildQrView(context)),
                  )
                : Container(
                    height: 633,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(),
                        Text(
                          "LOADING",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 200 ||
            MediaQuery.of(context).size.height < 200)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xFF6F2DA8),
          borderRadius: 8,
          borderLength: 25,
          borderWidth: 8,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen(
      (scanData) {
        if (scanData.code != null) {
          controller.dispose();
          result = scanData;
          hash = result!.code;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => ScanConfirmUserPage()),
              (Route<dynamic> route) => false);
        }
        // else {}
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'no Permission',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xFFEBEDF2),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

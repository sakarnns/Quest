import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quest_2/data/eventdetail.dart';
import 'package:quest_2/data/qrcodegenerate.dart';
import 'package:quest_2/data/qrgen.dart';
import 'package:quest_2/models/qr_gen.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_user/navigation_user.dart';

bool isLoading = true;
int? tokenexpire;

Future getqr() async {
  print("activitybrowse activate!");
  final prefs = await SharedPreferences.getInstance();

  Position? _currentPosition;
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
  _currentPosition = await Geolocator.getCurrentPosition();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/qrcode";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };
  Map body = {
    "idevent": eventDetailData.eventDetail?.eventId,
    // "latitude": 13.89729217570833,
    // "longitude": 100.58572663072604
    "latitude": _currentPosition.latitude,
    "longitude": _currentPosition.longitude
  };

  print(_currentPosition.latitude);
  print(_currentPosition.longitude);
  print(jsonEncode(body));

  var jsonResponse;
  var res = await http.post(
    Uri.parse(url),
    body: jsonEncode(body),
    headers: requestHeaders,
  );
  tokenexpire = res.statusCode;

  print(res.statusCode);
  print(res.body);

  if (res.statusCode == 201) {
    qrGenData.qrGen = QrGen.fromJson(json.decode(res.body));

    jsonResponse = res.body;
    print("Response status: ${res.statusCode}");
    return jsonResponse;
  } else {}
}

class GeneratorQRPage extends StatefulWidget {
  GeneratorQRPage({Key? key}) : super(key: key);

  @override
  State<GeneratorQRPage> createState() => _GeneratorQRPageState();
}

class _GeneratorQRPageState extends State<GeneratorQRPage> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    print("fetch 1 ");
    isLoading = true;
    await getqr();
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    print("fetch 2 qr");
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your QR',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF6F2DA8),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: BackButton(
            color: Color(0xFF6F2DA8),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: height(context: context) / 10,
                  ),
                  Container(
                    child: isLoading != true
                        ? areaQR()
                        : Container(
                            height: 333,
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
                  SizedBox(
                    height: height(context: context) / 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget areaQR() {
    return Column(
      children: [
        Container(
          child: QrImage(data: '${qrGenData.qrGen!.hash}'),
        ),
        SizedBox(
          height: height(context: context) / 10,
        ),
        doneQRbtn()
      ],
    );
  }

  Widget doneQRbtn() {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: MaterialButton(
        color: Color(0xFF6F2DA8),
        minWidth: 163,
        height: 40,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          print('${QrcodeGenerateData.qrcodeGenerate}');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => NavigationUser()),
              (Route<dynamic> route) => false);
        },
        child: Text(
          'Done',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}

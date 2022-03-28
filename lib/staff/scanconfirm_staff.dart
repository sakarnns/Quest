import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quest_2/staff/scan_qr_staff.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_staff/navigation_staff.dart';

var responsebody;
int? tokenexpire;

Future scanconfirm() async {
  print("staff scanconfirm activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/qrcode_decoder";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };

  Map body = {
    "Hash": hash,
    "idevent": idevent,
    "latitude": lati,
    "longitude": long
  };

  var res = await http.post(Uri.parse(url),
      headers: requestHeaders, body: jsonEncode(body));
  tokenexpire = res.statusCode;
  if (res.statusCode == 201) {
    responsebody = "Success";
  } else if (res.statusCode == 400) {
    responsebody = ("Your QR code is invilid");
  } else {
    var resdecode = json.decode(res.body);
    responsebody = resdecode['message'];
  }
}

class ScanConfirmStaffPage extends StatefulWidget {
  ScanConfirmStaffPage({Key? key}) : super(key: key);

  @override
  State<ScanConfirmStaffPage> createState() => _ScanConfirmStaffPageState();
}

class _ScanConfirmStaffPageState extends State<ScanConfirmStaffPage> {
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    print("fetch 1 ");
    await scanconfirm();
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    print("fetch 2 ");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width(context: context) / 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: height(context: context) / 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Confirm Participant",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height(context: context) / 20,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      responsebody,
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height(context: context) / 2,
              ),
              cofirmEventButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget cofirmEventButton() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Color(0xFF6F2DA8),
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        scanconfirm();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationStaff()),
            (Route<dynamic> route) => false);
      },
      child: Text(
        "Confirm",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

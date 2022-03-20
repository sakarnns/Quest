import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/scan_qr_user.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_user/navigation_user.dart';

var responsebody;
int? tokenexpire;

Future scanconfirm() async {
  print("scanconfirm activate!!");
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
  print(res.statusCode);
  print(res.body);
  if (res.statusCode == 201) {
    responsebody = "Success";
  } else {
    var resdecode = json.decode(res.body);
    responsebody = resdecode['message'];
  }
}

class ScanConfirmUserPage extends StatefulWidget {
  ScanConfirmUserPage({Key? key}) : super(key: key);

  @override
  State<ScanConfirmUserPage> createState() => _ScanConfirmUserPage();
}

class _ScanConfirmUserPage extends State<ScanConfirmUserPage> {
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
                height: height(context: context) / 10,
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        responsebody,
                        // "Wrong Location",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ],
                  ),
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
      disabledColor: Colors.black,
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        // scanconfirm();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationUser()),
            (Route<dynamic> route) => false);
      },
      child: Text(
        "Confirm",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

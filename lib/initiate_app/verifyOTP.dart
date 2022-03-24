import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/components/otp_form.dart';
import 'package:quest_2/initiate_app/forgot.dart';
import 'package:quest_2/initiate_app/setnewpassword.dart';
import 'package:quest_2/styles/size.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String? otpverificationcheck;
int? rescode;
bool otpstatuscheck = false;

class VerifyOTP extends StatefulWidget {
  VerifyOTP({Key? key}) : super(key: key);

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

Future verify(otp) async {
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/check_OTP";
  print(emailaddress);
  Map body = {
    "otpnum": otp,
    "email": emailaddress,
  };

  var res = await http.post(Uri.parse(url), body: body);
  print(res.statusCode);
  print(res.body);
  rescode = res.statusCode;
  if (res.statusCode == 200) {
    var jsonResponse = json.decode(res.body);
    setToken(jsonResponse['token']);
  } else {
    print("check");
    print("verify failed : " + res.statusCode.toString() + "\n" + res.body);
  }
}

setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

bool? isvalid;
bool isOtpFilled = false;

class _VerifyOTPState extends State<VerifyOTP> {
  void fectc() async {
    print("fetch 1 ");
    otpgroup.otpfirst.clear();
    otpgroup.otpsecond.clear();
    otpgroup.otpthird.clear();
    otpgroup.otpfourth.clear();
    otponecheck = "";
    otpsecondcheck = "";
    otpthirdcheck = "";
    otpfourthcheck = "";
    otpstatuscheck = false;
    setState(() {});
    print("fetch 2 ");
  }

  void initState() {
    fectc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context: context) / 20,
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 166.66,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/quest_newlogo_color.png'), // Add Path image
                        fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 33),
                  child: Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F2DA8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Enter the verification code on your email address.',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height(context: context) / 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: OtpForm(),
                ),
                SizedBox(
                  height: height(context: context) / 90,
                ),
                notificationOTP(),
                SizedBox(
                  height: height(context: context) / 20,
                ),
                Text(
                  "This code will expired in ",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                buildTimer(),
                SizedBox(
                  height: height(context: context) / 15,
                ),
                MaterialButton(
                  color: Color(0xFF6F2DA8),
                  disabledColor: Colors.grey,
                  minWidth: 163,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: !(otponecheck == "" ||
                          otpsecondcheck == "" ||
                          otpthirdcheck == "" ||
                          otpfourthcheck == "")
                      ? () async {
                          otpverificationcheck = (otponecheck! +
                              otpsecondcheck! +
                              otpthirdcheck! +
                              otpfourthcheck!);
                          await verify(otpverificationcheck);
                          if (rescode == 200) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SetNewPassword()),
                                (Route<dynamic> route) => false);
                          } else {
                            otponecheck = "";
                            otpsecondcheck = "";
                            otpthirdcheck = "";
                            otpfourthcheck = "";
                            otpgroup.otpfirst.clear();
                            otpgroup.otpsecond.clear();
                            otpgroup.otpthird.clear();
                            otpgroup.otpfourth.clear();
                            otpstatuscheck = false;
                            setState(() {});
                          }
                        }
                      : null,
                  child: Text(
                    'Verify',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TweenAnimationBuilder(
          tween: Tween(begin: 300.0, end: 0.0),
          duration: Duration(seconds: 300),
          builder: (_, dynamic value, child) => Text(
            value > 60 && value % 60 < 10
                ? "0${(value / 60).toInt()}:0${(value % 60).toInt()}"
                : value > 60
                    ? "0${(value / 60).toInt()}:${(value % 60).toInt()}"
                    : value > 10
                        ? "00:${value.toInt()}"
                        : "00:0${value.toInt()}",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }

  Widget notificationOTP() {
    return Visibility(
      visible: otpstatuscheck,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Code was invilid please try again.",
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

OtpNumber otpgroup = OtpNumber();

class OtpNumber {
  TextEditingController otpfirst = TextEditingController();
  TextEditingController otpsecond = TextEditingController();
  TextEditingController otpthird = TextEditingController();
  TextEditingController otpfourth = TextEditingController();
}

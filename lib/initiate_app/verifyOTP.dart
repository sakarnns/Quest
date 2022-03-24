import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/initiate_app/forgot.dart';
import 'package:quest_2/initiate_app/setnewpassword.dart';
import 'package:quest_2/styles/size.dart';
import 'package:http/http.dart' as http;

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

  if (res.statusCode == 200) {
    print("raw");
    print(verified);
    verified = true;
  } else {
    print("check");
    otpnotificationone = true;
    print("verify failed : " + res.statusCode.toString() + "\n" + res.body);
  }
}

bool verified = false;
bool? isvalid;
bool agreedterm = false;
List otpcheck = new List.filled(4, "", growable: false);
String otp = "";
bool isOtpFilled = false;
bool otpnotificationone = false;

class _VerifyOTPState extends State<VerifyOTP> {
  void fectc() async {
    print("fetch 1 ");
    verified = false;
    otpnotificationone = false;
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
                      top: MediaQuery.of(context).size.height / 50),
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
                  height: height(context: context) / 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(first: true, last: false, index: 0),
                      _textFieldOTP(first: true, last: false, index: 1),
                      _textFieldOTP(first: true, last: false, index: 2),
                      _textFieldOTP(first: true, last: true, index: 3),
                    ],
                  ),
                ),
                notificationOTP(),
                SizedBox(
                  height: height(context: context) / 50,
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
                  height: height(context: context) / 20,
                ),
                MaterialButton(
                  color: Color(0xFF6F2DA8),
                  disabledColor: Colors.grey,
                  minWidth: 163,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: isOtpFilled ? verifyOtp : null,
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

  void verifyOtp() async {
    otpcheck.forEach(
      (element) {
        otp += element;
      },
    );
    print(otp);
    await verify(otp);
    print(verified);
    verified == true
        ? Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SetNewPassword()),
          )
        : otpnotificationone = true;
  }

  void checkIsOtpFilled() {
    print("Invoked checkIsOtpFilled().");
    print(otpcheck);
    setState(() {
      isOtpFilled = isOtpFilledAll();
    });
  }

  bool isOtpFilledAll() {
    for (int i = 0; i < otpcheck.length; i++) {
      if (otpcheck[i] == "") {
        return false;
      }
    }
    return true;
  }

  _textFieldOTP({
    required bool first,
    last,
    required int index,
  }) {
    return Container(
      height: 72,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
            otpcheck[index] = value;
            checkIsOtpFilled();
            otpnotificationone = false;
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
              hintText: '.',
              counter: Offstage(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              )),
        ),
      ),
    );
  }
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
    visible: otpnotificationone,
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "OTP failed",
            style: TextStyle(
              color: Colors.red,
              fontSize: 14.0,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    ),
  );
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class SetNewPassword extends StatefulWidget {
  SetNewPassword({Key? key}) : super(key: key);

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

bool? isvalid;
String? confirmpasswordOnForgot;
String? passwordOnForgot;
bool? isPasswordMatch;
bool passchange = false;

Future setnewpass(newpass) async {
  print("setnewpass activated!");
  final prefs = await SharedPreferences.getInstance();
  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/set_new_password";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };
  Map body = {"newpassword": newpass};

  var res = await http.patch(Uri.parse(url),
      body: jsonEncode(body), headers: requestHeaders);

  print(res.statusCode);

  if (res.statusCode == 201) {
    passchange = true;
  }
}

class _SetNewPasswordState extends State<SetNewPassword> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context: context) / 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height(context: context) / 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context: context) / 16,
                ),
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
                      top: MediaQuery.of(context).size.height / 50),
                  child: Text(
                    'Set new password',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F2DA8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 70),
                  child: Text(
                    'Your new password should be different from previous used \n                                               passwords.',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 130,
                  ),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key_rounded,
                          color: Color(0xFF6F2DA8),
                        ),
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Password',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        passwordOnForgot = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 130,
                  ),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key_rounded,
                          color: Color(0xFF6F2DA8),
                        ),
                        errorText: isPasswordMatch == null || isPasswordMatch!
                            ? null
                            : 'Mismatched Password',
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Confirm Password',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        confirmpasswordOnForgot = val;
                        if (passwordOnForgot == confirmpasswordOnForgot) {
                          isPasswordMatch = true;
                        } else {
                          isPasswordMatch = false;
                        }
                      });
                    },
                  ),
                ),
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
                  onPressed: passwordOnForgot != null &&
                          confirmpasswordOnForgot != null &&
                          passwordOnForgot != "" &&
                          confirmpasswordOnForgot != "" &&
                          passwordOnForgot != " " &&
                          confirmpasswordOnForgot != " " &&
                          isPasswordMatch == true
                      ? () {
                          setnewpass(confirmpasswordOnForgot);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()),
                              (Route<dynamic> route) => false);
                        }
                      : null,
                  child: Text(
                    'SAVE',
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
}

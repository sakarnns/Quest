import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future verifyphonenumber(String number) async {
  print("verifyphonenumber activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/verify_phone_number";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };

  Map body = {"Phone_Number": number};

  print(jsonEncode(body));

  var jsonResponse;
  var res = await http.post(Uri.parse(url),
      body: jsonEncode(body), headers: requestHeaders);
  print(res.statusCode);
  if (res.statusCode == 201) {
    jsonResponse = json.decode(res.body);
    print(jsonResponse);
  }
}

class VerifyPhonePage extends StatefulWidget {
  VerifyPhonePage({Key? key}) : super(key: key);

  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}

bool? isvalid;
String? verifyphonenumberyes;

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              'Verify Phone Number',
              style: TextStyle(
                fontSize: 24.0,
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
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context: context) / 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height(context: context) / 8,
                ),
                SizedBox(
                  height: height(context: context) / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Phone Number",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context: context) / 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 500,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Color(0xFF6F2DA8),
                        ),
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Phone Number',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        verifyphonenumberyes = val;
                        isvalid = true;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: height(context: context) / 100,
                ),
                MaterialButton(
                  color: Color(0xFF6F2DA8),
                  disabledColor: Colors.grey,
                  minWidth: 163,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed:
                      verifyphonenumberyes != null && verifyphonenumberyes != ""
                          ? () {
                              Navigator.pop(context);
                              verifyphonenumber(verifyphonenumberyes!);
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //         builder: (context) => OptionPage()),
                              //     (Route<dynamic> route) => true);
                              print(verifyphonenumberyes);
                            }
                          : null,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

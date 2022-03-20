import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future verifycitizen(String ctzid) async {
  print("verifycitizen activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/verify_citizen_id";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };

  Map body = {"Citizen_ID": ctzid};

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

class VerifyCitizenPage extends StatefulWidget {
  VerifyCitizenPage({Key? key}) : super(key: key);

  @override
  _VerifyCitizenPageState createState() => _VerifyCitizenPageState();
}

bool? isvalid;
String? verifycitizenyes;

class _VerifyCitizenPageState extends State<VerifyCitizenPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Verify Citizen ID',
                style: TextStyle(fontSize: 32.0, color: Colors.black)),
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
              child: Column(
                children: [
                  SizedBox(
                    height: height(context: context) / 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Citizen Number",
                        style: TextStyle(color: Colors.black, fontSize: 16),
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(13),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          focusedBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Citizen Number',
                          contentPadding: EdgeInsets.all(8.0),
                          border: outlineInputBorder()),
                      onChanged: (val) {
                        setState(() {
                          verifycitizenyes = val;
                          isvalid = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: height(context: context) / 100,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         print('Photo');
                  //       },
                  //       child: Text(
                  //         "Upload Citizen Card",
                  //         style:
                  //             TextStyle(decoration: TextDecoration.underline),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: height(context: context) / 100,
                  ),
                  MaterialButton(
                    color: Colors.black,
                    disabledColor: Colors.grey,
                    minWidth: 163,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed:
                        verifycitizenyes != null && verifycitizenyes != ""
                            ? () {
                                Navigator.pop(context);
                                verifycitizen(verifycitizenyes!);
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //         builder: (context) => OptionPage()),
                                //     (Route<dynamic> route) => true);
                                print(verifycitizenyes);
                              }
                            : null,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

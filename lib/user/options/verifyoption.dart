import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/userdata.dart';
import 'package:quest_2/models/user.dart';
import 'package:quest_2/user/options/verifycitizen.dart';
import 'package:quest_2/user/options/verifyphone.dart';
import 'package:quest_2/styles/size.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../activity_browse_user.dart';

Future setuserStatus() async {
    print("set user status activated!");
    final prefs = await SharedPreferences.getInstance();

    final val = prefs.getString('token');
    String urlProfile =
        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/profile";
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': (val) as String
    };
    var resProfile = await http.get(
      Uri.parse(urlProfile),
      headers: requestHeaders,
    );
    tokenexpire = resProfile.statusCode;

    if (resProfile.statusCode == 200) {
      // print(json.decode(resProfile.body));
      UserData.userProfile = UserProfile.fromJson(json.decode(resProfile.body));
      // print(UserData.userProfile!.image);
    }
  }

class VerifyPage extends StatefulWidget {
  VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    setuserStatus();
    print("fetch 2 ");
    setState(() {});
  }
  
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
              'Verify',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please verify with citizen ID",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context: context) / 50,
                ),
                MaterialButton(
                  disabledColor: Colors.grey,
                  color: Color(0xFF6F2DA8),
                  minWidth: 163,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: UserData.userProfile!.ctzid == "" ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyCitizenPage()));
                  }: null,
                  child: Text(
                    'Verify',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: height(context: context) / 20,
                ),
                SizedBox(
                  height: height(context: context) / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please verify with Phone Number",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context: context) / 50,
                ),
                MaterialButton(
                  disabledColor: Colors.grey,
                  color: Color(0xFF6F2DA8),
                  minWidth: 163,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: UserData.userProfile!.phone == "" ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyPhonePage()));
                  }:null,
                  child: Text(
                    'Verify',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

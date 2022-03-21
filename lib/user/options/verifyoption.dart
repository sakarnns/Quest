import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/user/options/verifycitizen.dart';
import 'package:quest_2/user/options/verifyphone.dart';
import 'package:quest_2/styles/size.dart';

class VerifyPage extends StatefulWidget {
  VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
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
                      "Please verify with citizen ID for unlock more features",
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyCitizenPage()));
                  },
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
                      "Please verify with Phone Number for unlock more features",
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyPhonePage()));
                  },
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

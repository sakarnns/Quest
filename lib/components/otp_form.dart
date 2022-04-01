import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/initiate_app/verifyOTP.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';

String? otponecheck;
String? otpsecondcheck;
String? otpthirdcheck;
String? otpfourthcheck;

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController textEditingController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: height(context: context) * 0.06,
                  child: TextFormField(
                    controller: otpgroup.otpfirst,
                    autofocus: true,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    onChanged: (value) {
                      nextField(value, pin2FocusNode);
                      otponecheck = value;
                      print(otponecheck);
                    },
                  ),
                ),
                SizedBox(
                  width: height(context: context) * 0.06,
                  child: TextFormField(
                    controller: otpgroup.otpsecond,
                    focusNode: pin2FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    onChanged: (value) {
                      nextField(value, pin3FocusNode);
                      otpsecondcheck = value;
                      print(otpsecondcheck);
                    },
                  ),
                ),
                SizedBox(
                  width: height(context: context) * 0.06,
                  child: TextFormField(
                    controller: otpgroup.otpthird,
                    focusNode: pin3FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    onChanged: (value) {
                      nextField(value, pin4FocusNode);
                      otpthirdcheck = value;
                      print(otpthirdcheck);
                    },
                  ),
                ),
                SizedBox(
                  width: height(context: context) * 0.06,
                  child: TextFormField(
                    controller: otpgroup.otpfourth,
                    focusNode: pin4FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    onChanged: (value) {
                      otpfourthcheck = value;
                      print(otpfourthcheck);
                      if (value.length == 1) {
                        pin4FocusNode!.unfocus();
                        otpstatuscheck = false;
                        setState(() {});
                        // Then you need to check is the code is correct or not
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

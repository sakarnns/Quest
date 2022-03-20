import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/styles/size.dart';

class TestPageSelect2 extends StatefulWidget {
  TestPageSelect2({Key? key}) : super(key: key);

  @override
  State<TestPageSelect2> createState() => _TestPageSelect2State();
}

class _TestPageSelect2State extends State<TestPageSelect2> {
  bool isButtonActive = true;
  bool isButtonChange = true;
  bool isButtonQRActive = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Test Button',
              style: TextStyle(fontSize: 32.0, color: Colors.black)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
          backgroundColor: Color(0xFFEBEDF2),
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
            child: Column(children: [
              SizedBox(
                height: height(context: context) / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(8.80), child: joinButton()),
                  Padding(padding: EdgeInsets.all(8.0), child: qrButton()),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget joinButton() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: isButtonActive
          ? () {
              setState(() {
                isButtonActive = false;
                isButtonQRActive = true;
              });
            }
          : null,
      child: Text(
        isButtonActive ? "Join" : "Joined",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget qrButton() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: isButtonQRActive ? () {} : null,
      child: Text(
        "QR",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

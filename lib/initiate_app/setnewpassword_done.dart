import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/initiate_app/login.dart';
import 'package:quest_2/styles/size.dart';

class SetNewPasswordDone extends StatefulWidget {
  SetNewPasswordDone({Key? key}) : super(key: key);

  @override
  State<SetNewPasswordDone> createState() => _SetNewPasswordDoneState();
}

class _SetNewPasswordDoneState extends State<SetNewPasswordDone> {
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
                height: height(context: context) / 6,
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
                    top: MediaQuery.of(context).size.height / 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Password has been changed.',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F2DA8),
                      ),
                    ),
                  ],
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
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  'DONE',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

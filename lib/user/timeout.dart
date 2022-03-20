import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/initiate_app/login.dart';
import 'package:quest_2/styles/size.dart';

class TimeOutPage extends StatefulWidget {
  TimeOutPage({Key? key}) : super(key: key);

  @override
  State<TimeOutPage> createState() => _TimeOutPageState();
}

class _TimeOutPageState extends State<TimeOutPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width(context: context) / 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: height(context: context) / 5,
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
              SizedBox(
                height: height(context: context) / 10,
              ),
              Container(
                // height: 633,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TIMEOUT!',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F2DA8),
                      ),
                    ),
                    Text(
                      'You haven\'t log on yet or your session',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: height(context: context) / 100,
                    ),
                    Text(
                      'has time out, Please log on again.',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height(context: context) / 10,
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
                  'LOGIN',
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

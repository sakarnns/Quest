import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/styles/size.dart';
import 'navigation_user/navigation_user.dart';

class PreviewActivityUserPageFail500 extends StatefulWidget {
  PreviewActivityUserPageFail500({Key? key}) : super(key: key);

  @override
  _PreviewActivityUserPageFail500State createState() =>
      _PreviewActivityUserPageFail500State();
}

class _PreviewActivityUserPageFail500State
    extends State<PreviewActivityUserPageFail500> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width(context: context) / 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height(context: context) / 2.5,
              ),
              Column(
                children: [
                  Text(
                    "  Failed! duplicate event name.\nPlease try another event name.",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: height(context: context) / 40,
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
                          builder: (BuildContext context) => NavigationUser()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(
                height: height(context: context) / 40,
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

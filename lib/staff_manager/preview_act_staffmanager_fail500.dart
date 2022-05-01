import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/styles/size.dart';
import 'navigation_staffmanager/navigation_staffmanager.dart';

class PreviewActivityStaffManagerPageFail500 extends StatefulWidget {
  PreviewActivityStaffManagerPageFail500({Key? key}) : super(key: key);

  @override
  State<PreviewActivityStaffManagerPageFail500> createState() =>
      _PreviewActivityStaffManagerPageFail500State();
}

class _PreviewActivityStaffManagerPageFail500State
    extends State<PreviewActivityStaffManagerPageFail500> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                          builder: (BuildContext context) =>
                              NavigationStaffmanager()),
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

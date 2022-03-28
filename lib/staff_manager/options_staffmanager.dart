import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/initiate_app/login.dart';

import 'create_staff_staffmanager.dart';

class OptionsStaffManagerPage extends StatefulWidget {
  OptionsStaffManagerPage({Key? key}) : super(key: key);

  @override
  State<OptionsStaffManagerPage> createState() =>
      _OptionsStaffManagerPageState();
}

class _OptionsStaffManagerPageState extends State<OptionsStaffManagerPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: BackButton(
              color: Color(0xFF6F2DA8),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.only(left: 40.0),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateStaffManagerPage()));
                  print("into Logout");
                },
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 28,
                    minHeight: 28,
                    maxWidth: 28,
                    maxHeight: 28,
                  ),
                  child: SvgPicture.asset('assets/icons/create_staff.svg'),
                ),
                title: Text(
                  'Create Staff',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 40.0),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false);
                  print("into Logout");
                },
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 28,
                    minHeight: 28,
                    maxWidth: 28,
                    maxHeight: 28,
                  ),
                  child: SvgPicture.asset('assets/icons/logout_option.svg'),
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

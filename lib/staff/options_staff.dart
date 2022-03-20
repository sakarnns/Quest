import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/initiate_app/login.dart';

class OptionsStaffPage extends StatefulWidget {
  OptionsStaffPage({Key? key}) : super(key: key);

  @override
  State<OptionsStaffPage> createState() => _OptionsStaffPageState();
}

class _OptionsStaffPageState extends State<OptionsStaffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: BackButton(
          color: Colors.black,
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
              )),
        ],
      ),
    );
  }
}

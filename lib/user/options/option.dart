import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/initiate_app/login.dart';
import 'package:quest_2/user/options/pending_activity_user.dart';
import 'package:quest_2/user/options/profile.dart';
import 'package:quest_2/user/options/verifyoption.dart';
import 'pending_reward_user.dart';

class OptionPage extends StatefulWidget {
  OptionPage({Key? key}) : super(key: key);

  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
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
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(left: 32.0),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));

                print("into Profile");
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 28,
                  minHeight: 28,
                  maxWidth: 28,
                  maxHeight: 28,
                ),
                child: SvgPicture.asset(
                  'assets/icons/profile_option.svg',
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 32.0),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VerifyPage()));

                print("into Verify");
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 28,
                  minHeight: 28,
                  maxWidth: 28,
                  maxHeight: 28,
                ),
                child: SvgPicture.asset(
                  'assets/icons/verify_option.svg',
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(
                'Verify',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 32.0),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserActivityPendingPage()));

                print("into PendingActivity");
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 28,
                  minHeight: 28,
                  maxWidth: 28,
                  maxHeight: 28,
                ),
                child: SvgPicture.asset(
                  'assets/icons/activity_pending.svg',
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(
                'Pending Activity',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 32.0),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PendingRewadUserPage()));

                print("into PendingReward");
              },
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 28,
                  minHeight: 28,
                  maxWidth: 28,
                  maxHeight: 28,
                ),
                child: SvgPicture.asset(
                  'assets/icons/reward_pending.svg',
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(
                'Pending Reward',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 32.0),
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
                child: SvgPicture.asset(
                  'assets/icons/logout_option.svg',
                  fit: BoxFit.contain,
                ),
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
        ),
      ),
    );
  }
}

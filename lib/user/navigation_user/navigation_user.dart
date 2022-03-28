import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/navigation_user/user_status.dart';
import 'package:quest_2/user/options/option.dart';
import 'package:quest_2/user/reward_browse_user.dart';
import '../activty_home_user.dart';
import '../create_activity_user.dart';
import '../home_user_assets/home_user.dart';

class NavigationUser extends StatefulWidget {
  NavigationUser({Key? key}) : super(key: key);

  @override
  State<NavigationUser> createState() => _NavigationUserState();
}

class _NavigationUserState extends State<NavigationUser> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    UserHomePage(),
    ActivityUserHomePage(),
    Text(
      '',
      style: optionStyle,
    ),
    RewardUserBrowsePage(),
    Text(
      '',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: null,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  _widgetOptions.elementAt(_selectedIndex),
                  SizedBox(
                    height: height(context: context) / 100,
                  ),
                ],
              ),
            ),
            StatusUser(),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              backgroundColor: Color(0xFFf0eff5),
              unselectedItemColor: Colors.grey,
              fixedColor: Color(0xFF6F2DA8),
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Container(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                      'assets/icons/home_page.svg',
                      color:
                          _selectedIndex == 0 ? Color(0xFF6F2DA8) : Colors.grey,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      'assets/icons/activitys_page.svg',
                      color:
                          _selectedIndex == 1 ? Color(0xFF6F2DA8) : Colors.grey,
                    ),
                  ),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                      'assets/icons/create_page.svg',
                      color:
                          _selectedIndex == 2 ? Color(0xFF6F2DA8) : Colors.grey,
                    ),
                  ),
                  label: 'Create',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                      'assets/icons/reward_page.svg',
                      color:
                          _selectedIndex == 3 ? Color(0xFF6F2DA8) : Colors.grey,
                    ),
                  ),
                  label: 'Reward',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                      'assets/icons/setting_page.svg',
                      color:
                          _selectedIndex == 4 ? Color(0xFF6F2DA8) : Colors.grey,
                    ),
                  ),
                  label: 'Setting',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (int index) {
                if (index == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateActivityUserPage()));
                  index = 0;
                }
                if (index == 4) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OptionPage()));
                  index = 0;
                }

                setState(() {
                  _selectedIndex = index;
                });
              }),
        ),
      ),
    );
  }
}

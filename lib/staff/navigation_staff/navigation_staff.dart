import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/staff/navigation_staff/staff_status.dart';
import 'package:quest_2/styles/size.dart';

import '../home_staff.dart';
import '../options_staff.dart';

class NavigationStaff extends StatefulWidget {
  NavigationStaff({Key? key}) : super(key: key);

  @override
  State<NavigationStaff> createState() => _NavigationStaffState();
}

class _NavigationStaffState extends State<NavigationStaff> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    StaffHomePage(),
    // Text(
    //   'Home Staff',
    //   style: optionStyle,
    // ),
    Text(
      '2',
      style: optionStyle,
    ),
    // Text(
    //   '3',
    //   style: optionStyle,
    // ),
    // Text(
    //   '4',
    //   style: optionStyle,
    // ),
    // Text(
    //   '5',
    //   style: optionStyle,
    // ),
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
            StatusStaff(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: Color(0xFFf0eff5),
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                // icon: Icon(Icons.home),
                icon: Container(
                  height: 28,
                  width: 28,
                  child: SvgPicture.asset(
                    'assets/icons/activity_active.svg',
                    color:
                        _selectedIndex == 0 ? Color(0xFF6F2DA8) : Colors.black,
                  ),
                ),
                label: 'Active',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 28,
                  width: 28,
                  child: SvgPicture.asset(
                    'assets/icons/setting_page.svg',
                    color:
                        _selectedIndex == 4 ? Color(0xFF6F2DA8) : Colors.black,
                  ),
                ),
                label: 'Setting',
              ),
            ],
            currentIndex: _selectedIndex,
            // selectedItemColor: Color(0xFF307BF6),
            onTap: (int index) {
              if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OptionsStaffPage()));
                index = 0;
              }
              // if (index == 2) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => CreateActivityUserPage()));
              //   index = 0;
              // }

              // if (index == 3) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => RewardUserBrowsePage()));
              //   index = 0;
              // }
              // if (index == 4) {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => OptionPage()));
              //   index = 0;
              // }

              setState(() {
                _selectedIndex = index;
              });
            }),
      ),
    );
  }
}

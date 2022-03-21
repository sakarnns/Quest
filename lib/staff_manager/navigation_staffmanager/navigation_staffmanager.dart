import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/staff_manager/create_staff_staffmanager.dart';
import 'package:quest_2/staff_manager/navigation_staffmanager/staffmanager_status.dart';
import 'package:quest_2/styles/size.dart';

import '../create_activity_staffmanager.dart';
import '../home_staffmanager.dart';
import '../options_staffmanager.dart';
import '../pending_staffmanager.dart';

class NavigationStaffmanager extends StatefulWidget {
  NavigationStaffmanager({Key? key}) : super(key: key);

  @override
  State<NavigationStaffmanager> createState() => _NavigationStaffmanagerState();
}

class _NavigationStaffmanagerState extends State<NavigationStaffmanager> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    StaffManagerHomePage(),
    StaffManagerPendingPage(),
    Text(
      '',
      style: optionStyle,
    ),
    Text(
      '',
      style: optionStyle,
    ),
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
            StatusStaffmanager(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: Color(0xFFf0eff5),
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            fixedColor: Color(0xFF6F2DA8),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                // icon: Icon(Icons.home),
                icon: Container(
                  height: 28,
                  width: 28,
                  child: SvgPicture.asset(
                    'assets/icons/activity_active.svg',
                    color:
                        _selectedIndex == 0 ? Color(0xFF6F2DA8) : Colors.grey,
                  ),
                ),
                label: 'Active',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 28,
                  width: 28,
                  child: SvgPicture.asset(
                    'assets/icons/activity_pending.svg',
                    color:
                        _selectedIndex == 1 ? Color(0xFF6F2DA8) : Colors.grey,
                  ),
                ),
                label: 'Pending',
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
                    'assets/icons/create_staff.svg',
                    color:
                        _selectedIndex == 3 ? Color(0xFF6F2DA8) : Colors.grey,
                  ),
                ),
                label: 'Create Staff',
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
            // selectedItemColor: Color(0xFF307BF6),
            onTap: (int index) {
              // if (index == 1) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => ActivityUserBrowsePage()));
              //   index = 0;
              // }
              if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateActivityStaffManagerPage()));
                index = 0;
              }

              if (index == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateStaffManagerPage()));
                index = 0;
              }

              if (index == 4) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OptionsStaffManagerPage()));
                index = 0;
              }

              setState(() {
                _selectedIndex = index;
              });
            }),
      ),
    );
  }
}

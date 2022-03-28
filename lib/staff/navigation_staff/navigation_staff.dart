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
            StatusStaff(),
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
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              fixedColor: Color(0xFF6F2DA8),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
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
                if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OptionsStaffPage()));
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

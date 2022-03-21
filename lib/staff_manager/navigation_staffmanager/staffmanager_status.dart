import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:quest_2/data/staffdata.dart';
import 'package:quest_2/models/staff.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusStaffmanager extends StatefulWidget {
  StatusStaffmanager({Key? key}) : super(key: key);

  @override
  State<StatusStaffmanager> createState() => _StatusStaffmanagerState();
}

Future setstaffStatus() async {
  print("set staff status activated!");
  final prefs = await SharedPreferences.getInstance();
  final val = prefs.getString('token');
  print(val);
  String urlProfile =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/staff_main_page";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };
  var resProfile = await http.get(
    Uri.parse(urlProfile),
    headers: requestHeaders,
  );

  print(resProfile.statusCode);
  print(resProfile.body);
  if (resProfile.statusCode == 200) {
    print(json.decode(resProfile.body));
    StaffData.staffProfile =
        StaffProfile.fromJson(json.decode(resProfile.body));
    // print(UserData.userProfile!.image);
  }
}

class _StatusStaffmanagerState extends State<StatusStaffmanager> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    print("fetch 1 ");
    await setstaffStatus().then((value) => setState(() {}));
    print("fetch 2 event");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 6.5,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFf0eff5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                height: MediaQuery.of(context).size.height / 7.6,
              ),
              // Container(
              //   padding: const EdgeInsets.all(4.0),
              //   alignment: Alignment.bottomLeft,
              //   height: MediaQuery.of(context).size.height / 8,
              //   width: MediaQuery.of(context).size.width / 3.2,
              //   // color: Colors.blue,
              //   margin: EdgeInsets.only(left: 20),
              //   // height: MediaQuery.of(context).size.height / ,
              //   // child:
              //   // FittedBox(
              //   // fit: BoxFit.fill,
              //   child: Text(
              //     "${StaffData.staffProfile?.username}",
              //     maxLines: 1,
              //     overflow: TextOverflow.ellipsis,
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              //     // ),
              //   ),
              // ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  // decoration: new BoxDecoration(
                  //   color: Colors.yellow,
                  // ),
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.bottomLeft,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(left: 8, bottom: 32),
                  child: Text(
                    "${StaffData.staffProfile?.username}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // decoration: new BoxDecoration(
                  //   color: Colors.blue,
                  // ),
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.bottomRight,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(right: 8),
                  child: Text(
                    "${StaffData.staffProfile?.company}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // decoration: new BoxDecoration(
                  //   color: Colors.green,
                  // ),
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.bottomRight,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 2.8,
                  margin: EdgeInsets.only(right: 8, bottom: 50),
                  child: Text(
                    "Staff Manager",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F2DA8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/data/staffhome.dart';
import 'package:quest_2/models/staff_home.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my_activty_pending_user.dart';

bool isLoading = true;
int? tokenexpire;

Future selectEventId(id) async {
  await setIdEvent(id);
}

setIdEvent(String selectevent) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('selecteventid', selectevent);
}

Future pendingdata() async {
  print("pending activity user activated!");
  final prefs = await SharedPreferences.getInstance();
  final val = prefs.getString('token');
  String urlProfile =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/user_pending_event";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };
  var res = await http.get(
    Uri.parse(urlProfile),
    headers: requestHeaders,
  );

  tokenexpire = res.statusCode;
  if (res.statusCode == 200) {
    List data = json.decode(res.body);
    pendingData.staffHome = data.map((p) => StaffHome.fromJson(p)).toList();
  }
}

class UserActivityPendingPage extends StatefulWidget {
  UserActivityPendingPage({Key? key}) : super(key: key);

  @override
  State<UserActivityPendingPage> createState() =>
      _UserActivityPendingPageState();
}

class _UserActivityPendingPageState extends State<UserActivityPendingPage> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1");
    await pendingdata().then((value) => setState(() {}));
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    isLoading = false;
    print("fetch 2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Pending Activity',
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF6F2DA8),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0.0,
        leading: BackButton(
          color: Color(0xFF6F2DA8),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width(context: context) / 50,
          ),
          // \/ Card pending  Activity \/
          child: isLoading != true
              ? Column(
                  children: [
                    SizedBox(
                      height: height(context: context) / 9,
                    ),
                    Container(
                        child: pendingData.staffHome.isEmpty
                            ? initiateFirst()
                            : pendingActivity())
                  ],
                )
              : Container(
                  height: 633,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(),
                      Text(
                        "LOADING",
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget initiateFirst() {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            // color: Color(0xFFEBEDF2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "There is no pending activity to show,\n  reject activity automatically delete.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget pendingActivity() {
    return Column(
      children: List.generate(
        pendingData.staffHome.length,
        (index) => InkWell(
          onTap: () {
            selectEventId(pendingData.staffHome[index].eventId);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyActivityDetailsPendingPage()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${pendingData.staffHome[index].eventImage}"), // Add Path image
                      fit: BoxFit.cover)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          pendingData.staffHome[index].eventName,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              Shadow(
                                blurRadius: 18.0,
                                color: Colors.white,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/icons/right_arrow_dense.svg',
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                        ), // use Spacer
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

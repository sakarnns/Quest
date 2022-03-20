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
import 'activity_details_staffmanager.dart';

bool isLoading = true;
int? tokenexpire;

Future selectEventId(id) async {
  await setIdEvent(id);
}

setIdEvent(String selectevent) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('selecteventid', selectevent);

  print(selectevent);
}

Future staffhome() async {
  print("staff manager home activated!");
  final prefs = await SharedPreferences.getInstance();
  final val = prefs.getString('token');
  // print(val);
  String urlProfile =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/staff_home";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };
  var res = await http.get(
    Uri.parse(urlProfile),
    headers: requestHeaders,
  );
  tokenexpire = res.statusCode;
  // print(res.statusCode);
  // print(res.body);

  if (res.statusCode == 200) {
    // print(json.decode(res.body));
    List data = json.decode(res.body);

    staffHomeData.staffHome = data.map((p) => StaffHome.fromJson(p)).toList();
    // print(UserData.userProfile!.image);
  }
}

class StaffManagerHomePage extends StatefulWidget {
  StaffManagerHomePage({Key? key}) : super(key: key);

  @override
  State<StaffManagerHomePage> createState() => _StaffManagerHomePageState();
}

class _StaffManagerHomePageState extends State<StaffManagerHomePage> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await staffhome().then((value) => setState(() {}));
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    isLoading = false;
    print("fetch 2 event");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width(context: context) / 50,
      ),
      // \/ Card Activity \/
      child: isLoading != true
          ? Column(
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      "Active Event",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context: context) / 100,
                ),
                staffHomeData.staffHome.isEmpty
                    ? initiateFirst()
                    : activeActivity()
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
    );
  }

  Widget initiateFirst() {
    return Column(
      children: [
        Container(
          height: 200,
          width: 370,
          decoration: BoxDecoration(
            // color: Color(0xFFEBEDF2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "There is no event active to show.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget activeActivity() {
    return Column(
      children: List.generate(
        staffHomeData.staffHome.length,
        (index) => InkWell(
          onTap: () {
            selectEventId(staffHomeData.staffHome[index].eventId);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ActivityDetailsStaffManagerPage()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${staffHomeData.staffHome[index].eventImage}"), // Add Path image
                      // image: AssetImage(
                      //     'assets/images/Beach_4.jpg'), // Add Path image
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
                          staffHomeData.staffHome[index].eventName,
                          style: TextStyle(
                            fontSize: 20,
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

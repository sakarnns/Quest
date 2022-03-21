import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/userdata.dart';
import 'package:quest_2/models/user.dart';
import 'package:quest_2/user/transaction_user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StatusUser extends StatefulWidget {
  StatusUser({Key? key}) : super(key: key);

  @override
  State<StatusUser> createState() => _StatusUserState();
}

class _StatusUserState extends State<StatusUser> {
  Future setuserStatus() async {
    print("set user status activated!");
    final prefs = await SharedPreferences.getInstance();

    final val = prefs.getString('token');
    String urlProfile =
        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/profile";
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': (val) as String
    };
    var resProfile = await http.get(
      Uri.parse(urlProfile),
      headers: requestHeaders,
    );
    if (resProfile.statusCode == 200) {
      print(json.decode(resProfile.body));
      UserData.userProfile = UserProfile.fromJson(json.decode(resProfile.body));
      // print(UserData.userProfile!.image);
    }
  }

  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    await setuserStatus();
    setState(() {});
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
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  // decoration: new BoxDecoration(
                  //   color: Colors.yellow,
                  // ),
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.bottomLeft,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 2.8,
                  margin: EdgeInsets.only(left: 8, bottom: 32),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogTransactionPage()));
                    },
                    child: Text(
                      "${UserData.userProfile?.username}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  // decoration: new BoxDecoration(
                  //   color: Colors.blue,
                  // ),
                  padding: const EdgeInsets.all(4.0),
                  alignment: Alignment.bottomRight,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 2.8,
                  margin: EdgeInsets.only(right: 8, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "null*",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        " T-points",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6F2DA8),
                        ),
                      ),
                    ],
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogTransactionPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${UserData.userProfile?.points}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          " points",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF6F2DA8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 9,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFf0eff5), shape: BoxShape.circle),
                          height: MediaQuery.of(context).size.height / 9,
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: UserData.userProfile!.image != "0"
                                  ? imageprofileuser()
                                  : imageprofiletemp()),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget imageprofileuser() {
    return Image(
      image: NetworkImage(
          "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${UserData.userProfile!.image}"),
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width / 4.5,
      fit: BoxFit.cover,
    );
  }

  Widget imageprofiletemp() {
    return Image(
      image: AssetImage('assets/images/profile_temp.jpg'),
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width / 4.5,
      fit: BoxFit.cover,
    );
  }
}

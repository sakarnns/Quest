import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/rewarddetail.dart';
import 'package:quest_2/data/userdata.dart';
import 'package:quest_2/models/reward_detail.dart';
import 'package:quest_2/models/user.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'confirm_reward_user.dart';

bool isLoading = true;
int? tokenexpire;

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
    // print(json.decode(resProfile.body));
    UserData.userProfile = UserProfile.fromJson(json.decode(resProfile.body));
    // print(UserData.userProfile!.image);
  }
}

Future getrewarddetail() async {
  print("rewarddetails activate!");
  final prefs = await SharedPreferences.getInstance();

  final rewardid = prefs.getString('selectrewardid');
  final val = prefs.getString('token');
  // print("-------------==========");
  // print(rewardid);
  // print("-------------==========");
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/reward_detail/$rewardid";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };

  var jsonResponse;
  var res = await http.get(
    Uri.parse(url),
    headers: requestHeaders,
  );
  tokenexpire = res.statusCode;

  print(res.statusCode);

  if (res.statusCode == 200) {
    // print(json.decode(res.body));
    rewardDetailData.rewardDetail =
        RewardDetail.fromJson(json.decode(res.body));
    jsonResponse = json.decode(res.body);
    return jsonResponse;
  }
}

class RewardDetailsPage extends StatefulWidget {
  RewardDetailsPage({Key? key}) : super(key: key);

  @override
  State<RewardDetailsPage> createState() => _RewardDetailsPageState();
}

class _RewardDetailsPageState extends State<RewardDetailsPage> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await getrewarddetail();
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    isLoading = false;
    setState(() {});
    print("fetch 2 ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Reward', style: TextStyle(fontSize: 28, color: Colors.black)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
        // backgroundColor: Colors.transparent,
        backgroundColor: Color(0xFFEBEDF2),
        elevation: 0.0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading != true
          ? (rewardDetailData.rewardDetail != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width(context: context) / 20,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height(context: context) / 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              rewardDetailData.rewardDetail!.rewardName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height(context: context) / 100,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: new BorderRadius.only(
                                // bottomLeft: const Radius.circular(8.0),
                                // bottomRight: const Radius.circular(8.0),
                                topLeft: const Radius.circular(8.0),
                                topRight: const Radius.circular(8.0),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${rewardDetailData.rewardDetail!.rewardImage}"),
                                  fit: BoxFit.cover)),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 16.0, top: 8.0, right: 16.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFFE5E5EA),
                                  borderRadius: new BorderRadius.only(
                                    bottomLeft: const Radius.circular(8.0),
                                    bottomRight: const Radius.circular(8.0),
                                  )),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 64,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Valid Date ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        rewardDetailData
                                            .rewardDetail!.rewardEndDate
                                            .toIso8601String()
                                            .replaceAll("T", " ")
                                            .substring(0, 19),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Color(0xFFD1D1D6),
                                    thickness: 1,
                                    endIndent: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Remain ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        rewardDetailData
                                            .rewardDetail!.rewardRemain
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height(context: context) / 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFE5E5EA),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(8.0))),
                          child: Row(
                            children: [
                              Text(
                                rewardDetailData.rewardDetail!.rewardPrice
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              Text(
                                '  Point',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height(context: context) / 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Reward Detail",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 172,
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  bottom: 16.0,
                                  top: 16.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFFE5E5EA),
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(8.0))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    rewardDetailData.rewardDetail!.rewardDetail,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height(context: context) / 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: selectButton()),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 633,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(),
                      Text(
                        "TOKEN HAD EXPIRE",
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ))
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

  Widget selectButton() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: UserData.userProfile!.points! >=
              rewardDetailData.rewardDetail!.rewardPrice
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmRewardUserPage()));
              setuserStatus();
            }
          : null,
      child: UserData.userProfile!.points! >=
              rewardDetailData.rewardDetail!.rewardPrice
          ? Text(
              "Select",
              style: TextStyle(color: Colors.white, fontSize: 16),
            )
          : Text(
              "Insufficient Points",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/data/homebrowse.dart';
import 'package:quest_2/styles/size.dart';
import '../reward_details_user.dart';
import '../timeout.dart';
import 'home_user_interestedactivity.dart';
import 'home_user_joinedactivity.dart';
import 'home_user_myactivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:quest_2/models/home_data.dart';
import 'dart:convert';

bool isLoading = true;
int? tokenexpire;

Future homebrowse() async {
  print("homebrowse activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/home";
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
    List data = json.decode(res.body);
    getHomeData.homeData = data.map((p) => HomeData.fromJson(p)).toList();
    // print("Home Data ${getHomeData.homeData}");
    jsonResponse = json.decode(res.body);
    // print("Response status: ${res.statusCode}");
    return jsonResponse;
  }
}

Future selectRewardId(id) async {
  await setIdReward(id);
}

setIdReward(String selectreward) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('selectrewardid', selectreward);

  // print(selectreward);
}

class UserHomePage extends StatefulWidget {
  UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await homebrowse();
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width(context: context) / 50,
      ),
      // \/ Card Activity \/
      child: isLoading != true
          ? (getHomeData.homeData.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Text(
                          "Event",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context: context) / 100,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyActivityUserPage()));
                        print("My Activity");
                      },
                      child: Container(
                        height: height(context: context) / 9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/ActivityBanner_1.jpg'), // Add Path image
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
                                    "My Activity",
                                    style: TextStyle(
                                      fontSize: 24,
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
                    SizedBox(
                      height: height(context: context) / 50,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    JoinedActivityUserPage()));
                        print("into Joined Activty");
                      },
                      child: Container(
                        height: height(context: context) / 9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/ActivityBanner_2.jpg'), // Add Path image
                                fit: BoxFit.cover)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height(context: context) / 1,
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
                                    "Joined Activty",
                                    style: TextStyle(
                                      fontSize: 24,
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
                    SizedBox(
                      height: height(context: context) / 50,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InterestedActivityUserPage()));
                        print("into Interested Activty");
                      },
                      child: Container(
                        height: height(context: context) / 9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            // color: Color(0xFFdcdfe6),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/ActivityBanner_3.jpg'), // Add Path image
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
                                    "Interested Activty",
                                    style: TextStyle(
                                      fontSize: 24,
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
                    SizedBox(
                      height: height(context: context) / 100,
                    ),
                    // \/ Reward Show \/
                    Row(
                      children: <Widget>[
                        Text(
                          "Reward",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context: context) / 100,
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal, child: rewardShow()),
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
                        "SOMETHING WRONG.isEmpty",
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

  Widget rewardShow() {
    return Row(
      children: List.generate(
        getHomeData.homeData.length,
        (index) => InkWell(
          onTap: () {
            selectRewardId(getHomeData.homeData[index].id);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RewardDetailsPage()));
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: height(context: context) * 0.26,
            width: width(context: context) * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                    image: NetworkImage(
                        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${getHomeData.homeData[index].rewardImage}"), // Add Path image
                    fit: BoxFit.cover)),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 24.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(8.0),
                      bottomRight: const Radius.circular(8.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.038,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            getHomeData.homeData[index].rewardName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Text(
                            getHomeData.homeData[index].rewardPrice.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            ' Point',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

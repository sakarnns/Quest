import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/rewardall.dart';
import 'package:quest_2/models/reward_all.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/reward_details_user.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoading = true;
int? tokenexpire;

Future getrewardall() async {
  print("rewardbrowse activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/reward_all";
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
  // print(res.statusCode);

  if (res.statusCode == 200) {
    // print(json.decode(res.body));
    // print("yeah");

    List data = json.decode(res.body);

    rewardAllData.rewardAll = data.map((p) => RewardAll.fromJson(p)).toList();

    // print("eventBrowseData.eventBrowse ${rewardAllData.rewardAll}");
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

class RewardUserBrowsePage extends StatefulWidget {
  RewardUserBrowsePage({Key? key}) : super(key: key);

  @override
  _RewardUserBrowsePageState createState() => _RewardUserBrowsePageState();
}

List<RewardAll>? _foundReward;

class _RewardUserBrowsePageState extends State<RewardUserBrowsePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    await getrewardall();
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    isLoading = false;
    setState(() {});
  }

  void _runFilter(String enteredKeyword) {
    List<RewardAll> results;
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = rewardAllData.rewardAll;
    } else {
      results = rewardAllData.rewardAll
          .where((reward) => reward.rewardName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(
      () {
        _foundReward = results;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width(context: context) / 50,
      ),
      child: isLoading != true
          ? (rewardAllData.rewardAll.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: searchRewardAll(),
                        ),
                      ],
                    ),
                    _foundReward != null
                        ? rewardList(_foundReward!)
                        : rewardList(rewardAllData.rewardAll)
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

  Widget searchRewardAll() {
    return TextFormField(
        controller: _searchController,
        // textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          focusedBorder: outlineInputBorder(),
          border: outlineInputBorder(),
          contentPadding: EdgeInsets.all(8.0),
          hintText: 'Find your best reward...',
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF6F2DA8),
          ),
        ),
        onChanged: (value) => _runFilter(value));
  }

  Widget rewardList(List<RewardAll> reward) {
    return Column(
      children: List.generate(
        reward.length,
        (index) => InkWell(
          onTap: () {
            selectRewardId(reward[index].id);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RewardDetailsPage()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                    image: NetworkImage(
                        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${reward[index].rewardImage}"), // Add Path image
                    // image: AssetImage('assets/images/Device_1.jpg'),
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
                      )),
                  width: MediaQuery.of(context).size.width,
                  height: 32,
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
                            reward[index].rewardName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Text(
                            reward[index].rewardPrice.toString(),
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

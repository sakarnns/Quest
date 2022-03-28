import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/interestedevent.dart';
import 'package:quest_2/models/interested_event.dart';
import 'package:quest_2/styles/size.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../activty_home_user.dart';
import 'dart:convert';
import '../activity_details_user.dart';

bool isLoading = true;

Future interestedbrowse() async {
  print("activitybrowse activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/event_interested_all";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };

  var jsonResponse;
  var res = await http.get(
    Uri.parse(url),
    headers: requestHeaders,
  );

  print(res.statusCode);

  if (res.statusCode == 200) {
    List data = json.decode(res.body);
    interestedEventData.interestedEvent =
        data.map((p) => InterestedEvent.fromJson(p)).toList();
    print("Interested ${interestedEventData.interestedEvent}");
    jsonResponse = json.decode(res.body);
    return jsonResponse;
  }
}

class InterestedActivityUserPage extends StatefulWidget {
  InterestedActivityUserPage({Key? key}) : super(key: key);

  @override
  State<InterestedActivityUserPage> createState() =>
      _InterestedActivityUserPageState();
}

class _InterestedActivityUserPageState
    extends State<InterestedActivityUserPage> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await interestedbrowse();
    isLoading = false;
    setState(() {});
    print("fetch 2 ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Interested Activity',
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
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: height(context: context) / 9,
                ),
                isLoading != true
                    ? (interestedEventData.interestedEvent.isEmpty
                        ? initiateThird()
                        : interestedActivity())
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
                SizedBox(
                  height: height(context: context) / 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget initiateThird() {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "There is no activity in the list.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget interestedActivity() {
    return Column(
      children: List.generate(
        interestedEventData.interestedEvent.length,
        (index) => InkWell(
          onTap: () {
            selectEventId(interestedEventData.interestedEvent[index].id);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ActivityDetailsPage()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                    image: NetworkImage(
                        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${interestedEventData.interestedEvent[index].eventImage}"), // Add Path image
                    // image: AssetImage('assets/images/Beach_3.jpg'),
                    fit: BoxFit.cover)),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(8.0),
                      bottomRight: const Radius.circular(8.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 56,
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
                            interestedEventData
                                .interestedEvent[index].eventType,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Text(
                            interestedEventData
                                .interestedEvent[index].eventPoints
                                .toString(),
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
                      Text(
                        interestedEventData.interestedEvent[index].eventName,
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )
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

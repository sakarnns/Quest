import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/joinedevent.dart';
import 'package:quest_2/models/joined_event.dart';
import 'package:quest_2/styles/size.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../activty_home_user.dart';
import 'dart:convert';
import '../activity_details_user.dart';

bool isLoading = true;
Future getjoinedevent() async {
  print("activityjoined activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/event_join_all";
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
    print(json.decode(res.body));
    print("yeah");

    List data = json.decode(res.body);

    joinedEventData.joinedEvent =
        data.map((p) => JoinedEvent.fromJson(p)).toList();

    print("eventBrowseData.eventBrowse ${joinedEventData.joinedEvent}");
    jsonResponse = json.decode(res.body);
    print("Response status: ${res.statusCode}");

    return jsonResponse;
  }
}

class JoinedActivityUserPage extends StatefulWidget {
  JoinedActivityUserPage({Key? key}) : super(key: key);

  @override
  State<JoinedActivityUserPage> createState() => _JoinedActivityUserPageState();
}

class _JoinedActivityUserPageState extends State<JoinedActivityUserPage> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await getjoinedevent();
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
          'Joined Activity',
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF6F2DA8),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
        // backgroundColor: Color(0xFFEBEDF2),
        // backgroundColor: Colors.transparent,
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
          child: Column(
            children: [
              SizedBox(
                height: height(context: context) / 9,
              ),
              isLoading != true
                  ? (joinedEventData.joinedEvent.isEmpty
                      ? initiateSecond()
                      : joinedActivity())
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
    );
  }

  Widget initiateSecond() {
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
                    "There is no joined activity to show.",
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

  Widget joinedActivity() {
    return Column(
      children: List.generate(
        joinedEventData.joinedEvent.length,
        (index) => InkWell(
          onTap: () {
            selectEventId(joinedEventData.joinedEvent[index].eventId);
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
                        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${joinedEventData.joinedEvent[index].eventImage}"), // Add Path image
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
                            joinedEventData.joinedEvent[index].eventType,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Text(
                            joinedEventData.joinedEvent[index].eventPoints
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
                        joinedEventData.joinedEvent[index].eventName,
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

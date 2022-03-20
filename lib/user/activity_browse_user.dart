import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/eventall.dart';
import 'package:quest_2/models/event_all.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activity_details_user.dart';

bool isLoading = true;
int? tokenexpire;

Future geteventall() async {
  print("activityBrowse activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/event_all";
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

    eventAllData.eventAll = data.map((p) => EventAll.fromJson(p)).toList();
    // print(res.body);
    // print("eventBrowseData.eventBrowse ${rewardAllData.rewardAll}");
    jsonResponse = json.decode(res.body);
    // print("Response status: ${res.statusCode}");

    return jsonResponse;
  }
}

Future selectEventId(id) async {
  await setIdEvent(id);
}

setIdEvent(String selecevent) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('selecteventid', selecevent);

  // print(selectreward);
}

class ActivityUserBrowsePage extends StatefulWidget {
  ActivityUserBrowsePage({Key? key}) : super(key: key);

  @override
  _ActivityUserBrowsePageState createState() => _ActivityUserBrowsePageState();
}

List<EventAll>? _foundEvent;

class _ActivityUserBrowsePageState extends State<ActivityUserBrowsePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    // _runFilter("");
    await geteventall().then((value) => setState(() {}));
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    isLoading = false;
    print("fetch 2 event");
  }

  void _runFilter(String enteredKeyword) {
    print(enteredKeyword);
    List<EventAll> results;
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = eventAllData.eventAll;
    } else {
      results = eventAllData.eventAll
          .where((event) =>
              (event.eventName
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase())) ||
              (event.eventType
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase())))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive

    }
    // Refresh the UI
    setState(
      () {
        _foundEvent = results;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Activity',
              style: TextStyle(fontSize: 28, color: Colors.black)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
          backgroundColor: Color(0xFFEBEDF2),
          // backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: BackButton(
            color: Colors.black,
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
            child: isLoading != true
                ? (eventAllData.eventAll.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: height(context: context) / 50,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: searchEventAll(),
                              ),
                            ],
                          ),
                          _foundEvent != null
                              ? eventList(_foundEvent!)
                              : eventList(eventAllData.eventAll),
                          SizedBox(
                            height: height(context: context) / 10,
                          ),
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
          ),
        ),
      ),
    );
  }

  Widget searchEventAll() {
    return TextFormField(
      controller: _searchController,
      // textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        contentPadding: EdgeInsets.all(8.0),
        hintText: 'Find your best activity...',
        prefixIcon: Icon(Icons.search),
        //  onFieldSubmitted: (){},
        // suffixIcon: IconButton(
        //   icon: Icon(Icons.clear),
        //   onPressed: () {
        //     _searchController.clear();
        //   },
        // ),
      ),
      onChanged: (value) => _runFilter(value),
    );
  }

  Widget eventList(List<EventAll> event) {
    return Column(
      children: List.generate(
        event.length,
        (index) => InkWell(
          onTap: () {
            selectEventId(event[index].id);
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
                        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${event[index].eventImage}"), // Add Path image
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
                            event[index].eventType,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Text(
                            event[index].eventPoints.toString(),
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
                        event[index].eventName,
                        style: TextStyle(fontSize: 18, color: Colors.white),
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

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/data/eventbrowse.dart';
import 'package:quest_2/models/event_browse.dart';
import 'package:quest_2/styles/size.dart';
import 'package:http/http.dart' as http;
import 'package:quest_2/user/activity_details_user.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activity_browse_user.dart';

bool isLoading = true;
int? tokenexpire;

Future activitybrowse() async {
  print("activitybrowse activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/activity_browse";
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

    eventBrowseData.eventBrowse = EventBrowse.fromJson(jsonDecode(res.body));

    // print("eventBrowseData.eventBrowse ${eventBrowseData.eventBrowse}");

    jsonResponse = json.decode(res.body);
    // print("Response status; ${res.statusCode}");
    return jsonResponse;
  } else {}
}

Future selectEventId(id) async {
  await setIdEvent(id);
}

setIdEvent(String selectevent) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('selecteventid', selectevent);

  // print(selectevent);
}

class ActivityUserHomePage extends StatefulWidget {
  ActivityUserHomePage({Key? key}) : super(key: key);

  @override
  State<ActivityUserHomePage> createState() => _ActivityUserHomePageState();
}

class _ActivityUserHomePageState extends State<ActivityUserHomePage> {
  @override
  void initState() {
    fectc();

    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await activitybrowse();
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
      // \/ Ads Area \/
      child: isLoading != true
          ? (eventBrowseData.eventBrowse != null
              ? Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Text(
                          "Featured",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context: context) / 100,
                    ),
                    Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 190,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 1200),
                          viewportFraction: 0.8,
                        ),
                        items: List.generate(
                            eventBrowseData
                                    .eventBrowse?.eventsponsered5.length ??
                                0,
                            (index) => InkWell(
                                  onTap: () {
                                    selectEventId(eventBrowseData.eventBrowse
                                        ?.eventsponsered5[index].id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ActivityDetailsPage()));
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${eventBrowseData.eventBrowse?.eventsponsered5[index].eventImage}"), // Add Path image
                                          fit: BoxFit.cover),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 16.0,
                                            top: 24.0,
                                          ),
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.3),
                                              borderRadius:
                                                  new BorderRadius.only(
                                                bottomLeft:
                                                    const Radius.circular(8.0),
                                                bottomRight:
                                                    const Radius.circular(8.0),
                                              )),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 56,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    eventBrowseData
                                                            .eventBrowse
                                                            ?.eventsponsered5[
                                                                index]
                                                            .eventType ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    eventBrowseData
                                                            .eventBrowse
                                                            ?.eventsponsered5[
                                                                index]
                                                            .eventPoints
                                                            .toString() ??
                                                        '',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    ' Point',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                eventBrowseData
                                                        .eventBrowse
                                                        ?.eventsponsered5[index]
                                                        .eventName ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ),
                    SizedBox(
                      height: height(context: context) / 100,
                    ),
                    // \/ Recommend \/
                    Row(
                      children: <Widget>[
                        Text(
                          "Recommend",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context: context) / 100,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          eventBrowseData.eventBrowse?.eventrcm5.length ?? 0,
                          (index) => InkWell(
                            onTap: () {
                              selectEventId(eventBrowseData
                                  .eventBrowse?.eventrcm5[index].id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ActivityDetailsPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${eventBrowseData.eventBrowse?.eventrcm5[index].eventImage}"), // Add Path image
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
                                          bottomLeft:
                                              const Radius.circular(8.0),
                                          bottomRight:
                                              const Radius.circular(8.0),
                                        )),
                                    width: MediaQuery.of(context).size.width,
                                    height: 56,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              eventBrowseData
                                                      .eventBrowse
                                                      ?.eventrcm5[index]
                                                      .eventType ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              eventBrowseData
                                                      .eventBrowse
                                                      ?.eventrcm5[index]
                                                      .eventPoints
                                                      .toString() ??
                                                  "",
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
                                          eventBrowseData
                                                  .eventBrowse
                                                  ?.eventrcm5[index]
                                                  .eventName ??
                                              "",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height(context: context) / 100,
                    ),
                    // \/ Activity \/
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ActivityUserBrowsePage()));
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Activity",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Text(
                              "See more",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6F2DA8),
                              ),
                            ),
                            SizedBox(
                              width: width(context: context) / 100,
                            ),
                            SvgPicture.asset(
                                'assets/icons/forward_activity.svg',
                                color: Color(0xFF6F2DA8),
                                fit: BoxFit.cover), // use Spacer
                          ],
                        )),
                    SizedBox(
                      height: height(context: context) / 100,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          eventBrowseData.eventBrowse?.event5.length ?? 0,
                          (index) => InkWell(
                            onTap: () {
                              selectEventId(eventBrowseData
                                  .eventBrowse?.event5[index].id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ActivityDetailsPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${eventBrowseData.eventBrowse?.event5[index].eventImage}"), // Add Path image
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
                                          bottomLeft:
                                              const Radius.circular(8.0),
                                          bottomRight:
                                              const Radius.circular(8.0),
                                        )),
                                    width: MediaQuery.of(context).size.width,
                                    height: 56,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              eventBrowseData
                                                      .eventBrowse
                                                      ?.event5[index]
                                                      .eventType ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              eventBrowseData
                                                      .eventBrowse
                                                      ?.event5[index]
                                                      .eventPoints
                                                      .toString() ??
                                                  '',
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
                                          eventBrowseData.eventBrowse
                                                  ?.event5[index].eventName ??
                                              "",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/eventdetail.dart';
import 'package:quest_2/models/event_detail.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoading = true;
int? tokenexpire;

Future getactivitydetail() async {
  print("activityDetail Staffmanager activate!");
  final prefs = await SharedPreferences.getInstance();

  final eventid = prefs.getString('selecteventid');
  final val = prefs.getString('token');
  print("-------------==========");
  print(eventid);
  print("-------------==========");
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/event_detail/$eventid";
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
    print(json.decode(res.body));
    eventDetailData.eventDetail = EventDetail.fromJson(json.decode(res.body));
    jsonResponse = json.decode(res.body);
    return jsonResponse;
  }
}

class ActivityDetailsStaffManagerNobtnPage extends StatefulWidget {
  ActivityDetailsStaffManagerNobtnPage({Key? key}) : super(key: key);

  @override
  State<ActivityDetailsStaffManagerNobtnPage> createState() =>
      _ActivityDetailsStaffManagerNobtnPageState();
}

class _ActivityDetailsStaffManagerNobtnPageState
    extends State<ActivityDetailsStaffManagerNobtnPage> {
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await getactivitydetail();
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Event',
              style: TextStyle(fontSize: 32, color: Colors.black)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
          backgroundColor: Color(0xFFEBEDF2),
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
              horizontal: width(context: context) / 20,
            ),
            child: isLoading != true
                ? staffmanagerDetailAreanobtn()
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

  Widget staffmanagerDetailAreanobtn() {
    return Column(
      children: [
/*=="Event Name"==============================================================*/
        SizedBox(
          height: height(context: context) / 100,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [interestButton()],
        // ),
        SizedBox(
          height: height(context: context) / 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Event Name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventDetailData.eventDetail!.eventName,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Organizer."========================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Event Organizer",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventDetailData.eventDetail!.eventPublisher,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Start Date"========================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Event Start Date",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventDetailData.eventDetail!.eventStartDate,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Start Time"========================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Event Start Time",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventDetailData.eventDetail!.eventStartTime,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event End Date"==========================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Event End Date",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventDetailData.eventDetail!.eventEndDate,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event End Time"==========================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Event End Time",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventDetailData.eventDetail!.eventEndTime,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Type"==============================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Event Type",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventDetailData.eventDetail!.eventType,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Participants Limit"======================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Participants Limit",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventDetailData.eventDetail!.participantLimit.toString(),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Participants Limit"======================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Participants Joined",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventDetailData.eventDetail!.eventJoined.toString(),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Piont/Participants"======================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Point/Participant",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${eventDetailData.eventDetail!.eventPoints} Points",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Require Tier-Points"======================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Require Tier-Points",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
          decoration: BoxDecoration(
              color: Color(0xFFE5E5EA),
              borderRadius: new BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${eventDetailData.eventDetail!.eventPoints} Points",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Detials"===========================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Event Detials",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              height: 172,
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
              decoration: BoxDecoration(
                  color: Color(0xFFE5E5EA),
                  borderRadius: new BorderRadius.all(Radius.circular(8.0))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    eventDetailData.eventDetail!.eventDetail,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
/*=="Photo about your Event."=================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Event Photo",
              style: TextStyle(
                // color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(
          height: height(context: context) / 100,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                  // image: AssetImage('assets/images/Beach_4.jpg')
                  image: NetworkImage(
                      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${eventDetailData.eventDetail?.eventImage}"),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          height: height(context: context) / 20,
        ),
      ],
    );
  }
}

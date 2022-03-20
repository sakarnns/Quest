import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/data/eventdetail.dart';
import 'package:quest_2/models/event_detail.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/scan_qr_user.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool isLoading = true;
bool isBTNActive = true;
int? tokenexpire;

Future getmyactivitydetail() async {
  print("activitybrowse activate!");
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
    // print(json.decode(res.body));
    eventDetailData.eventDetail = EventDetail.fromJson(json.decode(res.body));
    jsonResponse = json.decode(res.body);
    // print("Response status; ${res.statusCode}");
    // print("In");
    // print(eventDetailData.eventDetail?.eventCheckInterest);
    // print("j");
    // print(eventDetailData.eventDetail?.eventCheckJoin);
    // print("jd");
    // print(eventDetailData.eventDetail?.eventCheckJoined);
    // // print("Response status; ${res.body}");
    return jsonResponse;
  }
}

class MyActivityDetailsPage extends StatefulWidget {
  MyActivityDetailsPage({Key? key}) : super(key: key);

  @override
  State<MyActivityDetailsPage> createState() => _MyActivityDetailsPageState();
}

class _MyActivityDetailsPageState extends State<MyActivityDetailsPage> {
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    isBTNActive = true;
    print("fetch 1 ");
    await getmyactivitydetail();
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    print("fetch 2 ");
    isLoading = false;
    isBTNActive = false;
    // print(eventDetailData.eventDetail?.eventImage);
    setState(() {});
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
            title: Text('My Activity',
                style: TextStyle(fontSize: 32, color: Colors.black)),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16))),
            backgroundColor: Color(0xFFEBEDF2),
            elevation: 0.0,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: qrButton(),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width(context: context) / 20,
              ),
              child: Column(
                children: [
                  isLoading != true
                      ? myActivityarea()
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
                ],
              ),
            ),
          )),
    );
  }

  Widget myActivityarea() {
    return Column(
      children: [
/*=="Event Name"==============================================================*/
        SizedBox(
          height: height(context: context) / 100,
        ),
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
                "${eventDetailData.eventDetail?.eventName}",
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
                "${eventDetailData.eventDetail?.eventPublisher}",
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
                "${eventDetailData.eventDetail?.eventStartDate}",
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
                "${eventDetailData.eventDetail?.eventStartTime}",
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
                "${eventDetailData.eventDetail?.eventEndDate}",
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
                "${eventDetailData.eventDetail?.eventEndTime}",
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
                "${eventDetailData.eventDetail?.eventType}",
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
                "${eventDetailData.eventDetail?.participantLimit}",
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
                "${eventDetailData.eventDetail?.eventJoined}",
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
                "${eventDetailData.eventDetail?.eventPoints} Points",
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
                    //  rewardDetailData.rewardDetail!.rewardDetail,
                    '${eventDetailData.eventDetail?.eventDetail}',
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
                color: Colors.black,
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

  Widget qrButton() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Colors.black,
      minWidth: 30,
      // height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: isBTNActive != true
          ? () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanQrUserPage()));
            }
          : null,
      child: Container(
        child: SvgPicture.asset(
          'assets/icons/readerQR.svg',
          fit: BoxFit.fill,
          color: Colors.white,
        ),
        // child: Text(
        //   "Scan QR",
        //   style: TextStyle(color: Colors.white, fontSize: 16),
        // ),
      ),
    );
  }
}

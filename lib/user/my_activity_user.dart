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
  print("my activity user activate!");
  final prefs = await SharedPreferences.getInstance();

  final eventid = prefs.getString('selecteventid');
  final val = prefs.getString('token');
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

  if (res.statusCode == 200) {
    eventDetailData.eventDetail = EventDetail.fromJson(json.decode(res.body));
    jsonResponse = json.decode(res.body);
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
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        print("fetch 2 ");
        isLoading = false;
        isBTNActive = false;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'My Activity',
            style: TextStyle(
              fontSize: 24.0,
              color: Color(0xFF6F2DA8),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          backgroundColor: Colors.white.withOpacity(0.8),
          elevation: 0.0,
          leading: BackButton(
            color: Color(0xFF6F2DA8),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[qrScanButton()],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context: context) / 20,
            ),
            child: isLoading != true
                ? Column(
                    children: [
                      SizedBox(
                        height: height(context: context) / 8,
                      ),
                      SizedBox(
                        height: height(context: context) / 100,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(8.0))),
                        child: covereventarea(),
                      ),
                      SizedBox(
                        height: height(context: context) / 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFf0eff5),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(8.0))),
                        child: myActivityarea(),
                      ),
                      SizedBox(
                        height: height(context: context) / 20,
                      ),
                    ],
                  )
                : Container(
                    height: 800,
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

  Widget myActivityarea() {
    return Column(
      children: [
/*=="Event Name"==============================================================*/
        SizedBox(
          height: height(context: context) / 100,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventName}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Organizer."========================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Organizer",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventPublisher}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Start Date"========================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start Date",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventStartDate}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Start Time"========================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start Time",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventStartTime}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event End Date"==========================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "End Date",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventEndDate}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event End Time"==========================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "End Time",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventEndTime}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Type"==============================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Type",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventType}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Participants Limit"======================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Participants Limit",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.participantLimit}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Participants Limit"======================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Participants Joined",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventJoined}",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Piont/Participants"======================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Point/Participant",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventPoints} Points",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Tier-Points"======================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tier-Points",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventTierPoints} Tier-Points",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Event Detials"===========================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Detail",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${eventDetailData.eventDetail?.eventDetail}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
/*=="Location"===========================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Location",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${eventDetailData.eventDetail?.eventLocation}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget covereventarea() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
              image: NetworkImage(
                  "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${eventDetailData.eventDetail?.eventImage}"),
              fit: BoxFit.cover)),
    );
  }

  Widget qrScanButton() {
    return InkWell(
      onTap: isBTNActive != true
          ? () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanQrUserPage()));
            }
          : null,
      child: Container(
        width: 28,
        margin: const EdgeInsets.only(right: 16),
        child: SvgPicture.asset(
          'assets/icons/readerQR.svg',
          fit: BoxFit.contain,
          color: Color(0xFF6F2DA8),
        ),
      ),
    );
  }
}

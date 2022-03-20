import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/eventdetail.dart';
import 'package:quest_2/data/userdata.dart';
import 'package:quest_2/models/event_detail.dart';
import 'package:quest_2/styles/size.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'genertorqr_user.dart';

bool isLoading = true;

Future getactivitydetail() async {
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
    // print("Response status; ${res.body}");
    return jsonResponse;
  }
}

Future interestbutton(eventid) async {
  print("interest button activated!");
  final prefs = await SharedPreferences.getInstance();

  final eventid = prefs.getString('selecteventid');
  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/interest_button";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };
  Map body = {"event": eventid};

  print(jsonEncode(body));

  var jsonResponse;
  var res = await http.post(Uri.parse(url),
      body: jsonEncode(body), headers: requestHeaders);

  // print(res.statusCode);
  // print(res.body);

  if (res.statusCode == 200) {
    // print(json.decode(res.body));
    jsonResponse = json.decode(res.body);
    // print("response interest status");
    // print("Response status; ${res.statusCode}");
    // print("Response status; ${res.body}");
    return jsonResponse;
  }
}

Future joinbutton(eventid) async {
  print("interest button activated!");
  final prefs = await SharedPreferences.getInstance();

  final eventid = prefs.getString('selecteventid');
  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/user_join_event_button";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };
  Map body = {"event": eventid};

  var jsonResponse;
  var res = await http.post(Uri.parse(url),
      body: jsonEncode(body), headers: requestHeaders);

  print(res.statusCode);

  if (res.statusCode == 200) {
    // print(json.decode(res.body));
    eventDetailData.eventDetail = EventDetail.fromJson(json.decode(res.body));
    jsonResponse = json.decode(res.body);
    // print("response join status");
    // print("Response status; ${res.statusCode}");
    // print("Response status; ${res.body}");
    return jsonResponse;
  }
}

class ActivityDetailsPage extends StatefulWidget {
  ActivityDetailsPage({Key? key}) : super(key: key);

  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  // iterestButton
  bool isButtonInterestActive = true;
  bool isButtonInterestActiveAPI = true;

  // Join Button
  bool isButtonActive = true;
  bool isButtonActiveAPI = false;

  bool isButtonJoinChange = false;
  bool isButtonQRActive = false;

  void initState() {
    fectc();
    isButtonActive = true;
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await getactivitydetail();
    if (eventDetailData.eventDetail != null) {
      isButtonActiveAPI = eventDetailData.eventDetail!.eventCheckJoin;
      isButtonQRActive = eventDetailData.eventDetail!.eventCheckJoined;
      isButtonInterestActiveAPI =
          eventDetailData.eventDetail!.eventCheckInterest;
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
            title: Text('Activity',
                style: TextStyle(fontSize: 28, color: Colors.black)),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16))),
            // backgroundColor: Colors.transparent,
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
                child: interestButton(),
              )
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context: context) / 20,
            ),
            child: isLoading != true
                ? activityDetailArea()
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

  Widget activityDetailArea() {
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
                '${eventDetailData.eventDetail?.eventName}',
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
                '${eventDetailData.eventDetail?.eventPublisher}',
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
                '${eventDetailData.eventDetail?.eventEndDate}',
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
                '${eventDetailData.eventDetail?.eventType}',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Participants Quantity"===================================================*/
        SizedBox(
          height: height(context: context) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Participants Quantity",
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
                '${eventDetailData.eventDetail?.participantLimit} People',
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
                '${eventDetailData.eventDetail?.eventPoints}  Points',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Tier Points"======================================================*/
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
                '${eventDetailData.eventDetail?.eventPoints}  Tier points',
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
              "Event Details",
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
/*=="Function on Button"======================================================*/
        SizedBox(
          height: height(context: context) / 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(8.0), child: joinButton()),
            Padding(padding: EdgeInsets.all(8.0), child: qrButton()),
          ],
        ),
        SizedBox(
          height: height(context: context) / 20,
        ),
      ],
    );
  }

  Widget interestButton() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Colors.green,
      minWidth: 80,
      height: 30,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: ((isButtonInterestActive && !isButtonInterestActiveAPI) &&
              !(eventDetailData.eventDetail!.eventPublisher ==
                  UserData.userProfile!.username))
          ? () {
              print(isButtonInterestActiveAPI);
              print(isButtonInterestActiveAPI);
              setState(() {
                print('BRUH');
                print('${eventDetailData.eventDetail?.eventId}');
                interestbutton('${eventDetailData.eventDetail?.eventId}');
                isButtonInterestActive = false;
              });
            }
          : null,
      child: Text(
        (eventDetailData.eventDetail!.eventPublisher ==
                UserData.userProfile!.username)
            ? "owner"
            : isButtonInterestActive && !isButtonInterestActiveAPI
                ? "Interest"
                : "Interested",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget joinButton() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: (((isButtonActive && !isButtonActiveAPI) &&
                  !(eventDetailData.eventDetail!.eventPublisher ==
                      UserData.userProfile!.username)) &&
              !(eventDetailData.eventDetail!.participantLimit <=
                  eventDetailData.eventDetail!.eventJoined))
          ? () {
              setState(() {
                joinbutton('${eventDetailData.eventDetail?.eventId}');
                isButtonActive = false;
                isButtonJoinChange = true;
              });
            }
          : null,
      child: Text(
        (eventDetailData.eventDetail!.eventPublisher ==
                UserData.userProfile!.username)
            ? "owner"
            : eventDetailData.eventDetail!.participantLimit <=
                    eventDetailData.eventDetail!.eventJoined
                ? "Full"
                : isButtonActive && !isButtonActiveAPI
                    ? "Join"
                    : "Joined",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget qrButton() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: (isButtonJoinChange && !isButtonQRActive) ||
              (isButtonActiveAPI && !isButtonQRActive)
          ? () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GeneratorQRPage()));
            }
          : null,
      child: Text(
        ((isButtonJoinChange && !isButtonQRActive) ||
                (isButtonActiveAPI && !isButtonQRActive))
            ? "Participant's QR"
            : (eventDetailData.eventDetail!.eventPublisher ==
                    UserData.userProfile!.username)
                ? "owner"
                : eventDetailData.eventDetail!.eventCheckJoined == true
                    ? "Paticipanted"
                    : eventDetailData.eventDetail!.participantLimit <=
                            eventDetailData.eventDetail!.eventJoined
                        ? "Full"
                        : "Paticipant's QR",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

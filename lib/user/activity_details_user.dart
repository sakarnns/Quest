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
  print("activity details activate!");
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

  if (res.statusCode == 200) {
    eventDetailData.eventDetail = EventDetail.fromJson(json.decode(res.body));
    jsonResponse = json.decode(res.body);
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

  var jsonResponse;
  var res = await http.post(Uri.parse(url),
      body: jsonEncode(body), headers: requestHeaders);
  if (res.statusCode == 200) {
    jsonResponse = json.decode(res.body);
    return jsonResponse;
  }
}

Future joinbutton(eventid) async {
  print("join button activated!");
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

  if (res.statusCode == 200) {
    eventDetailData.eventDetail = EventDetail.fromJson(json.decode(res.body));
    jsonResponse = json.decode(res.body);
    return jsonResponse;
  }
}

class ActivityDetailsPage extends StatefulWidget {
  ActivityDetailsPage({Key? key}) : super(key: key);

  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  bool isButtonInterestActive = true;
  bool isButtonInterestActiveAPI = true;
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
    await getactivitydetail().then((value) => isLoading = true);
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text(
              'Activity',
              style: TextStyle(
                fontSize: 24,
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
                        child: activityDetailArea(),
                      ),
                      SizedBox(
                        height: height(context: context) / 100,
                      ),
                      Row(
                        children: [
                          Text(
                            "*When you join this activity. You can't unjoin.",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      functionbtn(),
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

  Widget activityDetailArea() {
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
                "${eventDetailData.eventDetail?.eventPoints}",
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
                "Tier-Points require",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${eventDetailData.eventDetail?.eventTierPoints}",
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
        SizedBox(
          height: height(context: context) / 100,
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
      color: Color(0xFF6F2DA8),
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: (((isButtonActive && !isButtonActiveAPI) &&
                  !(eventDetailData.eventDetail!.eventPublisher ==
                      UserData.userProfile!.username)) &&
              !(eventDetailData.eventDetail!.participantLimit <=
                  eventDetailData.eventDetail!.eventJoined) &&
              !(UserData.userProfile!.tier! <
                  eventDetailData.eventDetail!.eventTierPoints))
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
                : UserData.userProfile!.tier! <
                        eventDetailData.eventDetail!.eventTierPoints
                    ? "not enough t-point"
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
      color: Color(0xFF6F2DA8),
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

  Widget functionbtn() {
    return Column(
      children: [
        SizedBox(
          height: height(context: context) / 50,
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
}

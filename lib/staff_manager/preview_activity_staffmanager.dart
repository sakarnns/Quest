import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/staffdata.dart';
import 'package:quest_2/initiate_app/terms_condition.dart';
import 'package:quest_2/serviecs/activity_location_map_service.dart';
import 'package:quest_2/staff_manager/preview_act_staffmanager_done.dart';
import 'package:quest_2/styles/size.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'create_activity_staffmanager.dart';

Future createActivity(
    String eventname,
    String eventstartdate,
    String eventstarttime,
    String eventenddate,
    String eventendtime,
    String eventtype,
    String eventpaticipant,
    String eventpoint,
    String eventdetail,
    double la,
    double ln) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/sm_user_create_event";
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (token) as String
  };

  List<String> splitstartdata = eventstartdate.split(RegExp("/"));
  eventstartdate =
      splitstartdata[2] + "-" + splitstartdata[1] + "-" + splitstartdata[0];
  List<String> splitenddata = eventenddate.split(RegExp("/"));
  eventenddate =
      splitenddata[2] + "-" + splitenddata[1] + "-" + splitenddata[0];
  eventstarttime = eventstarttime + ":00";
  eventendtime = eventendtime + ":00";

  print("eventstartdate : " + eventstartdate);
  print("eventstarttime : " + eventstarttime);
  print("=============");
  print(eventdetail);
  print("=============");

  var request = http.MultipartRequest('POST', Uri.parse(url));

  request.fields.addAll({
    'Event_Name': eventname,
    'Event_Detail': eventdetail,
    'Event_Start_Date': eventstartdate,
    'Event_Start_Time': eventstarttime,
    'Event_End_Date': eventenddate,
    'Event_End_Time': eventendtime,
    'Event_Type': eventtype,
    'Participant_Limit': eventpaticipant,
    'Event_Points': eventpoint,
    'Event_Latitude': la.toString(),
    'Event_Longitude': ln.toString()
  });
  request.files
      .add(await http.MultipartFile.fromPath('image', imageFile!.path));
  request.headers.addAll(requestHeaders);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 201) {
    print("ยิงละ");
  }
}

class PreviewActivityStaffManagerPage extends StatefulWidget {
  PreviewActivityStaffManagerPage({Key? key}) : super(key: key);

  @override
  State<PreviewActivityStaffManagerPage> createState() =>
      _PreviewActivityStaffManagerPageState();
}

bool? isvalid;
bool agreedterm = false;

class _PreviewActivityStaffManagerPageState
    extends State<PreviewActivityStaffManagerPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Preview Activity',
                style: TextStyle(fontSize: 28, color: Colors.black)),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16))),
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
                horizontal: width(context: context) / 20,
              ),
              child: Column(
                children: [
/*=="Event Name"==============================================================*/
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
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          eventnamecheck!,
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
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${StaffData.staffProfile?.company}", // Company name
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
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          eventstartdatecheck.toString(),
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
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          eventstarttimecheck.toString(),
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
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          eventenddatecheck.toString(),
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
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          eventendtimecheck.toString(),
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
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          eventtypecheck.toString(),
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
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          participantquantitycheck!,
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
                        "Point/Participants",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          pointperpartcheck!,
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
                    padding: const EdgeInsets.only(
                        left: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          pointperpartcheck!,
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
                        height: 80,
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFE5E5EA),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(8.0))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              eventdetialcheck!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
/*=="Location"===========================================================*/
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  Row(
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
                  Container(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                    child: Row(
                      children: [
                        Text(
                          eventlocation,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
/*=="Location Details"===========================================================*/
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Location Detials",
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
                        height: 80,
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFE5E5EA),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(8.0))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              locationdetialcheck!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                            image: FileImage(imageFile!), fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: height(context: context) / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.0,
                            child: Checkbox(
                                value: agreedterm,
                                onChanged: (val) {
                                  setState(() {
                                    agreedterm = val!;
                                  });
                                  print("have agree");
                                }),
                          ),
                          Text(
                            'I have read and agreed to the ',
                            style: TextStyle(fontSize: 13.0),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TermsAndConditionPage()));
                              // print('tap');
                            },
                            child: Text(
                              "terms and conditions",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 13.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
/*=="Function on Button"======================================================*/
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  MaterialButton(
                    color: Colors.black,
                    disabledColor: Colors.grey,
                    minWidth: 163,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: agreedterm != false
                        ? () {
                            createActivity(
                                eventnamecheck!,
                                eventstartdatecheck!.toString(),
                                eventstarttimecheck!.toString(),
                                eventenddatecheck!.toString(),
                                eventendtimecheck!.toString(),
                                eventtypecheck!,
                                participantquantitycheck!,
                                pointperpartcheck!,
                                ("Event Detail : " +
                                    eventdetialcheck! +
                                    "\nLocation Detail : [" +
                                    eventlocation +
                                    "] " +
                                    locationdetialcheck!),
                                latitude!,
                                longitude!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PreviewActivityStaffManagerPageDone()));
                          }
                        : null,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: height(context: context) / 40,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

// Fuction bring (val) from CreateActivityUserPage to this Page
Activity activitystaffmanager = Activity();

class Activity {
  TextEditingController eventname = TextEditingController();
  TextEditingController eventstartdate = TextEditingController();
  TextEditingController eventstarttime = TextEditingController();
  TextEditingController eventenddate = TextEditingController();
  TextEditingController eventendtime = TextEditingController();
  TextEditingController eventtype = TextEditingController();
  TextEditingController eventquantity = TextEditingController();
  TextEditingController eventpointquantity = TextEditingController();
  TextEditingController eventdetial = TextEditingController();
  TextEditingController eventlocationdetail = TextEditingController();
  TextEditingController eventlocation = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController eventtierpoint = TextEditingController();
  File? imagefiledata;
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/staffdata.dart';
import 'package:quest_2/initiate_app/terms_condition.dart';
import 'package:quest_2/serviecs/activity_location_map_service.dart';
import 'package:quest_2/staff_manager/preview_act_staffmanager_done.dart';
import 'package:quest_2/staff_manager/preview_act_staffmanager_fail.dart';
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
    String eventlocation,
    String eventtier,
    double la,
    double ln) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/sm_user_create_event";
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

  var request = http.MultipartRequest('POST', Uri.parse(url));

  request.fields.addAll({
    'Event_Name': eventname,
    'Event_Detail': eventdetail,
    'Event_Location': eventlocation,
    'Event_Start_Date': eventstartdate,
    'Event_Start_Time': eventstarttime,
    'Event_End_Date': eventenddate,
    'Event_End_Time': eventendtime,
    'Event_Tier_Points_Require': eventtier,
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
int? status;

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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text('Preview Activity',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF6F2DA8),
                )),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16))),
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
                horizontal: width(context: context) / 20,
              ),
              child: Column(
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
                    child: detailsarea(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.0,
                            child: Checkbox(
                                activeColor: Color(0xFF6F2DA8),
                                value: agreedterm,
                                onChanged: (val) {
                                  setState(() {
                                    agreedterm = val!;
                                  });
                                  print("have agree");
                                }),
                          ),
                          Text(
                            'I have read and agreed with ',
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
                                  color: Color(0xFF6F2DA8), fontSize: 13.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  submitbtn(),
                  SizedBox(
                    height: height(context: context) / 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget detailsarea() {
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
                activitystaffmanager.eventname.text,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
/*=="Event Organizer."========================================================*/
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
                "${StaffData.staffProfile?.company}",
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
                eventstartdatecheck.toString(),
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
                eventstarttimecheck.toString(),
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
                eventenddatecheck.toString(),
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
                eventendtimecheck.toString(),
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
                eventtypecheck.toString(),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),

/*=="Participants Quantity"===================================================*/
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
                "Participants Quantity",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                activitystaffmanager.eventquantity.text,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
/*=="Point/Participants"===================================================*/
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
                "Point/Participants",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                activitystaffmanager.eventpointquantity.text,
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
                activitystaffmanager.eventtierpoint.text,
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
          padding: const EdgeInsets.only(left: 8),
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
              activitystaffmanager.eventdetial.text,
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
          padding: const EdgeInsets.only(left: 8),
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
            child: Row(
              children: [
                Text(
                  eventlocation,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "lat : ${latitude.toString()}",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "long :${longitude.toString()}",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
/*=="Location Details"===========================================================*/
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Divider(
            color: Color(0xFF6F2DA8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Location Detial",
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
              locationdetialcheck!,
              style: TextStyle(color: Colors.black, fontSize: 16),
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
          image:
              DecorationImage(image: FileImage(imageFile!), fit: BoxFit.cover)),
    );
  }

  Widget submitbtn() {
    return MaterialButton(
      color: Color(0xFF6F2DA8),
      disabledColor: Colors.grey,
      minWidth: 163,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                  eventdetialcheck!,
                  (eventlocation + "\nDetail : " + locationdetialcheck!),
                  tierpointscheck!,
                  latitude!,
                  longitude!);
              eventlocation = "";
              status == 201
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PreviewActivityStaffManagerPageDone()))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PreviewActivityStaffManagerPageFail()));
            }
          : null,
      child: Text(
        'Submit',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
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

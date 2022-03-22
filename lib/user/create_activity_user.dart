import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:quest_2/serviecs/activity_location_map_service.dart';
import 'package:quest_2/serviecs/utils.dart';
import 'package:quest_2/user/preview_activity_user.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';

class CreateActivityUserPage extends StatefulWidget {
  CreateActivityUserPage({Key? key}) : super(key: key);

  @override
  _CreateActivityUserPageState createState() => _CreateActivityUserPageState();
}

File? imageFile;
bool? isvalid;
String? eventnamecheck;
String? eventstartdatecheck;
String? eventstarttimecheck;
String? eventenddatecheck;
String? eventendtimecheck;
String? eventtypecheck;
String? participantquantitycheck;
String? pointperpartcheck;
String? eventdetialcheck;
String? locationdetialcheck;
String? tierpointscheck;

class _CreateActivityUserPageState extends State<CreateActivityUserPage> {
  TextEditingController textFieldController = TextEditingController();
//Date Start Picker
  DateTime dateTimeStart = DateTime.now();
  String getDateStartTime() {
    return DateFormat('dd/MM/yyyy').format(dateTimeStart);
  }

//Date End Picker
  DateTime dateTimeEnd = DateTime.now();
  String getDateEndTime() {
    return DateFormat('dd/MM/yyyy').format(dateTimeEnd);
  }

//Time Start Picker
  DateTime dateTimeDayStart = DateTime.now();

//Time End Picker
  DateTime dateTimeDayEnd = DateTime.now();

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);

    activity.eventname.clear();
    activity.eventstartdate.clear();
    activity.eventstarttime.clear();
    activity.eventenddate.clear();
    activity.eventendtime.clear();
    activity.eventtype.clear();
    activity.eventquantity.clear();
    activity.eventpointquantity.clear();
    activity.eventdetial.clear();
    activity.eventtierpoint.clear();
    eventlocation = "";
    imageFile = null;
    dateTimeDayStart = getDayTimeStart();
    dateTimeDayEnd = getDayTimeEnd();
    latitude = null;
    longitude = null;
  }

//Time Start Picker
  String getTimeStart() {
    return DateFormat('HH:mm').format(dateTimeDayStart);
  }

//Time End Picker
  String getTimeEnd() {
    return DateFormat('HH:mm').format(dateTimeDayEnd);
  }

  int index = 0;
  late FixedExtentScrollController scrollController;
  final items = [
    'Select',
    'Health',
    'Education',
    'Environment',
    'Disabled People',
  ];

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
              'Create Activity',
              style: TextStyle(
                fontSize: 24.0,
                color: Color(0xFF6F2DA8),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16))),
            // backgroundColor: Color(0xFFEBEDF2),
            // backgroundColor: Colors.transparent,
            backgroundColor: Colors.white.withOpacity(0.8),
            elevation: 0.0,
            leading: BackButton(
              color: Color(0xFF6F2DA8),
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
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
                    height: height(context: context) / 9,
                  ),
/*=="Event Name"==============================================================*/
                  SizedBox(
                    height: height(context: context) / 100,
                  ),
                  Row(
                    children: [
                      Text(
                        "Event Name*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: height(context: context) / 100,
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height(context: context) / 500,
                    ),
                    child: TextField(
                      controller: activity.eventname,
                      maxLength: 20,
                      decoration: InputDecoration(
                          focusedBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: Color(0xFFf0eff5),
                          // hintText: '...',
                          contentPadding: EdgeInsets.all(8.0),
                          border: outlineInputBorder()),
                      onChanged: (val) {
                        setState(() {
                          eventnamecheck = val;
                          isvalid = true;
                        });
                      },
                    ),
                  ),
/*=="Event Start Date"========================================================*/
                  SizedBox(
                    height: height(context: context) / 500,
                  ),
                  Row(
                    children: [
                      Text(
                        "Event Start Date*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(context: context) / 500,
                  ),
                  InkWell(
                    onTap: () => Utils.showSheet(
                      context,
                      child: buildDatePickerStart(),
                      onClicked: () {
                        final value =
                            DateFormat('dd/MM/yyyy').format(dateTimeStart);
                        final valueDateStart = value.toString();

                        print("Start Date:$value");
                        Navigator.pop(context);
                        setState(() {
                          eventstartdatecheck = valueDateStart;
                        });
                      },
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, bottom: 16.0, top: 16.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFf0eff5),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/date_create.svg',
                              color: Color(0xFF6F2DA8), fit: BoxFit.cover),
                          SizedBox(
                            width: width(context: context) / 50,
                          ),
                          Text(
                            getDateStartTime(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
/*=="Event Start Time"========================================================*/
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  Row(
                    children: [
                      Text(
                        "Event Start Time*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(context: context) / 500,
                  ),
                  InkWell(
                    onTap: () => Utils.showSheet(
                      context,
                      child: buildTimePickerStart(),
                      onClicked: () {
                        final value =
                            DateFormat('HH:mm').format(dateTimeDayStart);
                        Navigator.pop(context);
                        final valueTimeStart = value.toString();

                        print('Time Start : $valueTimeStart');
                        setState(() {
                          eventstarttimecheck = valueTimeStart;
                        });
                      },
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, bottom: 16.0, top: 16.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFf0eff5),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/time_create.svg',
                              color: Color(0xFF6F2DA8), fit: BoxFit.cover),
                          SizedBox(
                            width: width(context: context) / 50,
                          ),
                          Text(
                            getTimeStart(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
/*=="Event End Date"==========================================================*/
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  Row(
                    children: [
                      Text(
                        "Event End Date*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(context: context) / 500,
                  ),
                  InkWell(
                    onTap: () => Utils.showSheet(
                      context,
                      child: buildDatePickerEnd(),
                      onClicked: () {
                        final value =
                            DateFormat('dd/MM/yyyy').format(dateTimeEnd);
                        final valueDateEnd = value.toString();
                        print("End Date:$value");
                        Navigator.pop(context);
                        setState(() {
                          eventenddatecheck = valueDateEnd;
                        });
                      },
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, bottom: 16.0, top: 16.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFf0eff5),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/date_create.svg',
                              color: Color(0xFF6F2DA8), fit: BoxFit.cover),
                          SizedBox(
                            width: width(context: context) / 50,
                          ),
                          Text(
                            getDateEndTime(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
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
                        "Event End Time*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Utils.showSheet(
                      context,
                      child: buildTimePickerEnd(),
                      onClicked: () {
                        final value =
                            DateFormat('HH:mm').format(dateTimeDayEnd);
                        Navigator.pop(context);
                        final valueTimeEnd = value.toString();
                        eventendtimecheck = valueTimeEnd;
                        print('Time End : $valueTimeEnd');
                      },
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, bottom: 16.0, top: 16.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFf0eff5),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/time_create.svg',
                              color: Color(0xFF6F2DA8), fit: BoxFit.cover),
                          SizedBox(
                            width: width(context: context) / 50,
                          ),
                          Text(
                            getTimeEnd(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
/*=="Event Type"==============================================================*/
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  Row(
                    children: [
                      Text(
                        "Event Type*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(context: context) / 500,
                  ),
                  InkWell(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          actions: [buildPickerType()],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text('Done',
                                style: TextStyle(
                                  color: Color(0xFF007AFF),
                                )),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, bottom: 16.0, top: 16.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFf0eff5),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/type_create.svg',
                              color: Color(0xFF6F2DA8), fit: BoxFit.cover),
                          SizedBox(
                            width: width(context: context) / 50,
                          ),
                          Text(
                            items[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              // fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
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
                        "Participants Quantity*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height(context: context) / 500,
                    ),
                    child: TextField(
                      controller: activity.eventquantity,
                      inputFormatters: [LengthLimitingTextInputFormatter(1)],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: Color(0xFFf0eff5),
                          // hintText: '...',
                          contentPadding: EdgeInsets.all(8.0),
                          border: outlineInputBorder()),
                      onChanged: (val) {
                        setState(() {
                          participantquantitycheck = val;
                          isvalid = true;
                        });
                      },
                    ),
                  ),
/*=="Point/Participants"======================================================*/
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Point / Participants*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height(context: context) / 500,
                    ),
                    child: TextField(
                      controller: activity.eventpointquantity,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(2)],
                      decoration: InputDecoration(
                          focusedBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: Color(0xFFf0eff5),
                          contentPadding: EdgeInsets.all(8.0),
                          border: outlineInputBorder()),
                      onChanged: (val) {
                        setState(() {
                          pointperpartcheck = val;
                          isvalid = true;
                        });
                      },
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
                        " Tier-Points Require*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height(context: context) / 500,
                    ),
                    child: TextField(
                      controller: activity.eventtierpoint,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(2)],
                      decoration: InputDecoration(
                          focusedBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: Color(0xFFf0eff5),
                          contentPadding: EdgeInsets.all(8.0),
                          border: outlineInputBorder()),
                      onChanged: (val) {
                        setState(() {
                          tierpointscheck = val;
                          isvalid = true;
                        });
                      },
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
                        "Event Detail*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height(context: context) / 500,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      maxLength: 100,
                      controller: activity.eventdetial,
                      decoration: InputDecoration(
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFFf0eff5),
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder(),
                      ),
                      onChanged: (val) {
                        setState(() {
                          eventdetialcheck = val;
                          isvalid = true;
                        });
                      },
                    ),
                  ),
/*=="Select location"==========================================================*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Select location*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivityLocationMapPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, bottom: 16.0, top: 16.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFf0eff5),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        children: <Widget>[
                          Text(
                            eventlocation,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: SvgPicture.asset(
                                'assets/icons/forward_activity.svg',
                                color: Color(0xFF6F2DA8),
                                fit: BoxFit.cover),
                          ), // use Spacer
                        ],
                      ),
                    ),
                  ),
/*=="Location Detials"===========================================================*/
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Location Detail*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height(context: context) / 500,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      maxLength: 100,
                      // controller: activity.eventdetial,
                      decoration: InputDecoration(
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFFf0eff5),
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder(),
                      ),
                      onChanged: (val) {
                        setState(() {
                          locationdetialcheck = val;
                          isvalid = true;
                        });
                      },
                    ),
                  ),
/*=="Please upload photo about your Event."===================================*/
                  SizedBox(
                    height: height(context: context) / 500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Please upload photo about your Event.*",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: Text(
                          "Upload Cover",
                          style: TextStyle(
                            color: Color(0xFF6F2DA8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(context: context) / 100,
                  ),
                  imageFile == null
                      ? activitycovertemp()
                      : activitycover(imageFile!),
                  SizedBox(
                    height: height(context: context) / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          print('Contact to admin');
                        },
                        child: Text(
                          "Create more huge event or You are official organizer.  ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6F2DA8),
                          ),
                        ),
                      ),
                    ],
                  ),
/*=="Function on Button"======================================================*/
                  SizedBox(
                    height: height(context: context) / 50,
                  ),
                  MaterialButton(
                    color: Color(0xFF6F2DA8),
                    disabledColor: Colors.grey,
                    minWidth: 163,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: eventnamecheck != null &&
                            eventnamecheck != "" &&
                            eventnamecheck != " " &&
                            participantquantitycheck != null &&
                            participantquantitycheck != "" &&
                            participantquantitycheck != " " &&
                            eventstartdatecheck != null &&
                            eventstarttimecheck != null &&
                            eventenddatecheck != null &&
                            eventendtimecheck != null &&
                            eventtypecheck != null &&
                            // eventtypecheck != "Select" &&
                            eventlocation != "" &&
                            eventlocation != " " &&
                            pointperpartcheck != null &&
                            pointperpartcheck != "" &&
                            pointperpartcheck != " " &&
                            tierpointscheck != null &&
                            tierpointscheck != "" &&
                            tierpointscheck != " " &&
                            eventdetialcheck != null &&
                            eventdetialcheck != " " &&
                            locationdetialcheck != null &&
                            locationdetialcheck != "" &&
                            locationdetialcheck != " " &&
                            imageFile != null
                        ? () {
                            print(eventnamecheck);
                            print(eventstartdatecheck);
                            print(eventenddatecheck);
                            print(eventendtimecheck);
                            print(eventendtimecheck);
                            print(eventtypecheck);
                            print(participantquantitycheck);
                            print(pointperpartcheck);
                            print(eventdetialcheck);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PreviewActivityUserPage()));
                          }
                        : null,
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  SizedBox(
                    height: height(context: context) / 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }

/*=="AddOn for this Page"=====================================================*/

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() => imageFile = imageTemporary);
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Date Picker Start//
  Widget buildDatePickerStart() => SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          minimumYear: DateTime.now().year,
          maximumYear: 2022,
          initialDateTime: dateTimeStart,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTimeStart) =>
              setState(() => this.dateTimeStart = dateTimeStart),
        ),
      );

  // Date Picker End//
  Widget buildDatePickerEnd() => SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          minimumYear: DateTime.now().year,
          maximumYear: 2022,
          initialDateTime: dateTimeEnd,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTimeEnd) =>
              setState(() => this.dateTimeEnd = dateTimeEnd),
        ),
      );

// Types Picker//
  Widget buildPickerType() => SizedBox(
        height: 180,
        child: CupertinoPicker(
          scrollController: scrollController,
          // looping: true,
          itemExtent: 64,
          children: items
              .map((item) => Center(
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 24),
                    ),
                  ))
              .toList(),
          onSelectedItemChanged: (index) {
            setState(() => this.index = index);
            final item = items[index];
            eventtypecheck = item;
            print('Selected Item: $item');
          },
        ),
      );

// Time Start Picker//
  Widget buildTimePickerStart() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTimeDayStart,
          mode: CupertinoDatePickerMode.time,
          minuteInterval: 15,
          use24hFormat: true,
          onDateTimeChanged: (dateTimeDayStart) =>
              setState(() => this.dateTimeDayStart = dateTimeDayStart),
        ),
      );

  DateTime getDayTimeStart() {
    final now = DateTime.now();

    return DateTime(now.hour, 0);
  }

  // Time Picker//
  Widget buildTimePickerEnd() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: dateTimeDayEnd,
          mode: CupertinoDatePickerMode.time,
          minuteInterval: 15,
          use24hFormat: true,
          onDateTimeChanged: (dateTimeDayEnd) =>
              setState(() => this.dateTimeDayEnd = dateTimeDayEnd),
        ),
      );

  DateTime getDayTimeEnd() {
    final now = DateTime.now();

    return DateTime(now.hour, 0);
  }

  Widget activitycovertemp() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage('assets/images/Activity_Cover.jpg'),
        ),
      ),
    );
  }

  Widget activitycover(File imagefile) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(image: FileImage(imagefile), fit: BoxFit.cover),
      ),
    );
  }
}

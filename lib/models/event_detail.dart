import 'dart:convert';

EventDetail eventDetailFromJson(String str) =>
    EventDetail.fromJson(json.decode(str));

String eventDetailToJson(EventDetail data) => json.encode(data.toJson());

class EventDetail {
  EventDetail({
    required this.userId,
    required this.eventId,
    required this.eventName,
    required this.eventPublisher,
    required this.eventDetail,
    required this.eventStartDate,
    required this.eventStartTime,
    required this.eventEndDate,
    required this.eventEndTime,
    required this.eventType,
    required this.eventJoined,
    required this.participantLimit,
    required this.eventPoints,
    required this.eventTierPoints,
    required this.eventLatitude,
    required this.eventLongitude,
    required this.eventApprove,
    required this.eventStatus,
    required this.eventSponsered,
    required this.eventCheckInterest,
    required this.eventCheckJoin,
    required this.eventCheckJoined,
    required this.eventImage,
  });

  String userId;
  String eventId;
  String eventName;
  String eventPublisher;
  String eventDetail;
  String eventStartDate;
  String eventStartTime;
  String eventEndDate;
  String eventEndTime;
  String eventType;
  int eventJoined;
  int participantLimit;
  int eventPoints;
  int eventTierPoints;
  double eventLatitude;
  double eventLongitude;
  bool eventApprove;
  bool eventStatus;
  bool eventSponsered;
  bool eventCheckInterest;
  bool eventCheckJoin;
  bool eventCheckJoined;
  String eventImage;

  factory EventDetail.fromJson(Map<String, dynamic> json) => EventDetail(
        userId: json["USER_ID"],
        eventId: json["Event_ID"],
        eventName: json["Event_Name"],
        eventPublisher: json["Event_Publisher"],
        eventDetail: json["Event_Detail"],
        eventStartDate: json["Event_Start_Date"],
        eventStartTime: json["Event_Start_Time"],
        eventEndDate: json["Event_End_Date"],
        eventEndTime: json["Event_End_Time"],
        eventType: json["Event_Type"],
        eventJoined: json["Event_Joined"],
        participantLimit: json["Participant_Limit"],
        eventPoints: json["Event_Points"],
        eventTierPoints: json["Event_Tier_Points_Require"],
        eventLatitude: json["Event_Latitude"].toDouble(),
        eventLongitude: json["Event_Longitude"].toDouble(),
        eventApprove: json["Event_Approve"],
        eventStatus: json["Event_Status"],
        eventSponsered: json["Event_Sponsered"],
        eventCheckInterest: json["Event_Check_Interest"],
        eventCheckJoin: json["Event_Check_Join"],
        eventCheckJoined: json["Event_Check_Joined"],
        eventImage: json["Event_Image"],
      );

  Map<String, dynamic> toJson() => {
        "USER_ID": userId,
        "Event_ID": eventId,
        "Event_Name": eventName,
        "Event_Publisher": eventPublisher,
        "Event_Detail": eventDetail,
        "Event_Start_Date": eventStartDate,
        "Event_Start_Time": eventStartTime,
        "Event_End_Date": eventEndDate,
        "Event_End_Time": eventEndTime,
        "Event_Type": eventType,
        "Event_Joined": eventJoined,
        "Participant_Limit": participantLimit,
        "Event_Points": eventPoints,
        "Event_Tier_Points_Require": eventTierPoints,
        "Event_Latitude": eventLatitude,
        "Event_Longitude": eventLongitude,
        "Event_Approve": eventApprove,
        "Event_Status": eventStatus,
        "Event_Sponsered": eventSponsered,
        "Event_Check_Interest": eventCheckInterest,
        "Event_Check_Join": eventCheckJoin,
        "Event_Check_Joined": eventCheckJoined,
        "Event_Image": eventImage,
      };
}

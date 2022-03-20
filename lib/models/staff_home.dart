// To parse this JSON data, do
//
//     final staffHome = staffHomeFromJson(jsonString);

import 'dart:convert';

List<StaffHome> staffHomeFromJson(String str) => List<StaffHome>.from(json.decode(str).map((x) => StaffHome.fromJson(x)));

String staffHomeToJson(List<StaffHome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffHome {
    StaffHome({
        required this.eventName,
        required this.eventImage,
        required this.eventId,
    });

    String eventName;
    String eventImage;
    String eventId;

    factory StaffHome.fromJson(Map<String, dynamic> json) => StaffHome(
        eventName: json["Event_Name"],
        eventImage: json["Event_Image"],
        eventId: json["Event_ID"],
    );

    Map<String, dynamic> toJson() => {
        "Event_Name": eventName,
        "Event_Image": eventImage,
        "Event_ID": eventId,
    };
}

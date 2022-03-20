// To parse this JSON data, do
//
//     final interestedEvent = interestedEventFromJson(jsonString);

import 'dart:convert';

List<InterestedEvent> interestedEventFromJson(String str) => List<InterestedEvent>.from(json.decode(str).map((x) => InterestedEvent.fromJson(x)));

String interestedEventToJson(List<InterestedEvent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InterestedEvent {
    InterestedEvent({
        required this.id,
        required this.eventName,
        required this.eventType,
        required this.eventPoints,
        required this.eventImage,
    });

    String id;
    String eventName;
    String eventType;
    int eventPoints;
    String eventImage;

    factory InterestedEvent.fromJson(Map<String, dynamic> json) => InterestedEvent(
        id: json["Event_ID"],
        eventName: json["Event_Name"],
        eventType: json["Event_Type"],
        eventPoints: json["Event_Points"],
        eventImage: json["Event_Image"],
    );

    Map<String, dynamic> toJson() => {
        "Event_ID": id,
        "Event_Name": eventName,
        "Event_Type": eventType,
        "Event_Points": eventPoints,
        "Event_Image": eventImage,
    };
}
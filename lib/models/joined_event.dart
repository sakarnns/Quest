// To parse this JSON data, do
//
//     final joinedEvent = joinedEventFromJson(jsonString);

import 'dart:convert';

List<JoinedEvent> joinedEventFromJson(String str) => List<JoinedEvent>.from(json.decode(str).map((x) => JoinedEvent.fromJson(x)));

String joinedEventToJson(List<JoinedEvent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JoinedEvent {
    JoinedEvent({
        required this.eventId,
        required this.eventName,
        required this.eventType,
        required this.eventPoints,
        required this.eventImage,
    });

    String eventId;
    String eventName;
    String eventType;
    int eventPoints;
    String eventImage;

    factory JoinedEvent.fromJson(Map<String, dynamic> json) => JoinedEvent(
        eventId: json["Event_ID"],
        eventName: json["Event_Name"],
        eventType: json["Event_Type"],
        eventPoints: json["Event_Points"],
        eventImage: json["Event_Image"],
    );

    Map<String, dynamic> toJson() => {
        "Event_ID": eventId,
        "Event_Name": eventName,
        "Event_Type": eventType,
        "Event_Points": eventPoints,
        "Event_Image": eventImage,
    };
}

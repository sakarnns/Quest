// To parse this JSON data, do
//
//     final myEvent = myEventFromJson(jsonString);

import 'dart:convert';

List<MyEvent> myEventFromJson(String str) => List<MyEvent>.from(json.decode(str).map((x) => MyEvent.fromJson(x)));

String myEventToJson(List<MyEvent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyEvent {
    MyEvent({
        required this.eventName,
        required this.eventType,
        required this.eventPoints,
        required this.eventImage,
        required this.eventId,
    });

    String eventName;
    String eventType;
    int eventPoints;
    String eventImage;
    String eventId;

    factory MyEvent.fromJson(Map<String, dynamic> json) => MyEvent(
        eventName: json["Event_Name"],
        eventType: json["Event_Type"],
        eventPoints: json["Event_Points"],
        eventImage: json["Event_Image"],
        eventId: json["Event_ID"],
    );

    Map<String, dynamic> toJson() => {
        "Event_Name": eventName,
        "Event_Type": eventType,
        "Event_Points": eventPoints,
        "Event_Image": eventImage,
        "Event_ID": eventId,
    };
}

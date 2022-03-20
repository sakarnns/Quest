// To parse this JSON data, do
//
//     final eventAll = eventAllFromJson(jsonString);

import 'dart:convert';

List<EventAll> eventAllFromJson(String str) => List<EventAll>.from(json.decode(str).map((x) => EventAll.fromJson(x)));

String eventAllToJson(List<EventAll> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventAll {
    EventAll({
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

    factory EventAll.fromJson(Map<String, dynamic> json) => EventAll(
        id: json["_id"],
        eventName: json["Event_Name"],
        eventType: json["Event_Type"],
        eventPoints: json["Event_Points"],
        eventImage: json["Event_Image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "Event_Name": eventName,
        "Event_Type": eventType,
        "Event_Points": eventPoints,
        "Event_Image": eventImage,
    };
}
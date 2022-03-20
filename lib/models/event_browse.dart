// To parse this JSON data, do
//
//     final eventBrowse = eventBrowseFromJson(jsonString);

import 'dart:convert';

EventBrowse eventBrowseFromJson(String str) => EventBrowse.fromJson(json.decode(str));

String eventBrowseToJson(EventBrowse data) => json.encode(data.toJson());

class EventBrowse {
    EventBrowse({
        required this.eventsponsered5,
        required this.eventrcm5,
        required this.event5,
    });

    List<Event> eventsponsered5;
    List<Event> eventrcm5;
    List<Event> event5;

    factory EventBrowse.fromJson(Map<String, dynamic> json) => EventBrowse(
        eventsponsered5: List<Event>.from(json["eventsponsered_5"].map((x) => Event.fromJson(x))),
        eventrcm5: List<Event>.from(json["eventrcm_5"].map((x) => Event.fromJson(x))),
        event5: List<Event>.from(json["event_5"].map((x) => Event.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "eventsponsered_5": List<dynamic>.from(eventsponsered5.map((x) => x.toJson())),
        "eventrcm_5": List<dynamic>.from(eventrcm5.map((x) => x.toJson())),
        "event_5": List<dynamic>.from(event5.map((x) => x.toJson())),
    };
}

class Event {
    Event({
      required  this.id,
      required  this.eventName,
      required  this.eventType,
      required  this.eventPoints,
      required  this.eventImage,
    });

    String id;
    String eventName;
    String eventType;
    String eventImage;
    int eventPoints;

    factory Event.fromJson(Map<String, dynamic> json) => Event(
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

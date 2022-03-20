// To parse this JSON data, do
//
//     final qrGen = qrGenFromJson(jsonString);

import 'dart:convert';

QrGen qrGenFromJson(String str) => QrGen.fromJson(json.decode(str));

String qrGenToJson(QrGen data) => json.encode(data.toJson());

class QrGen {
    QrGen({
        required this.hash,
        required this.userName,
        required this.eventName,
        required this.points,
    });

    String hash;
    String userName;
    String eventName;
    int points;

    factory QrGen.fromJson(Map<String, dynamic> json) => QrGen(
        hash: json["hash"],
        userName: json["User_Name"],
        eventName: json["Event_Name"],
        points: json["Points"],
    );

    Map<String, dynamic> toJson() => {
        "hash": hash,
        "User_ID": userName,
        "Event_ID": eventName,
        "Points": points,
    };
}

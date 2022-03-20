// To parse this JSON data, do
//
//     final transactions = transactionsFromJson(jsonString);

import 'dart:convert';

List<Transactions> transactionsFromJson(String str) => List<Transactions>.from(json.decode(str).map((x) => Transactions.fromJson(x)));

String transactionsToJson(List<Transactions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transactions {
    Transactions({
        required this.name,
        required this.type,
        required this.points,
        required this.createdAt,
    });

    String name;
    String type;
    int points;
    DateTime createdAt;

    factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        name: json["Name"],
        type: json["Type"],
        points: json["POINT"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Type": type,
        "POINT": points,
        "createdAt": createdAt.toIso8601String(),
    };
}

// To parse this JSON data, do
//
//     final staffProfile = staffProfileFromJson(jsonString);

import 'dart:convert';

StaffProfile staffProfileFromJson(String str) => StaffProfile.fromJson(json.decode(str));

String staffProfileToJson(StaffProfile data) => json.encode(data.toJson());

class StaffProfile {
    StaffProfile({
        required this.username,
        required this.usertype,
        required this.company,
    });

    String username;
    String usertype;
    String company;

    factory StaffProfile.fromJson(Map<String, dynamic> json) => StaffProfile(
        username: json["Username"],
        usertype: json["Usertype"],
        company: json["Company"],
    );

    Map<String, dynamic> toJson() => {
        "Username": username,
        "Usertype": usertype,
        "Company": company,
    };
}

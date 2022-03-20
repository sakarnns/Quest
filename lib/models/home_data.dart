// To parse this JSON data, do
//
//     final homeData = homeDataFromJson(jsonString);

import 'dart:convert';

List<HomeData> homeDataFromJson(String str) => List<HomeData>.from(json.decode(str).map((x) => HomeData.fromJson(x)));

String homeDataToJson(List<HomeData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeData {
    HomeData({
        required this.id,
        required this.rewardName,
        required this.rewardPrice,
        required this.rewardRemain,
        required this.rewardImage,
    });

    String id;
    String rewardName;
    int rewardPrice;
    int rewardRemain;
    String rewardImage;

    factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        id: json["_id"],
        rewardName: json["Reward_Name"],
        rewardPrice: json["Reward_Price"],
        rewardRemain: json["Reward_Remain"],
        rewardImage: json["Reward_Image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "Reward_Name": rewardName,
        "Reward_Price": rewardPrice,
        "Reward_Remain": rewardRemain,
        "Reward_Image": rewardImage,
    };
}

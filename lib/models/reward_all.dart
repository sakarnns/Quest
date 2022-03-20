// To parse this JSON data, do
//
//     final rewardAll = rewardAllFromJson(jsonString);

import 'dart:convert';

List<RewardAll> rewardAllFromJson(String str) => List<RewardAll>.from(json.decode(str).map((x) => RewardAll.fromJson(x)));

String rewardAllToJson(List<RewardAll> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RewardAll {
    RewardAll({
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

    factory RewardAll.fromJson(Map<String, dynamic> json) => RewardAll(
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

// To parse this JSON data, do
//
//     final rewardDetail = rewardDetailFromJson(jsonString);

import 'dart:convert';

RewardDetail rewardDetailFromJson(String str) =>
    RewardDetail.fromJson(json.decode(str));

String rewardDetailToJson(RewardDetail data) => json.encode(data.toJson());

class RewardDetail {
  RewardDetail({
    required this.id,
    required this.rewardName,
    required this.rewardType,
    required this.rewardDetail,
    required this.rewardPrice,
    required this.rewardRemain,
    required this.rewardEndDate,
    required this.rewardStatus,
    required this.rewardImage,
  });

  String id;
  String rewardName;
  String rewardType;
  String rewardDetail;
  int rewardPrice;
  int rewardRemain;
  DateTime rewardEndDate;
  bool rewardStatus;
  String rewardImage;

  factory RewardDetail.fromJson(Map<String, dynamic> json) => RewardDetail(
        id: json["_id"],
        rewardName: json["Reward_Name"],
        rewardType: json["Reward_Type"],
        rewardDetail: json["Reward_Detail"],
        rewardPrice: json["Reward_Price"],
        rewardRemain: json["Reward_Remain"],
        rewardEndDate: DateTime.parse(json["Reward_End_Date"]),
        rewardStatus: json["Reward_Status"],
        rewardImage: json["Reward_Image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Reward_Name": rewardName,
        "Reward_Type": rewardType,
        "Reward_Detail": rewardDetail,
        "Reward_Price": rewardPrice,
        "Reward_Remain": rewardRemain,
        "Reward_End_Date": rewardEndDate.toIso8601String(),
        "Reward_Status": rewardStatus,
        "Reward_Image": rewardImage,
      };
}

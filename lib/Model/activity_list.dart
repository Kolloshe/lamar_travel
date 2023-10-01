import 'dart:convert';

AcivityList acivityListFromJson(String str) => AcivityList.fromJson(json.decode(str));

String acivityListToJson(AcivityList data) => json.encode(data.toJson());

class AcivityList {
  AcivityList({
    required this.error,
    required this.availability,
    required this.data,
  });

  bool error;
  bool availability;
  List<ActivityListData> data;

  factory AcivityList.fromJson(Map<String, dynamic> json) => AcivityList(
        error: json["error"],
        availability: json["availability"],
        data: List<ActivityListData>.from(json["data"]
            .where((e) => e['activity_only_amount'].toString() != "0")
            .toList()
            .map((x) => ActivityListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "availability": availability,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ActivityListData {
  ActivityListData(
      {required this.activityId,
      required this.name,
      required this.image,
      required this.content,
      required this.modalitiyCode,
      required this.modalitiyName,
      required this.currency,
      required this.modalityAmount,
      required this.activityAmount});

  String activityId;
  String name;
  String image;
  String content;
  String modalitiyCode;
  String modalitiyName;
  String currency;
  dynamic modalityAmount;
  String activityAmount;

  // "activity_only_currency": "AED",

  factory ActivityListData.fromJson(Map<String, dynamic> json) => ActivityListData(
      activityId: json["activity_id"],
      name: json["name"],
      image: json["image"].runtimeType.toString() == 'List<dynamic>' ? '' : json["image"],
      content: json["content"],
      modalitiyCode: json["modalitiy_code"],
      modalitiyName: json["modalitiy_name"],
      currency: json["currency"],
      modalityAmount: json["modality_amount"],
      activityAmount: json["activity_only_amount"].toString());

  Map<String, dynamic> toJson() => {
        "activity_id": activityId,
        "name": name,
        "image": image,
        "content": content,
        "modalitiy_code": modalitiyCode,
        "modalitiy_name": modalitiyName,
        "currency": currency,
        "modality_amount": modalityAmount,
        "activity_only_amount": activityAmount,
      };
}

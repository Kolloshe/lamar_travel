// To parse required this JSON data, do
//
//     final activityQuestions = activityQuestionsFromMap(jsonString);

import 'dart:convert';

ActivityQuestions activityQuestionsFromMap(String str) =>
    ActivityQuestions.fromMap(json.decode(str));

String activityQuestionsToMap(ActivityQuestions data) => json.encode(data.toMap());

class ActivityQuestions {
  ActivityQuestions({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  List<Questions>? data;

  factory ActivityQuestions.fromMap(Map<String, dynamic> json) => ActivityQuestions(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: json.containsKey('data')
            ? List<Questions>.from(json["data"].map((x) => Questions.fromMap(x)))
            : null,
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "error": error,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Questions {
  Questions(
      {required this.code,
      required this.text,
      required this.required,
      required this.ibhCode,
      required this.activityName,
      required this.activityCode,
      required this.activityId,
      this.answer});

  String code;
  String text;
  bool required;
  String ibhCode;
  String? answer;
  String activityName;
  String activityCode;
  String activityId;

  factory Questions.fromMap(Map<String, dynamic> json) => Questions(
        code: json["code"],
        text: json["text"],
        required: json["required"],
        activityName: json["activity_name"],
        activityCode: json["activity_code"],
        activityId: json["activity_id"],
        ibhCode: json["ibh_code"],
      );

  Map<String, dynamic> toMap() => {
        "code": '${code}12345',
        "text": text,
        "required": required,
        "ibh_code": ibhCode,
        "answer": answer
      };
}

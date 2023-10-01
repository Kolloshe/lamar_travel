// To parse this JSON data, do
//
//     final holidaysfotter = holidaysfotterFromJson(jsonString);

import 'dart:convert';

Holidaysfotter holidaysfotterFromJson(String str) => Holidaysfotter.fromJson(json.decode(str));

String holidaysfotterToJson(Holidaysfotter data) => json.encode(data.toJson());

class Holidaysfotter {
    Holidaysfotter({
        required  this.code,
        required this.error,
        required this.message,
        required this.data,
    });

    int code;
    bool error;
    String message;
    FooterContent data;

    factory Holidaysfotter.fromJson(Map<String, dynamic> json) => Holidaysfotter(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: FooterContent.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "error": error,
        "message": message,
        "data": data.toJson(),
    };
}

class FooterContent {
    FooterContent({
        required this.packageStart,
        required this.packageEnd,
        required this.sectionOne,
        required this.sectionTwo,
    });

    String packageStart;
    String packageEnd;
    Section sectionOne;
    Section sectionTwo;

    factory FooterContent.fromJson(Map<String, dynamic> json) => FooterContent(
        packageStart: json["package_start"],
        packageEnd: json["package_end"],
        sectionOne: Section.fromJson(json["section_one"]),
        sectionTwo: Section.fromJson(json["section_two"]),
    );

    Map<String, dynamic> toJson() => {
        "package_start": packageStart,
        "package_end": packageEnd,
        "section_one": sectionOne.toJson(),
        "section_two": sectionTwo.toJson(),
    };
}

class Section {
    Section({
       required  this.title,
       required  this.data,
    });

    String title;
    List<HolidayData> data;

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        title: json["title"],
        data: List<HolidayData>.from(json["data"].map((x) => HolidayData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class HolidayData {
    HolidayData({
       required this.label,
       required this.city,
       required this.cityFullName,
       required this.image,
       required this.searchUrl,
       required this.arrivalCode,
       required this.departureCode,
    });

    String label;
    String city;
    String cityFullName;
    String image;
    String searchUrl;
    int arrivalCode;
    int departureCode;

    factory HolidayData.fromJson(Map<String, dynamic> json) => HolidayData(
        label: json["label"],
        city: json["city"],
        cityFullName: json["city_full_name"],
        image: json["image"],
        searchUrl: json["search_url"],
        arrivalCode: json["arrival_code"],
        departureCode: json["departure_code"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "city": city,
        "city_full_name": cityFullName,
        "image": image,
        "search_url": searchUrl,
        "arrival_code": arrivalCode,
        "departure_code": departureCode,
    };
}

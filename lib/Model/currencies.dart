// To parse required this JSON data, do
//
//     final currencies = currenciesFromJson(jsonString);

import 'dart:convert';

Currencies currenciesFromJson(String str) => Currencies.fromJson(json.decode(str));

String currenciesToJson(Currencies data) => json.encode(data.toJson());

class Currencies {
    Currencies({
        required this.currenciesDefault,
        required this.currencies,
    });

    String currenciesDefault;
    List<Currency>? currencies;

    factory Currencies.fromJson(Map<String, dynamic> json) => Currencies(
        currenciesDefault: json["default"],
        currencies: json["currencies"] == null ? null : List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "default": currenciesDefault,
        "currencies": currencies == null ? null : List<dynamic>.from(currencies!.map((x) => x.toJson())),
    };
}

class Currency {
    Currency({
        required this.code,
        required this.title,
    });

    String code;
    String title;

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "title":  title,
    };
}

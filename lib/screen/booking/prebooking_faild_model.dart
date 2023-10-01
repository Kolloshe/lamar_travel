// To parse required this JSON data, do
//
//     final prebook = prebookFromJson(jsonString);




class PrebookMessage {
    PrebookMessage({
        required this.flightFail,
        required this.flightFailMessage,
        required this.hotelFail,
        required this.hotelFailMessage,
        required this.transferFail,
        required this.transferFailMessage,
        required this.activityFail,
        required this.activityFailMessage,
    });

    int flightFail;
    String flightFailMessage;
    int hotelFail;
    String hotelFailMessage;
    int transferFail;
    String transferFailMessage;
    int activityFail;
    String activityFailMessage;

    factory PrebookMessage.fromJson(Map<String, dynamic> json) => PrebookMessage(
        flightFail: json["flightFail"],
        flightFailMessage: json["flightFailMessage"],
        hotelFail: json["hotelFail"],
        hotelFailMessage: json["hotelFailMessage"],
        transferFail: json["transferFail"],
        transferFailMessage: json["transferFailMessage"],
        activityFail: json["activityFail"],
        activityFailMessage: json["activityFailMessage"],
    );

    Map<String, dynamic> toJson() => {
        "flightFail": flightFail,
        "flightFailMessage": flightFailMessage,
        "hotelFail": hotelFail,
        "hotelFailMessage": hotelFailMessage,
        "transferFail": transferFail,
        "transferFailMessage": transferFailMessage,
        "activityFail": activityFail,
        "activityFailMessage": activityFailMessage,
    };
}


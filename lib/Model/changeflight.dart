// To parse required this JSON data, do
//
//     final changeflight = changeflightFromJson(jsonString);

import 'dart:convert';

Changeflight changeflightFromJson(String str) => Changeflight.fromJson(json.decode(str));

String changeflightToJson(Changeflight data) => json.encode(data.toJson());

class Changeflight {
    Changeflight({
        required this.error,
        required this.data,
    });

    bool error;
    List<FlightData> data;

    factory Changeflight.fromJson(Map<String, dynamic> json) => Changeflight(
        error: json["error"],
        data: List<FlightData>.from(json["data"].map((x) => FlightData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class FlightData {
    FlightData({
        required this.flightId,
        required this.carrier,
        required this.currency,
        required this.priceDiff,
        required this.priceGroup,
        required this.from,
        required this.to,
    });

    dynamic flightId;
    Carrier carrier;
    String currency;
    int priceDiff;
    int priceGroup;
    From from;
    From to;

    factory FlightData.fromJson(Map<String, dynamic> json) => FlightData(
        flightId: json["flight_id"],
        carrier: Carrier.fromJson(json["carrier"]),
        currency: json["currency"],
        priceDiff: json["priceDiff"],
        priceGroup: json["priceGroup"],
        from: From.fromJson(json["from"]),
        to: From.fromJson(json["to"]),
    );

    Map<String, dynamic> toJson() => {
        "flight_id": flightId,
        "carrier": carrier.toJson(),
        "currency": currency,
        "priceDiff": priceDiff,
        "priceGroup": priceGroup,
        "from": from.toJson(),
        "to": to.toJson(),
    };
}

class Carrier {
    Carrier({
        required this.name,
        required this.code,
        required this.label,
    });

    String name;
    String code;
    String label;

    factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
        name: json["name"],
        code: json["code"],
        label: json["label"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code":code,
        "label":label,
    };
}






class From {
    From({
        required this.numstops,
        required this.stops,
        required this.departureCity,
        required this.arrivalCity,
        required this.departureCityCode,
        required this.arrivalCityCode,
        required this.arrivalDate,
        required this.arrivalFdate,
        required this.arrivalTime,
        required this.carrierImage,
        required this.departureDate,
        required this.departureFdate,
        required this.departureTime,
        required this.arrivalDays,
        required this.travelTime,
        required this.itinerary,
    });

    int numstops;
    List<dynamic> stops;
    String departureCity;
    String arrivalCity;
    String departureCityCode;
    String arrivalCityCode;
    String arrivalDate;
    DateTime arrivalFdate;
    String arrivalTime;
    String carrierImage;
    String departureDate;
    DateTime departureFdate;
    String departureTime;
    int arrivalDays;
    String travelTime;
    List<Itinerary> itinerary;

    factory From.fromJson(Map<String, dynamic> json) => From(
        numstops: json["numstops"],
        stops:List<dynamic>.from(json["stops"].map((x) => x)),
        departureCity: json["departure_city"],
        arrivalCity: json["arrival_city"],
        departureCityCode: json["departure_city_code"],
        arrivalCityCode: json["arrival_city_code"],
        arrivalDate:json["arrival_date"],
        arrivalFdate: DateTime.parse(json["arrival_fdate"]),
        arrivalTime: json["arrival_time"],
        carrierImage: json["carrier_image"],
        departureDate: json["departure_date"],
        departureFdate: DateTime.parse(json["departure_fdate"]),
        departureTime: json["departure_time"],
        arrivalDays: json["arrival_days"],
        travelTime: json["travel_time"],
        itinerary: List<Itinerary>.from(json["itinerary"].map((x) => Itinerary.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "numstops": numstops,
        "stops": List<String>.from(stops.map((x) => x)),
        "departure_city": departureCity,
        "arrival_city": arrivalCity,
        "departure_city_code": departureCityCode,
        "arrival_city_code": arrivalCityCode,
        "arrival_date": arrivalDate,
        "arrival_fdate": "${arrivalFdate.year.toString().padLeft(4, '0')}-${arrivalFdate.month.toString().padLeft(2, '0')}-${arrivalFdate.day.toString().padLeft(2, '0')}",
        "arrival_time": arrivalTime,
        "carrier_image": carrierImage,
        "departure_date": departureDate,
        "departure_fdate": "${departureFdate.year.toString().padLeft(4, '0')}-${departureFdate.month.toString().padLeft(2, '0')}-${departureFdate.day.toString().padLeft(2, '0')}",
        "departure_time": departureTime,
        "arrival_days": arrivalDays,
        "travel_time": travelTime,
        "itinerary": List<dynamic>.from(itinerary.map((x) => x.toJson())),
    };
}








class Itinerary {
    Itinerary({
        required this.company,
        required this.flightNo,
        required this.departure,
        required this.flightTime,
        required this.arrival,
        required this.numstops,
        required this.baggageInfo,
        required this.bookingClass,
        required this.cabinClass,
        required this.layover,
    });

    Company company;
    String flightNo;
    Arrival departure;
    int flightTime;
    Arrival arrival;
    int numstops;
    List<String> baggageInfo;
    String bookingClass;
    String cabinClass;
    int layover;

    factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        company: Company.fromJson(json["company"]),
        flightNo: json["flightNo"],
        departure: Arrival.fromJson(json["departure"]),
        flightTime: json["flight_time"],
        arrival: Arrival.fromJson(json["arrival"]),
        numstops: json["numstops"],
        baggageInfo:json["baggageInfo"]!=null ? List<String>.from(json["baggageInfo"].map((x) =>x)):[] ,
        bookingClass:json["bookingClass"],
        cabinClass:json["cabinClass"],
        layover: json["layover"],
    );

    Map<String, dynamic> toJson() => {
        "company": company.toJson(),
        "flightNo": flightNo,
        "departure": departure.toJson(),
        "flight_time": flightTime,
        "arrival": arrival.toJson(),
        "numstops": numstops,
        "baggageInfo": List<dynamic>.from(baggageInfo.map((x) =>x)),
        "bookingClass": bookingClass,
        "cabinClass": cabinClass,
        "layover": layover,
    };
}

class Arrival {
    Arrival({
        required this.date,
        required this.time,
        required this.locationId,
        required this.timezone,
        required this.airport,
        required this.city,
        required this.terminal,
    });

    DateTime date;
    String time;
    String locationId;
    String? timezone;
    String airport;
    String city;
    bool terminal;

    factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        date: DateTime.parse(json["date"]),
        time: json["time"],
        locationId: json["locationId"],
        timezone: json["timezone"],
        airport: json["airport"],
        city: json["city"],
        terminal: json["terminal"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "locationId": locationId,
        "timezone": timezone,
        "airport": airport,
        "city": city,
        "terminal": terminal,
    };
}







class Company {
    Company({
        required this.marketingCarrier,
        required this.operatingCarrier,
        required this.logo,
    });

    String marketingCarrier;
    String? operatingCarrier;
    String logo;

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        marketingCarrier: json["marketingCarrier"],
        operatingCarrier: json["operatingCarrier"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "marketingCarrier": marketingCarrier,
        "operatingCarrier": operatingCarrier,
        "logo": logo,
    };
}



import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:sizer/sizer.dart';

import 'Model/login/user.dart';

Color background = const Color(0xffF1F1F1);
Color primaryblue = const Color(0xff0077CC);
Color black = const Color(0xff4a4a4a);
Color secBackground = const Color(0xffF6FBFF);
Color cardcolor = const Color(0xffffffff);
Color inCardColor = const Color(0xffBBBBBB);
Color yellowColor = const Color(0xffF9B629);
Color blackTextColor = const Color(0xff383838);
Color footerbuttoncolor = const Color(0xff0F294D);
Color greencolor = const Color(0xff91C34D);
Color orange = const Color.fromARGB(255, 241, 100, 55);

PackageInfo? packageInfo;

const baseUrl =
"https://mapi2.ibookholiday.com/api/v1/";
//"https://mapi.ibookholiday.com/api/v1/";
  //  "https://staging.ibookholiday.com/api/v1/";
//"http://192.168.0.180/ibookholiday/api/v1/";

//HAFEES
//'http://192.168.0.152/ibh-mob/api/v1/';

const onSignalAppId = "8e20d763-be21-4463-bf1f-b7f019c9959d";

enum PaymentBrands { visaMaster, mada, applePay }

Map<PaymentBrands, List<String>> brandData = {
  PaymentBrands.visaMaster: ["VISA", "MASTER"],
  PaymentBrands.mada: ["MADA"],
  PaymentBrands.applePay: ["APPLEPAY"]
};

PaymentBrands paymentBrand = PaymentBrands.visaMaster;

List<String> getPaymentType() => brandData[paymentBrand] ?? ["VISA", "MASTER"];

String appleMerchantId = "merchant.lamar-travel-merchant-live";

/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////        TEST          //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////

// String paymentToken = "OGFjN2E0Y2E4OGJiZjBkZjAxODhiZTllZjRkNzAzZmV8U0s4WFNYWlg1NA==";

// const String paymentUrl = 'https://test.oppwa.com/v1';
// Map<PaymentBrands, String> entityId = {
//   PaymentBrands.visaMaster: "8ac7a4ca88bbf0df0188be9fb0420403",
//   PaymentBrands.mada: "8ac7a4ca88bbf0df0188bea297600410",
//   PaymentBrands.applePay: "8ac7a4ca88bbf0df0188bea4bd050419"
// };

/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////    LIVE     //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////

  String paymentToken = "OGFjZGE0Y2E4YTJlODc3YTAxOGE0NWJlMjllODUxN2N8emtUUXk3eEFqUg==";
  const String paymentUrl = 'https://oppwa.com/v1';
  Map<PaymentBrands, String> entityId = {
    PaymentBrands.visaMaster: "8acda4cb8a45e016018a45f7272200f9",
    PaymentBrands.mada: "8acda4cb8a45e016018a4614f7c303e3",
    PaymentBrands.applePay: "8acda4c78afa8a3f018afedc61101659"
  };

String gencurrency = 'SAR';
String genlang = 'EN';

String fullName = '';

bool isFromBooking = false;

bool isLoginWithMedia = false;

late User users;

bool isLoggin = false;

double titleFontSize = 12.sp;
double subtitleFontSize = 10.sp;
double detailsFontSize = 9.sp;

List<String> currencyapi = [];

BoxShadow shadow = BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    blurRadius: 2,
    spreadRadius: 2,
    offset: const Offset(1, 1));
String dd =
    '{"code":422,"error":true,"message":"Prebook failed","data":{"payUrl":"","details":{"package_name":"London(5N) with Jack the Ripper Walking Tour","package_days":5,"flight":{"carriers":{"SV":"Saudi Arabian"},"selling_currency":"AED","max_stop":1,"start_date":"04 May 2022","end_date":"09 May 2022","travel_data":[{"travel_time":650,"numstops":1,"stops":["RUH"],"carriers":[{"code":"SV","name":"Saudi Arabian"}],"start":{"date":"2022-05-04","time":"22:30","locationId":"DXB","terminal":true,"timezone":"Asia/Dubai"},"end":{"date":"2022-05-05","time":"06:20","locationId":"LHR","terminal":true,"timezone":"Europe/London"},"itenerary":[{"company":{"marketingCarrier":"SV","operatingCarrier":"SV","logo":"https://mapi2.ibookholiday.com/flight/image/SV"},"flightNo":"553","departure":{"date":"2022-05-04","time":"22:30","locationId":"DXB","timezone":"Asia/Dubai","airport":"Dubai Intl Arpt","city":"Dubai","terminal":true},"flight_time":120,"arrival":{"date":"2022-05-04","time":"23:30","locationId":"RUH","timezone":"Asia/Riyadh","airport":"Riyadh King Khaled Intl Arpt","city":"Riyadh","terminal":true},"numstops":1,"baggageInfo":["1 Pieces / Person"],"bookingClass":"V","cabinClass":"M","layover":0},{"company":{"marketingCarrier":"SV","operatingCarrier":"SV","logo":"https://mapi2.ibookholiday.com/flight/image/SV"},"flightNo":"107","departure":{"date":"2022-05-05","time":"01:30","locationId":"RUH","timezone":"Asia/Riyadh","airport":"Riyadh King Khaled Intl Arpt","city":"Riyadh","terminal":true},"flight_time":410,"arrival":{"date":"2022-05-05","time":"06:20","locationId":"LHR","timezone":"Europe/London","airport":"Heathrow","city":"London","terminal":true},"numstops":1,"baggageInfo":["1 Pieces / Person"],"bookingClass":"V","cabinClass":"M","layover":120}]},{"travel_time":850,"numstops":1,"stops":["JED"],"carriers":[{"code":"SV","name":"Saudi Arabian"}],"start":{"date":"2022-05-09","time":"17:35","locationId":"LHR","terminal":true,"timezone":"Europe/London"},"end":{"date":"2022-05-10","time":"10:45","locationId":"DXB","terminal":true,"timezone":"Asia/Dubai"},"itenerary":[{"company":{"marketingCarrier":"SV","operatingCarrier":"SV","logo":"https://mapi2.ibookholiday.com/flight/image/SV"},"flightNo":"112","departure":{"date":"2022-05-09","time":"17:35","locationId":"LHR","timezone":"Europe/London","airport":"Heathrow","city":"London","terminal":true},"flight_time":360,"arrival":{"date":"2022-05-10","time":"01:35","locationId":"JED","timezone":"Asia/Riyadh","airport":"Jeddah Intl","city":"Jeddah","terminal":true},"numstops":1,"baggageInfo":["1 Pieces / Person"],"bookingClass":"V","cabinClass":"M","layover":0},{"company":{"marketingCarrier":"SV","operatingCarrier":"SV","logo":"https://mapi2.ibookholiday.com/flight/image/SV"},"flightNo":"566","departure":{"date":"2022-05-10","time":"06:55","locationId":"JED","timezone":"Asia/Riyadh","airport":"Jeddah Intl","city":"Jeddah","terminal":true},"flight_time":170,"arrival":{"date":"2022-05-10","time":"10:45","locationId":"DXB","timezone":"Asia/Dubai","airport":"Dubai Intl Arpt","city":"Dubai","terminal":true},"numstops":1,"baggageInfo":["1 Pieces / Person"],"bookingClass":"V","cabinClass":"M","layover":320}]}]},"total_amount":5365,"hotel":[{"name":"Britannia International Hotel Canary Wharf","starRating":"4","hotelImage":"https://mapi2.ibookholiday.com/image?key=eyJpdiI6IlEyczNhZktVU1Z5dDYyUFBTSmV5WXc9PSIsInZhbHVlIjoiRlN0TTk4TGdObEJQZVliQ2FYQjc4T0xpZGVLdzd4UXNqaEx4d3hrTkZDNWlBbmZtZmJoR2Fsak1XNmM2YWxTRXFnblNjazRFSjhSUjY2Zm9BL1hSNnUyN0xiQXMyZjZyTFBGRFVrMnFoaVNqVk5INENxMkIvZW1rY0pGbndQUHAiLCJtYWMiOiI2OTBjYjNiOGZjMWJhYWMyOGU3ODRmZmQwOTQ4NGQwY2YxZGIwZTQxZTdlZWQ5MTRlNmE0NWMzMDE1MTUzZmEwIiwidGFnIjoiIn0%3D"}],"transfer":[{"IN":{"date":"05 May 2022","time":"06:04 AM"},"OUT":{"date":"09 May 2022","time":"17:04 PM"}}],"activities":{"name":["Jack the Ripper Walking Tour","Illuminated London Walking Tour"]},"adults_count":1,"children_count":0,"infants_count":0,"no_flights":false,"no_hotels":false,"no_transfers":false,"no_activities":false},"holder":{"code":"UAE","email":"kllosheshe@gmail.com","phone":"2546664854","title":null,"firstName":"MoHaMed","lastname":"mahadi"},"passengers":[{"guestId":null,"guestType":null,"guestAgeType":"ADULT","guestTitle":"Mr.","guestName":"marcoa","guestSurame":"phex","guestDob":"2000-01-01","guestPassportIssue":"AO","guestPassportNo":"PO8386489","guestPassportExpiry":"2024-03-16","guestNationality":"AO","guestDobFormat":"2000-01-01","dob":"01/01/2000","guestPassportExpiryFormat":"2024-03-16T00:00:00.000Z","passportExpiry":"16/03/2024","guestNationalityName":"Angola","guestPassportIssueName":"Angola"}],"specialRequest":[{"interconnecting_rooms":false,"smoking_room":false,"non_smoking_room":false,"room_low_floor":false,"room_high_floor":false,"vip_guest":false,"honeymoon":false,"babycot":false,"birthday":false,"anniversary":false,"other_request":null}],"selectedSpecialRequests":[],"specialRequestComment":"","discountDetails":{"game_points":0,"discount_amount":0,"game_points_currency":"AED","customizeId":"624a9bd5938ac251471e393a","sellingCurrency":"AED","amount_before_discount":5365,"amount_after_discount":5365},"creditFlagStatus":{},"prebooked":false,"prebook_details":{"flights":{"prebook_success":true,"message":"Flight prebook success","details":[]},"hotels":{"prebook_success":true,"message":"Hotels prebook success","details":[]},"activites":{"prebook_success":false,"message":"Activity :Jack the Ripper Walking Tour on 2022-05-06 failed to prebook","details":[{"date":"2022-05-06","key":0,"details":{"name":"Jack the Ripper Walking Tour","searchId":"18095","code":"E-U02-GTTOURWT5","activity_id":"624a9bb66ddf974e020bb5db","modality_code":"408249719#GENERAL","modality_name":"Tour (18:00-19:30)","amountsFrom":[{"paxType":"ADULT","ageFrom":17,"ageTo":99,"amount":16.83,"boxOfficeAmount":19.66,"mandatoryApplyAmount":false},{"paxType":"CHILD","ageFrom":12,"ageTo":16,"amount":11.22,"boxOfficeAmount":13.11,"mandatoryApplyAmount":false}],"selling_currency":"AED","paybleCurency":"USD","net_amount":16.83,"modality_amount":68,"activity_date":"2022-05-06","questions":[{"code":"EMAIL","text":"Please, provide the email address","required":true}],"rateKey":"3m3bqdsd3sl96oamvn6b4naf4n","images":[{"visualizationOrder":1,"mimeType":"image/jpeg","urls":[{"dpi":72,"height":75,"width":100,"resource":"https://media.activitiesbank.com/12319/ENG/S/_A4P6224.jpg","sizeType":"SMALL"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/12319/ENG/XL/_A4P6224.jpg","sizeType":"XLARGE"},{"dpi":72,"height":480,"width":640,"resource":"https://media.activitiesbank.com/12319/ENG/B/_A4P6224.jpg","sizeType":"LARGE2"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/12319/ENG/LPP/_A4P6224.jpg","sizeType":"RAW"},{"dpi":72,"height":200,"width":267,"resource":"https://media.activitiesbank.com/12319/ENG/L/_A4P6224.jpg","sizeType":"LARGE"},{"dpi":72,"height":130,"width":173,"resource":"https://media.activitiesbank.com/12319/ENG/M/_A4P6224.jpg","sizeType":"MEDIUM"}]},{"visualizationOrder":2,"mimeType":"image/jpeg","urls":[{"dpi":72,"height":75,"width":100,"resource":"https://media.activitiesbank.com/12319/ENG/S/_A4P6185.jpg","sizeType":"SMALL"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/12319/ENG/XL/_A4P6185.jpg","sizeType":"XLARGE"},{"dpi":72,"height":480,"width":640,"resource":"https://media.activitiesbank.com/12319/ENG/B/_A4P6185.jpg","sizeType":"LARGE2"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/12319/ENG/LPP/_A4P6185.jpg","sizeType":"RAW"},{"dpi":72,"height":200,"width":267,"resource":"https://media.activitiesbank.com/12319/ENG/L/_A4P6185.jpg","sizeType":"LARGE"},{"dpi":72,"height":130,"width":173,"resource":"https://media.activitiesbank.com/12319/ENG/M/_A4P6185.jpg","sizeType":"MEDIUM"}]},{"visualizationOrder":3,"mimeType":"image/jpeg","urls":[{"dpi":72,"height":75,"width":100,"resource":"https://media.activitiesbank.com/12319/ENG/S/_A4P6120.jpg","sizeType":"SMALL"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/12319/ENG/XL/_A4P6120.jpg","sizeType":"XLARGE"},{"dpi":72,"height":480,"width":640,"resource":"https://media.activitiesbank.com/12319/ENG/B/_A4P6120.jpg","sizeType":"LARGE2"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/12319/ENG/LPP/_A4P6120.jpg","sizeType":"RAW"},{"dpi":72,"height":200,"width":267,"resource":"https://media.activitiesbank.com/12319/ENG/L/_A4P6120.jpg","sizeType":"LARGE"},{"dpi":72,"height":130,"width":173,"resource":"https://media.activitiesbank.com/12319/ENG/M/_A4P6120.jpg","sizeType":"MEDIUM"}]},{"visualizationOrder":4,"mimeType":"image/jpeg","urls":[{"dpi":72,"height":75,"width":100,"resource":"https://media.activitiesbank.com/12319/ENG/S/_A4P6079.jpg","sizeType":"SMALL"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/12319/ENG/XL/_A4P6079.jpg","sizeType":"XLARGE"},{"dpi":72,"height":480,"width":640,"resource":"https://media.activitiesbank.com/12319/ENG/B/_A4P6079.jpg","sizeType":"LARGE2"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/12319/ENG/LPP/_A4P6079.jpg","sizeType":"RAW"},{"dpi":72,"height":200,"width":267,"resource":"https://media.activitiesbank.com/12319/ENG/L/_A4P6079.jpg","sizeType":"LARGE"},{"dpi":72,"height":130,"width":173,"resource":"https://media.activitiesbank.com/12319/ENG/M/_A4P6079.jpg","sizeType":"MEDIUM"}]}],"bookingReference":"2204044A02","prebook":0,"prebooked_at":"2022-04-04 11:34:04","supplierReference":"164-5224587","supplier_currency":"USD","supplier_price":16.83}},{"date":"2022-05-07","key":1,"details":{"name":"Illuminated London Walking Tour","searchId":"18095","code":"E-U02-ILLLONTOUR","activity_id":"624a9bb66ddf974e020bb5fa","modality_code":"1610510470#TOUR@STANDARD|CAS|20:00","modality_name":"Tour spanish 20:00","amountsFrom":[{"paxType":"ADULT","ageFrom":16,"ageTo":999,"amount":15.4,"boxOfficeAmount":17.65,"mandatoryApplyAmount":true},{"paxType":"CHILD","ageFrom":7,"ageTo":15,"amount":12.55,"boxOfficeAmount":14.39,"mandatoryApplyAmount":true},{"paxType":"CHILD","ageFrom":0,"ageTo":6,"amount":0,"boxOfficeAmount":0,"mandatoryApplyAmount":true}],"selling_currency":"AED","paybleCurency":"USD","net_amount":15.4,"modality_amount":63,"activity_date":"2022-05-07","questions":[],"rateKey":"pmf5vbs67qhmdh1tplc1kqccah","images":[{"visualizationOrder":1,"mimeType":"image/jpeg","urls":[{"dpi":72,"height":75,"width":100,"resource":"https://media.activitiesbank.com/35118/ENG/S/35118_1.jpg","sizeType":"SMALL"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/XL/35118_1.jpg","sizeType":"XLARGE"},{"dpi":72,"height":480,"width":640,"resource":"https://media.activitiesbank.com/35118/ENG/B/35118_1.jpg","sizeType":"LARGE2"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/LPP/35118_1.jpg","sizeType":"RAW"},{"dpi":72,"height":200,"width":267,"resource":"https://media.activitiesbank.com/35118/ENG/L/35118_1.jpg","sizeType":"LARGE"},{"dpi":72,"height":130,"width":173,"resource":"https://media.activitiesbank.com/35118/ENG/M/35118_1.jpg","sizeType":"MEDIUM"}]},{"visualizationOrder":2,"mimeType":"image/jpeg","urls":[{"dpi":72,"height":75,"width":100,"resource":"https://media.activitiesbank.com/35118/ENG/S/35118_2.jpg","sizeType":"SMALL"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/XL/35118_2.jpg","sizeType":"XLARGE"},{"dpi":72,"height":480,"width":640,"resource":"https://media.activitiesbank.com/35118/ENG/B/35118_2.jpg","sizeType":"LARGE2"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/LPP/35118_2.jpg","sizeType":"RAW"},{"dpi":72,"height":200,"width":267,"resource":"https://media.activitiesbank.com/35118/ENG/L/35118_2.jpg","sizeType":"LARGE"},{"dpi":72,"height":130,"width":173,"resource":"https://media.activitiesbank.com/35118/ENG/M/35118_2.jpg","sizeType":"MEDIUM"}]},{"visualizationOrder":3,"mimeType":"image/jpeg","urls":[{"dpi":72,"height":75,"width":100,"resource":"https://media.activitiesbank.com/35118/ENG/S/35118_3.jpg","sizeType":"SMALL"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/XL/35118_3.jpg","sizeType":"XLARGE"},{"dpi":72,"height":480,"width":640,"resource":"https://media.activitiesbank.com/35118/ENG/B/35118_3.jpg","sizeType":"LARGE2"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/LPP/35118_3.jpg","sizeType":"RAW"},{"dpi":72,"height":200,"width":267,"resource":"https://media.activitiesbank.com/35118/ENG/L/35118_3.jpg","sizeType":"LARGE"},{"dpi":72,"height":130,"width":173,"resource":"https://media.activitiesbank.com/35118/ENG/M/35118_3.jpg","sizeType":"MEDIUM"}]},{"visualizationOrder":4,"mimeType":"image/jpeg","urls":[{"dpi":72,"height":75,"width":100,"resource":"https://media.activitiesbank.com/35118/ENG/S/35118_4.jpg","sizeType":"SMALL"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/XL/35118_4.jpg","sizeType":"XLARGE"},{"dpi":72,"height":480,"width":640,"resource":"https://media.activitiesbank.com/35118/ENG/B/35118_4.jpg","sizeType":"LARGE2"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/LPP/35118_4.jpg","sizeType":"RAW"},{"dpi":72,"height":200,"width":267,"resource":"https://media.activitiesbank.com/35118/ENG/L/35118_4.jpg","sizeType":"LARGE"},{"dpi":72,"height":130,"width":173,"resource":"https://media.activitiesbank.com/35118/ENG/M/35118_4.jpg","sizeType":"MEDIUM"}]},{"visualizationOrder":5,"mimeType":"image/jpeg","urls":[{"dpi":72,"height":75,"width":100,"resource":"https://media.activitiesbank.com/35118/ENG/S/35118_5.jpg","sizeType":"SMALL"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/XL/35118_5.jpg","sizeType":"XLARGE"},{"dpi":72,"height":480,"width":640,"resource":"https://media.activitiesbank.com/35118/ENG/B/35118_5.jpg","sizeType":"LARGE2"},{"dpi":72,"height":768,"width":1024,"resource":"https://media.activitiesbank.com/35118/ENG/LPP/35118_5.jpg","sizeType":"RAW"},{"dpi":72,"height":200,"width":267,"resource":"https://media.activitiesbank.com/35118/ENG/L/35118_5.jpg","sizeType":"LARGE"},{"dpi":72,"height":130,"width":173,"resource":"https://media.activitiesbank.com/35118/ENG/M/35118_5.jpg","sizeType":"MEDIUM"}]}],"bookingReference":"2204045A01","prebook":0,"prebooked_at":"2022-04-04 11:34:22","supplierReference":"164-5224588","supplier_currency":"USD","supplier_price":15.4}}]},"transfers":{"prebook_success":false,"message":"Transfer : Private Standard Car on 2022-05-05 06:20 failed to prebook","details":[{"date":"2022-05-05","key":0,"details":{"_id":"624a9bc208af4f42cd54a492","search_code":"18148","type":"IN","group":"00","date":"2022-05-05","time":"06:20","currency":"AED","payable_currency":"USD","net_amount":113.93,"total_amount":419,"selling_price":113.93,"service_type_code":"PRVT","service_type_name":"Private","product_type_name":"Standard","vehicle_type_name":"Car","units":1,"prebook":0,"supplier_currency":"USD","supplier_price":"113.93"}},{"date":"2022-05-09","key":1,"details":{"_id":"624a9bc208af4f42cd54a493","search_code":"18148","type":"OUT","group":"00","date":"2022-05-09","time":"17:35","currency":"AED","payable_currency":"USD","net_amount":98.74,"total_amount":363,"selling_price":98.74,"service_type_code":"PRVT","service_type_name":"Private","product_type_name":"Standard","vehicle_type_name":"Car","units":1,"prebook":0,"supplier_currency":"USD","supplier_price":"98.74"}}]}}}}';

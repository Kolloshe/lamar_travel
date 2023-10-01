// ignore_for_file: empty_catches

import 'dart:developer';

import 'package:flutter/material.dart';
import '../Assistants/assistant_methods.dart';
import '../Datahandler/app_data.dart';
import '../Model/payload.dart';
import '../Model/searchforflight.dart';
import '../Model/searchforhotel.dart';
import 'package:provider/provider.dart';

class SearchFrom extends SearchDelegate<String> {
  String result = '';
  String subt = '';
  final cities = [
    "Andorra la Vella",
    "Umm al Qaywayn",
    "Ras al-Khaimah",
    "Khawr Fakkān",
    "Dubai",
    "Dibba Al-Fujairah",
    "Dibba Al-Hisn",
    "Sharjah",
    "Ar Ruways",
    "Al Fujayrah",
    "Al Ain",
    "Ajman",
    "Adh Dhayd",
    "Abu Dhabi",
    "Zaranj",
    "Taloqan",
    "Shīnḏanḏ",
    "Shibirghān",
    "Shahrak",
    "Sar-e Pul",
    "Sang-e Chārak",
    "Aībak",
    "Rustāq",
    "Qarqīn",
    "Qarāwul",
    "Pul-e Khumrī",
    "Paghmān",
    "Nahrīn",
    "Maymana",
    "Mehtar Lām",
    "Mazār-e Sharīf",
    "Lashkar Gāh",
    "Kushk",
    "Kunduz",
    "Khōst",
    "Khulm",
    "Khāsh",
    "Khanabad",
    "Karukh",
    "Kandahār",
    "Kabul",
    "Jalālābād",
    "Jabal os Saraj",
    "Herāt",
    "Ghormach",
    "Ghazni",
    "Gereshk",
    "Gardēz",
    "Fayzabad",
    "Farah",
    "Kafir Qala",
  ];
  final recentCities = [
    "Khawr Fakkān",
    "Dubai",
    "Dibba Al-Fujairah",
    "Dibba Al-Hisn",
    "Sharjah",
    "Ar Ruways",
    "Al Fujayrah",
  ];

 
  List<Object> resultList = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    //action for app bar
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        onPressed: () {
          close(context, 'Where From ?');
        },
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ));
  }

  List<PayloadElement> payloadList = [];
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: AssistantMethods.searchfrom(query, context),
        builder: (context, snap) {
          if (query.isNotEmpty && snap.hasData) {
            try {
              payloadList = snap.data as List<PayloadElement>;
              payloadList = payloadList
                  .where((element) =>
                      element.cityName
                          .toLowerCase()
                          .startsWith(query.toLowerCase().trimRight().trimLeft()) ||
                      element.countryName
                          .toLowerCase()
                          .startsWith(query.toLowerCase().trimRight().trimLeft()))
                  .toList();
              payloadList = [
                ...{...payloadList}
              ];
            } catch (e) {}
          }

          return payloadList.isNotEmpty
              ? ListView.builder(
                  itemCount:
                      payloadList.isNotEmpty ? payloadList.length : 0, //suggestionList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                     
                        result = payloadList.elementAt(index).cityName;
                        subt = payloadList.elementAt(index).countryName;

                        resultList = payloadList;
                        Provider.of<AppData>(context, listen: false)
                            .getpayloadFrom(payloadList.elementAt(index));
                        close(context, result);
                      },
                      subtitle: Text("${payloadList[index].countryName} ${payloadList[index].destinationName}"),

                      //Text(payloadList[index].countryName),
                      leading: const Icon(Icons.location_city),
                      title: RichText(
                        text: TextSpan(
                          text: payloadList[index].cityName.length >= query.length
                              ? payloadList[index].cityName.substring(0, query.length)
                              : payloadList[index].cityName,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: payloadList[index].cityName.length >= query.length
                                  ? payloadList[index].cityName.substring(query.length)
                                  : '',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: Text(''),
                );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: AssistantMethods.searchfrom(query, context),
        builder: (context, snap) {
          if (query.isNotEmpty && snap.hasData) payloadList = snap.data as List<PayloadElement>;
          payloadList = payloadList
              .where((element) =>
                  element.cityName
                      .toLowerCase()
                      .startsWith(query.toLowerCase().trimLeft().trimRight()) ||
                  element.countryName
                      .toLowerCase()
                      .startsWith(query.toLowerCase().trimLeft().trimRight()))
              .toList();
          payloadList = [
            ...{...payloadList}
          ];

          return ListView.builder(
              itemCount: payloadList.isNotEmpty ? payloadList.length : 0, //suggestionList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    result = payloadList.elementAt(index).cityName;
                    subt = payloadList.elementAt(index).countryName;

                    resultList = payloadList;
                    Provider.of<AppData>(context, listen: false)
                        .getpayloadFrom(payloadList.elementAt(index));
                    close(context, result);
                  },
                  subtitle: Text(
                      "${payloadList[index].countryName} ${payloadList[index].destinationName}"),

                  //Text(payloadList[index].countryName),
                  leading: const Icon(Icons.location_city),
                  title: RichText(
                    text: TextSpan(
                      text: payloadList[index].cityName.length >= query.length
                          ? payloadList[index].cityName.substring(0, query.length)
                          : payloadList[index].cityName,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: payloadList[index].cityName.length >= query.length
                              ? payloadList[index].cityName.substring(query.length)
                              : '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

class Searchto extends SearchDelegate<String> {
  String result = '';
  String subt = '';
  String citycode = '';
  final cities = [
    "Andorra la Vella",
    "Umm al Qaywayn",
    "Ras al-Khaimah",
    "Khawr Fakkān",
    "Dubai",
    "Dibba Al-Fujairah",
    "Dibba Al-Hisn",
    "Sharjah",
    "Ar Ruways",
    "Al Fujayrah",
    "Al Ain",
    "Ajman",
    "Adh Dhayd",
    "Abu Dhabi",
    "Zaranj",
    "Taloqan",
    "Shīnḏanḏ",
    "Shibirghān",
    "Shahrak",
    "Sar-e Pul",
    "Sang-e Chārak",
    "Aībak",
    "Rustāq",
    "Qarqīn",
    "Qarāwul",
    "Pul-e Khumrī",
    "Paghmān",
    "Nahrīn",
    "Maymana",
    "Mehtar Lām",
    "Mazār-e Sharīf",
    "Lashkar Gāh",
    "Kushk",
    "Kunduz",
    "Khōst",
    "Khulm",
    "Khāsh",
    "Khanabad",
    "Karukh",
    "Kandahār",
    "Kabul",
    "Jalālābād",
    "Jabal os Saraj",
    "Herāt",
    "Ghormach",
    "Ghazni",
    "Gereshk",
    "Gardēz",
    "Fayzabad",
    "Farah",
    "Kafir Qala",
  ];
  final recentCities = [
    "Khawr Fakkān",
    "Dubai",
    "Dibba Al-Fujairah",
    "Dibba Al-Hisn",
    "Sharjah",
    "Ar Ruways",
    "Al Fujayrah",
  ];
  List<Object> resultList = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    //action for app bar
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        onPressed: () {
          close(context, 'Where To ?');
        },
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ));
  }

  List<PayloadElement> payloadList = [];
  @override
  Widget buildSuggestions(BuildContext context) {
    // AssistantMethods.searchfrom(query, context);

    // payloadList = Provider.of<AppData>(context, listen: false).cities;

    // if (query.isNotEmpty) {
    //   payloadList.forEach((i) {
    //     subtitle.add(payloadList[ind].countryName);
    //     citiyName.add(payloadList[ind].cityName);
    //     ind++;
    //   });
    // }

    return FutureBuilder(
        future: AssistantMethods.searchfrom(query, context),
        builder: (context, snap) {
          if (query.isNotEmpty && snap.hasData) payloadList = snap.data as List<PayloadElement>;
          payloadList = payloadList
              .where((element) =>
                  element.cityName
                      .toLowerCase()
                      .startsWith(query.toLowerCase().trimRight().trimLeft()) ||
                  element.countryName
                      .toLowerCase()
                      .startsWith(query.toLowerCase().trimRight().trimLeft()))
              .toList();
          payloadList = [
            ...{...payloadList}
          ];

          return ListView.builder(
              itemCount: payloadList.isNotEmpty ? payloadList.length : 0, //suggestionList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    result = payloadList.elementAt(index).cityName;
                    subt = payloadList.elementAt(index).countryName;

                    resultList = payloadList;
                    Provider.of<AppData>(context, listen: false)
                        .getpayloadTo(payloadList.elementAt(index));
                    close(context, result);
                  },
                  subtitle: Text(
                      "${payloadList[index].countryName} ${payloadList[index].destinationName}"),

                  //Text(payloadList[index].countryName),
                  leading: const Icon(Icons.location_city),
                  title: RichText(
                    text: TextSpan(
                      text: payloadList[index].cityName.length >= query.length
                          ? payloadList[index].cityName.substring(0, query.length)
                          : payloadList[index].cityName,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: payloadList[index].cityName.length >= query.length
                              ? payloadList[index].cityName.substring(query.length)
                              : '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: AssistantMethods.searchfrom(query, context),
        builder: (context, snap) {
          if (query.isNotEmpty && snap.hasData) payloadList = snap.data as List<PayloadElement>;
          payloadList = payloadList
              .where((element) =>
                  element.cityName
                      .toLowerCase()
                      .startsWith(query.toLowerCase().trimLeft().trimRight()) ||
                  element.countryName
                      .toLowerCase()
                      .startsWith(query.toLowerCase().trimLeft().trimRight()))
              .toList();
          payloadList = [
            ...{...payloadList}
          ];

          return ListView.builder(
              itemCount: payloadList.isNotEmpty ? payloadList.length : 0, //suggestionList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    result = payloadList.elementAt(index).cityName;
                    subt = payloadList.elementAt(index).countryName;

                    resultList = payloadList;
                    Provider.of<AppData>(context, listen: false)
                        .getpayloadTo(payloadList.elementAt(index));
                    close(context, result);
                  },
                  subtitle: Text(
                      "${payloadList[index].countryName} ${payloadList[index].destinationName}"),

                  //Text(payloadList[index].countryName),
                  leading: const Icon(Icons.location_city),
                  title: RichText(
                    text: TextSpan(
                      text: payloadList[index].cityName.length >= query.length
                          ? payloadList[index].cityName.substring(0, query.length)
                          : payloadList[index].cityName,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: payloadList[index].cityName.length >= query.length
                              ? payloadList[index].cityName.substring(query.length)
                              : '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

class SearchFlight extends SearchDelegate<String> {
  String result = '';
  String code = '';
  List<FlightList> flight = [];

  void waiting(BuildContext context) async {
    if (Provider.of<AppData>(context, listen: false).searchforflight != null) {
      flight = Provider.of<AppData>(context, listen: false).searchforflight!.data.flights;
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
                result,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Provider.of<AppData>(context, listen: false).getselectedflightcode(code);
                close(context, result);
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<Searchforflight?>(
        future:   AssistantMethods.searchingFlight(query, context),
        builder: (context,snap){

          final suggestionList =
          !snap.hasData
              ? []
              : snap.data!.flights
              .where((element) => element.name.toLowerCase().trim().startsWith(query.toLowerCase().trim()))
              .toList();
          return ListView.builder(
        itemCount:  snap.hasData ? suggestionList.length : 0,
        itemBuilder: (context, index) {

          return ListTile(
          onTap: () {
            log(suggestionList.elementAt(index). toJson().toString());
            showResults(context);
            result = suggestionList.elementAt(index).name;
            code = suggestionList.elementAt(index).code;
          },
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].name.substring(0, query.length),
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].name.substring(query.length),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
        });
        }
    );
    //
    // if (query.isNotEmpty) {
    //   AssistantMethods.searchingFlight(query, context);
    //
    //   waiting(context);
    // }else{
    //   AssistantMethods.searchingFlight('a', context);
    // }
    //
    // final suggestionList = query.isEmpty
    //     ? []
    //     : flight
    //          .where((element) => element.name.toLowerCase().trim().contains(query.toLowerCase().trim())).where((element) => element.name.toLowerCase().trim().startsWith(query.toLowerCase().trim()))
    //          .toList();


  }
}

class SearchHotel extends SearchDelegate<String> {
  String result = '';
  String code = '';
  List<HotelList> hotel = [];


  void waiting(BuildContext context) async {
    if (Provider.of<AppData>(context, listen: false).searchforhotel.status.message == "Success") {
      hotel =  Provider.of<AppData>(context, listen: false).searchforhotel.data.hotels;
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
                result,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Provider.of<AppData>(context, listen: false).getselectedHotelcode(code);
                close(context, result);
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {

return FutureBuilder<Searchforhotel?>(
    future:  AssistantMethods.searchHotel(query, context),
    builder: (context,snap){

  final suggestionList = !snap.hasData
      ? []
      : snap.data!.data.hotels
       .where((element) => element.name.toLowerCase().trim().startsWith(query.toLowerCase().trim()))
       .toList();
  return ListView.builder(
    itemCount:suggestionList.isNotEmpty? suggestionList.length : 0,
    itemBuilder: (context, index) => ListTile(
      onTap: () {
        showResults(context);
        result = suggestionList.elementAt(index).name;
        code = suggestionList.elementAt(index).code;
      },
      title: RichText(
        text: TextSpan(
          text: suggestionList[index].name.substring(0, query.length),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: suggestionList[index].name.substring(query.length),
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    ));});






  }
}

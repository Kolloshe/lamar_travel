// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/ind_transfer_search_model.dart';
import 'package:provider/src/provider.dart';

class IndTransferSearchTo extends SearchDelegate {
  var x = SearchController();

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isNotEmpty) {
                query = '';
              } else {
                close(context, null);
              }
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null), icon: const Icon(Icons.keyboard_arrow_left));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<IndTransferSearchModel?>(
        future: x.fetchData(context, query),
        builder: (context, val) {
          switch (val.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              break;
          }
          return ListView(
            children: [
              for (int i = 0; i < (val.data?.data.length ?? 1); i++)
                ListTile(
                  title: Text(val.data?.data[i].label ?? ''),
                  subtitle: Text(val.data?.data[i].category ?? ''),
                  leading: Icon(val.data?.data[i].category.toLowerCase() == 'hotel'
                      ? Icons.hotel
                      : Icons.airplanemode_active),
                  minLeadingWidth: 20,
                  onTap: () {
                    close(context, val.data!.data[i]);
                  },
                ),
            ],
          );
        });
  }
}

class SearchController {
  int len = 0;
  IndTransferSearchModel? res;

  void getInitData(BuildContext context) async {
    res = await AssistantMethods.getIndTransferSearch(
        'dubai',
        context.read<AppData>().payloadWhichCityForTransfer!.id,
        context.read<AppData>().payloadWhichCityForTransfer!.airportCode,
        context.read<AppData>().payloadWhichCityForTransfer!.cityName);
  }

  Future<IndTransferSearchModel?> fetchData(BuildContext context, String q) async {
    int newLen = q.length;
    if (newLen - len > 2) {
      res = await AssistantMethods.getIndTransferSearch(
          q,
          context.read<AppData>().payloadWhichCityForTransfer!.id,
          context.read<AppData>().payloadWhichCityForTransfer!.airportCode,
          context.read<AppData>().payloadWhichCityForTransfer!.cityName);

      len = newLen;
      return res;
    } else {
      if (len - newLen > 2) {
        len = 0;
      }
      return res;
    }
  }
}

// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:provider/provider.dart';
import '../config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StreetView extends StatefulWidget {
  StreetView(
      {Key? key,
      required this.lat,
      required this.lon,
      required this.isFromCus,
      required this.isfromHotel})
      : super(key: key);
  final double lat;
  final double lon;
  bool? isFromCus;
  bool isfromHotel;

  @override
  _StreetViewState createState() => _StreetViewState();
}

class _StreetViewState extends State<StreetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: cardcolor,
        title: Text(
          AppLocalizations.of(context)!.streetview,
          style: TextStyle(color: Colors.black, fontSize: titleFontSize),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (widget.isFromCus != null) {
              if (widget.isFromCus!) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
              } else {
                Navigator.of(context).pop();
              }
            } else {
              if (widget.isfromHotel) {
                Navigator.of(context).pop();
              }
            }
          },
          icon: Icon(
            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right,
            size: 35,
            color: primaryblue,
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(children: [
        FlutterGoogleStreetView(
            initSource: StreetViewSource.outdoor,
            initPos: LatLng(widget.lat, widget.lon),
            zoomGesturesEnabled: true,
            onStreetViewCreated: (StreetViewController controller) async {
              controller.animateTo(duration: 750, camera: StreetViewPanoramaCamera());
            }),
        //
        // Positioned(
        // top: 1,
        // right: 10,
        // child: Container(
        //   decoration: BoxDecoration(shape: BoxShape.circle, color: primaryblue),
        //   padding: EdgeInsets.all(0),
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.clear,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context)
        //           .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
        //     },
        //   ),
        // ))
        //
      ])),
    );
  }
}

// ignore_for_file: file_names, library_private_types_in_public_api, unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../config.dart';

class GoogleMapDialog extends StatefulWidget {
  const GoogleMapDialog({Key? key, required this.lat, required this.lon})
      : super(key: key);

  final double lat;
  final double lon;

  @override
  _GoogleMapDialogState createState() => _GoogleMapDialogState();
}

class _GoogleMapDialogState extends State<GoogleMapDialog> {
  late Set<Marker> _marker;

  addmarker() {
    _marker = {
      Marker(
          markerId: const MarkerId('hotiId'),
          position: LatLng(widget.lat, widget.lon))
    };
  }

  final Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    addmarker();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: GoogleMap(
              markers: _marker,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.lon),
                  zoom: 15.151926040649414),
            ),
          ),
          Positioned(
              right: 3,
              top: 5,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.cancel,
                    color: primaryblue,
                  ))),
        ],
      ),
    );
  }
}

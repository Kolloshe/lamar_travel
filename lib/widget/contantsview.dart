// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../config.dart';
import 'loading.dart';
import 'package:sizer/sizer.dart';

class ContanintViwe extends StatefulWidget {
  const ContanintViwe(
      {Key? key, required this.body, required this.title, this.urlImage, required this.d})
      : super(key: key);
  final String body;
  final String title;
  final String? urlImage;
  final PackageHotels d;

  @override
  _ContanintViweState createState() => _ContanintViweState();
}

class _ContanintViweState extends State<ContanintViwe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.d.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                ? 'Lato'
                : 'Bhaijaan',
          ),
        ),
        elevation: 0.1,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
            },
            child: Icon(
              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              color: primaryblue,
              size: 26,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
              width: 100.w,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.urlImage!,
                placeholder: (context, url) => const Center(
                  child: LoadingWidgetMain(),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/image-not-available.png'),
              ),
            ),
            SizedBox(
              height: 64.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: '${AppLocalizations.of(context)!.yourhotel} : \n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blackTextColor,
                          fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                  const Locale('en')
                              ? 'Lato'
                              : 'Bhaijaan',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${widget.d.name}\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan',
                              )),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: '${AppLocalizations.of(context)!.viewHotelDetails} : \n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blackTextColor,
                          fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                  const Locale('en')
                              ? 'Lato'
                              : 'Bhaijaan',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${widget.d.description}\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan',
                              )),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: '${AppLocalizations.of(context)!.hotelAddress} : \n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blackTextColor,
                          fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                  const Locale('en')
                              ? 'Lato'
                              : 'Bhaijaan',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${widget.d.destinationCode}-${widget.d.address}\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan',
                              )),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: '${AppLocalizations.of(context)!.hotelFacilities} : \n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blackTextColor,
                          fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                  const Locale('en')
                              ? 'Lato'
                              : 'Bhaijaan',
                        ),
                        children: <TextSpan>[
                          for (var i = 0; i < widget.d.facilities.length; i++)
                            TextSpan(
                                text: '${widget.d.facilities[i]}\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                          const Locale('en')
                                      ? 'Lato'
                                      : 'Bhaijaan',
                                )),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: '${AppLocalizations.of(context)!.checkIn} : \n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blackTextColor,
                          fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                  const Locale('en')
                              ? 'Lato'
                              : 'Bhaijaan',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${widget.d.checkInText}\n\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan',
                              )),
                          TextSpan(
                              text: '${AppLocalizations.of(context)!.checkOut} : \n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan',
                              )),
                          TextSpan(
                              text: '${widget.d.checkOutText}\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan',
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:provider/provider.dart';
import '../Datahandler/adaptive_texts_size.dart';
import '../config.dart';
import 'image_spinnig.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Trending extends StatelessWidget {
  const Trending({Key? key, required this.label, required this.image, required this.cityName})
      : super(key: key);
  final String label;
  final String image;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          // color: cardcolor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [shadow],
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SizedBox(
              width: size.width * 0.6,
              height: size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: size.width * 0.6,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                      child: ImageSpinning(
                    withOpasity: true,
                  )),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/image-not-available.png'),
                ),
              ),
            ),
            Positioned(
              left: Provider.of<AppData>(context, listen: false).locale == const Locale('en') ? 0 : null,
              right: Provider.of<AppData>(context, listen: false).locale == const Locale('en') ? null : 0,
              top: 1.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(
                      topLeft: Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? const Radius.circular(16)
                          : const Radius.circular(0),
                      topRight: Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? const Radius.circular(0)
                          : const Radius.circular(16),
                    )),
                child: RichText(
                  text: TextSpan(
                    text: cityName.characters.first.toUpperCase() + cityName.substring(1),
                    style: TextStyle(
                      fontFamily:
                          Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                              ? 'Lato'
                              : 'Bhaijaan',
                      fontWeight: FontWeight.bold,
                      fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 1,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Align(
                        alignment:
                            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                        child: Text(
                          '${AppLocalizations.of(context)!.nightCount(3)} | ${AppLocalizations.of(context)!.dayCount(4)}',
                          style: TextStyle(
                            color: yellowColor,
                            fontWeight: FontWeight.w700,
                            fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.55,
                      child: Align(
                        alignment:
                            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                        child: Text(
                          Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                              ? 'Holiday packages in $label'
                              : "إحجز عطله في $label",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                              color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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

class BudgetTravelpackages extends StatefulWidget {
  const BudgetTravelpackages({Key? key, required this.label, required this.image, required this.cityName})
      : super(key: key);
  final String label;
  final String image;
  final String cityName;

  //final Color color;

  @override
  _BudgetTravelpackagesState createState() => _BudgetTravelpackagesState();
}

class _BudgetTravelpackagesState extends State<BudgetTravelpackages> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.40,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                      child: ImageSpinning(
                    withOpasity: true,
                  )),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/image-not-available.png'),
                ),
              ),
            ),
            Positioned(
              left: Provider.of<AppData>(context, listen: false).locale == const Locale('en') ? 0 : null,
              right: Provider.of<AppData>(context, listen: false).locale == const Locale('en') ? null : 0,
              top: 0.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                      topLeft: Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? const Radius.circular(15)
                          : const Radius.circular(0),
                      topRight: Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? const Radius.circular(0)
                          : const Radius.circular(15)),
                ),
                child: RichText(
                  text: TextSpan(
                    text: widget.cityName.characters.first.toUpperCase() +
                        widget.cityName.substring(1),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily:
                          Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                              ? 'Lato'
                              : 'Bhaijaan',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                alignment: Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                width: size.width - 10,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15), bottomRight: Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Align(
                        alignment:
                            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                        child: Text(
                          "${AppLocalizations.of(context)!.nightCount(3)} | ${AppLocalizations.of(context)!.dayCount(4)}",
                          style: TextStyle(
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 40),
                              color: yellowColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                        Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                            ? 'Holiday packages in ${widget.cityName}'
                            : "إحجز عطله في ${widget.cityName}",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 40),
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Text(,style: TextStyle(fontWeight: FontWeight.w500,fontSize:AdaptiveTextSize().getadaptiveTextSize(context, 30) ),),
          ],
        ));
  }
}

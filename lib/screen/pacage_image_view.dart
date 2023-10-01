// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/mainsearch.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sizer/sizer.dart';

class PackageImageView extends StatefulWidget {
  const PackageImageView({
    Key? key,
    required this.hotelImages,
  }) : super(key: key);
  final List<HotelImage> hotelImages;

  @override
  _PackageImageViewState createState() => _PackageImageViewState();
}

class _PackageImageViewState extends State<PackageImageView> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardcolor,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: cardcolor,
        title: Text(
          AppLocalizations.of(context)!.packageDescription,
          style: TextStyle(color: Colors.black, fontSize: titleFontSize),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: widget.hotelImages
                    .map(
                      (e) => CachedNetworkImage(
                        imageUrl: e.src.trimLeft(),
                        imageBuilder: (context, url) => Container(
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              e.src.trimLeft(),
                              fit: BoxFit.fitHeight,
                              width: 100.w,
                              height: 40.h,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const ImageSpinning(
                          withOpasity: true,
                        ),
                        errorWidget: (context, erorr, x) => Image.asset('assets/images/image.jpeg',
                            fit: BoxFit.cover, width: 100.w, height: 40.h),
                      ),
                    )
                    .toList(),
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  height: 70.h,
                  viewportFraction: 0.9,
                  aspectRatio: 4 / 3,
                  initialPage: 0,
                  autoPlay: false,
                  // scrollPhysics: ScrollPhysics(parent: )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                    onTap: () {
                      buttonCarouselController.previousPage(
                          duration: const Duration(milliseconds: 300), curve: Curves.linear);
                    },
                    icons: genlang == 'EN'
                        ? Icons.keyboard_arrow_left_rounded
                        : Icons.keyboard_arrow_right),
                _buildButton(
                    onTap: () {
                      buttonCarouselController.nextPage(
                          duration: const Duration(milliseconds: 300), curve: Curves.linear);
                    },
                    icons: genlang == 'EN'
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left_rounded),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required VoidCallback onTap, required IconData icons}) => InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: primaryblue,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(5.sp),
          child: Icon(
            icons,
            color: cardcolor,
          ),
        ),
      );
}

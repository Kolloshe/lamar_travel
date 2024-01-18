import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';

import 'image_spinnig.dart';

class PlaceImagesPageView extends StatefulWidget {
  const PlaceImagesPageView({
    Key? key,
    required this.imagesUrl,
  }) : super(key: key);

  final List<String> imagesUrl;

  @override
  State<PlaceImagesPageView> createState() => _PlaceImagesPageViewState();
}

class _PlaceImagesPageViewState extends State<PlaceImagesPageView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, PackagesScreen.idScreen, (route) => false);
        return Future.value(true);
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: widget.imagesUrl.length,
                  onPageChanged: (value) {
                    setState(() => currentIndex = value);
                  },
                  physics: const BouncingScrollPhysics(),
                  controller: PageController(viewportFraction: .9),
                  itemBuilder: (context, index) {
                    final imageUrl = widget.imagesUrl[index];
                    final isSelected = currentIndex == index;
                    return CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => const Center(
                          child: ImageSpinning(
                        withOpasity: true,
                      )),
                      errorWidget: (context, url, error) => AnimatedContainer(
                        duration: kThemeAnimationDuration,
                        margin: EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: isSelected ? 5 : 20,
                          bottom: isSelected ? 5 : 20,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/image.jpeg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black26,
                              BlendMode.softLight,
                            ),
                          ),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => AnimatedContainer(
                        duration: kThemeAnimationDuration,
                        margin: EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: isSelected ? 5 : 20,
                          bottom: isSelected ? 5 : 20,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Colors.black26,
                              BlendMode.softLight,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

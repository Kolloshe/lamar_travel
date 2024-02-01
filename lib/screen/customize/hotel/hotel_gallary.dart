import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HotelGallary extends StatefulWidget {
  const HotelGallary({super.key, required this.images});
  final Map<int, String> images;

  @override
  State<HotelGallary> createState() => _HotelGallaryState();
}

class _HotelGallaryState extends State<HotelGallary> {
  int index = 0;

  final bottonController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  index = value;
                  bottonController.animateTo(index.toDouble() * 83,
                      duration:const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                  setState(() {});
                },
                children: [
                  for (int i = 0; i < widget.images.length; i++)
                    CachedNetworkImage(
                      imageUrl: widget.images[i] ?? "",
                      height: 70.h,
                      fit: BoxFit.contain,
                    )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
              width: 100.w,
              child: ListView.builder(
                controller: bottonController,
                itemCount: widget.images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: index == i ? Colors.black : Colors.transparent)),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 20.w,
                    height: 20.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: widget.images[i] ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

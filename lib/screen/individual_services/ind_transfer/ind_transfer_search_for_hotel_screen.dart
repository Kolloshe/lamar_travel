// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/ind_transfer_search_model.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/widget/individual_products/search_transfer_delegate.dart';
import 'package:sizer/sizer.dart';

class IndTransferSearchForHotel extends StatefulWidget {
  const IndTransferSearchForHotel({Key? key}) : super(key: key);

  @override
  _IndTransferSearchForHotelState createState() => _IndTransferSearchForHotelState();
}

class _IndTransferSearchForHotelState extends State<IndTransferSearchForHotel> {
  final searchController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Search for transfer',
            style: TextStyle(fontSize: 12.sp),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildSearchBox()

              // Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(Icons.adjust),
              //       Spacer(),
              //       SizedBox(width: 85.w, height: 5.h, child: _buildInputField()),
              //     ]),
              // Container(height: 3.h,width: 0,decoration: BoxDecoration(border: Border.all()),)
              //
            ],
          )),
    );
  }

  _buildInputField() => TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: primaryblue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: primaryblue, width: 1.5),
          ),
        ),
      );

  _buildSearchBox() => Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      //height: 2.h,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 280,
                  child: TextFormField(
                    controller: fromController,
                    readOnly: true,
                    onTap: () async {
                      SearchController().getInitData(context);
                      var result =
                          await showSearch(context: context, delegate: IndTransferSearchTo())
                              as IndTransferSearchResultData?;
                      fromController.text = result?.label ?? '';
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'From',
                        labelStyle: TextStyle(color: primaryblue)),
                  ),
                ),
                Icon(
                  Icons.search,
                  color: primaryblue,
                  size: 30,
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.black26,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 280,
                  child: TextFormField(
                    controller: toController,
                    readOnly: true,
                    onTap: () async {
                      SearchController().getInitData(context);
                      var result =
                          await showSearch(context: context, delegate: IndTransferSearchTo())
                              as IndTransferSearchResultData?;
                      toController.text = result?.label ?? '';
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'To',
                        labelStyle: TextStyle(color: primaryblue)),
                  ),
                ),
                Icon(
                  Icons.location_on,
                  color: primaryblue,
                  size: 25,
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryblue,
                fixedSize: Size(90.w, 5.5.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            child: const Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ));
}

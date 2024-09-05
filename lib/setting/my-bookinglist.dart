// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/cancelation_resones.dart';
import 'package:lamar_travel_packages/Model/user_booking_data.dart';
import 'package:lamar_travel_packages/setting/cancelbooking.dart';
import 'package:lamar_travel_packages/widget/pdfpage.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../config.dart';
import '../screen/customize/new-customize/new_customize.dart';
import 'account_screen.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key, required this.bookingList}) : super(key: key);
  final List<BookingListData> bookingList;

  @override
  _MyBookingScreenState createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  List<BookingListData> bookingList = [];
  CancellationReasons? cancellationReasons;

  void getuserbookin() async {
    bookingList = widget.bookingList;
    cancellationReasons = await AssistantMethods.getCancellationReasons();
  }

  @override
  void initState() {
    getuserbookin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text(
          AppLocalizations.of(context)!.myBooking,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: cardcolor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => const AccountPage()));
            },
            icon: Icon(
              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              size: 30.sp,
              color: primaryblue,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildbookingCard(bookingList),
      ),
    );
  }

  Widget _buildbookingCard(List<BookingListData> data) => data.isEmpty
      ? Center(
          child: Text(AppLocalizations.of(context)!.theyNoBooking),
        )
      : ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) => GestureDetector(
                onTap: () {
                  if (data[i].voucherDetails == null) return;
                  if (!data[i].canCancel) return;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PdfScreen(
                          path: data[i].voucherDetails!,
                          title: AppLocalizations.of(context)!.voucherDetails,
                          isPDF: true)));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(boxShadow: [shadow], color: cardcolor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.serviceDate}\n${dateformater(bookingList[i].startDate!)}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: titleFontSize,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${AppLocalizations.of(context)!.bookingDate}\n${dateformater(bookingList[i].bookingDate.toString())}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: titleFontSize,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      _buildspace(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              '${AppLocalizations.of(context)!.bookingNo} ${data[i].bookingNumber}'),
                        ],
                      ),
                      _buildspace(1),
                      RichText(
                        text: TextSpan(
                          text: data[i].packageName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                            color: primaryblue,
                          ),
                        ),
                      ),
                      _buildspace(1),
                      SizedBox(
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            bookingList[i].flight!.isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.airplanemode_active),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (var k = 0; k < bookingList[i].flight!.length; k++)
                                              Text(
                                                bookingList[i]
                                                    .flight![k]
                                                    .serviceDescription
                                                    .replaceAll('), ', '),\n'),
                                                style: TextStyle(fontSize: subtitleFontSize),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            _buildspace(1),
                            bookingList[i].hotel!.isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.hotel),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (var k = 0; k < bookingList[i].hotel!.length; k++)
                                              Text(
                                                '${bookingList[i].hotel![k].serviceName!}, ${bookingList[i].hotel![k].serviceDescription!}',
                                                style: TextStyle(fontSize: subtitleFontSize),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            _buildspace(1),
                            bookingList[i].activity!.isNotEmpty
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.directions_walk),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (var k = 0;
                                                k < bookingList[i].activity!.length;
                                                k++)
                                              Text(
                                                bookingList[i].activity![k].serviceName ??
                                                    ', ${bookingList[i].activity![k].serviceDescription}',
                                                style: TextStyle(fontSize: subtitleFontSize),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            _buildspace(1),
                            bookingList[i].transfer!.isNotEmpty
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                        Icon(MdiIcons.car),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            for (var k = 0;
                                                k < bookingList[i].transfer!.length;
                                                k++)
                                              Text(
                                                '${bookingList[i].transfer![k].serviceDescription}\n ${AppLocalizations.of(context)!.ins} ${bookingList[i].transfer?[k].serviceName ?? ''}',
                                                style: TextStyle(fontSize: subtitleFontSize),
                                              ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            // Icon(MdiIcons.car),
                          ],
                        ),
                      ),
                      _buildspace(2),
                      SizedBox(
                        width: 100.w,
                        child: Divider(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      _buildspace(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.price,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: titleFontSize,
                                color: Colors.black,
                              )),
                          Text(data[i].amount ?? '')
                        ],
                      ),
                      _buildspace(1),
                      !data[i].discountAmount!.contains('0')
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)!.discount,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: titleFontSize,
                                      color: Colors.black,
                                    )),
                                RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                      text: '${data[i].currency ?? ' '} ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: titleFontSize,
                                          color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: data[i].discountAmount,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: titleFontSize,
                                                color: Colors.redAccent,
                                                decoration: TextDecoration.lineThrough)),
                                      ]),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      _buildspace(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.paidFromCredit,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: titleFontSize,
                                color: Colors.black,
                              )),
                          RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                                text: '${data[i].currency ?? ' '} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: titleFontSize,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: data[i].creditBalanceUsed,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: titleFontSize,
                                        color: greencolor,
                                      )),
                                ]),
                          ),
                        ],
                      ),
                      _buildspace(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.paidAmount,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: titleFontSize,
                                color: Colors.black,
                              )),
                          RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                                text: '${data[i].currency ?? ' '} ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: titleFontSize,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: data[i].amountPayed,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: titleFontSize,
                                          color: greencolor)),
                                ]),
                          ),
                        ],
                      ),
                      _buildspace(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            color: bookingList[i].status == 'CONFIRMED'
                                ? Colors.lightGreen[100]
                                : Colors.orange[100],
                            child: Text(
                              data[i].expired!
                                  ? AppLocalizations.of(context)!.expired
                                  : data[i].status!,
                              style: TextStyle(fontSize: subtitleFontSize),
                            ),
                          ),
                          bookingList[i].status == 'CONFIRMED' && bookingList[i].canCancel
                              ? ElevatedButton(
                                  onPressed: () {
                                    cancelbooking(data[i]);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      fixedSize: Size(40.w, 3.h)),
                                  child: Text(AppLocalizations.of(context)!.cancel),
                                )
                              : const SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
              ));

  Widget _buildspace(double h) => SizedBox(
        height: h.h,
      );

  String dateformater(String date) {
    String formattedDate = '';
    if (date.toLowerCase() != 'n/a') {
      final mideldate = DateFormat('y-MM-dd').parse(date);
      formattedDate = DateFormat('dd/MM/yyy').format(mideldate);
    } else {
      formattedDate = 'N/A';
    }

    return formattedDate;
  }

  //? Functions

  cancelbooking(BookingListData bookingListData) async {
    pressIndcatorDialog(context);

    final cancellList = cancellationReasons!.data.map((e) => e).toList();

    final cancelation =
        await AssistantMethods.getCancelltionPolicy(bookingListData.bookingNumber, context);

    if (!mounted) return;

    Navigator.of(context).pop();

    if (cancelation != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CancelBookingScreen(
                cancelReasons: cancellList,
                cancellation: cancelation,
                refNO: bookingListData.bookingNumber!,
              )));
    }
  }
}

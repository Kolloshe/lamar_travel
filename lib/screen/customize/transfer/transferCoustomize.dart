// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, unused_field

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/widget/press-indcator-widget.dart';
import 'package:sizer/sizer.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/adaptive_texts_size.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/change_transfer.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';

import 'package:lamar_travel_packages/widget/image_spinnig.dart';

import 'package:provider/provider.dart';

//import '../../../Model/new_transfer_change_model.dart';
import '../../../Model/customizpackage.dart';
import '../../../widget/mini_loader_widget.dart';
import '../../packages_screen.dart';

class TransferCustomize extends StatefulWidget {
  const TransferCustomize({Key? key}) : super(key: key);
  static String idScreen = "TransferCustomize";

  @override
  _TransferCustomizeState createState() => _TransferCustomizeState();
}

class _TransferCustomizeState extends State<TransferCustomize> {
  late ChangeTransfer _transfer;

  Map<String, dynamic> saveddata = {};

  List<Transfer> _oldTransDetails = [];

  loadTransfer() {
    _transfer = Provider.of<AppData>(context, listen: false).changeTransfer;
    _oldTransDetails = Provider.of<AppData>(context, listen: false).packagecustomiz.result.transfer;
  }

  bool isInTrans = true;
  String? inTransID;

  String? outTransID;

  @override
  void initState() {
    loadTransfer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: cardcolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: cardcolor,
            elevation: 0.1,
            leading: IconButton(
                onPressed: () {
                  if (Provider.of<AppData>(context, listen: false).isPreBookFailed == false) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text('Are you sure to cancel the booking '),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          CustomizeSlider.idScreen, (route) => false);
                                      Provider.of<AppData>(context, listen: false)
                                          .changePrebookFaildStatus(false);
                                      Provider.of<AppData>(context, listen: false)
                                          .changeTransferCounter(0);
                                    },
                                    child: Text(
                                      'cancel',
                                      style: TextStyle(color: Colors.redAccent),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'continue',
                                      style: TextStyle(color: Colors.green),
                                    )),
                              ],
                            ));
                  }
                },
                icon: Icon(
                  Provider.of<AppData>(context, listen: false).locale == Locale('en')
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                  size: 30,
                  color: primaryblue,
                )),
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.transfer,
              style: TextStyle(color: Colors.black, fontSize: titleFontSize),
            ),
          ),
          backgroundColor: background,
          body: Container(
              padding: EdgeInsets.all(5),
              width: size.width,
              child: isInTrans ? _buildInTrans() : _buildOutTrans()),
        ),
      ),
    );
  }

  int? inSelectedIndex;

  Widget _buildInTrans() => Column(
        children: [
          Provider.of<AppData>(context, listen: false).isPreBookFailed == true
              ? Provider.of<AppData>(context, listen: false).transferChangeCounter > 1
                  ? InkWell(
                      onTap: () async {
                        pressIndcatorDialog(context);
                        await AssistantMethods.sectionManager(context,
                            section: 'transfer',
                            cusID: Provider.of<AppData>(context, listen: false)
                                .packagecustomiz
                                .result
                                .customizeId,
                            action: 'remove');
                        Provider.of<AppData>(context, listen: false).changeTransferCounter(0);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: cardcolor, borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          AppLocalizations.of(context)!.youTryToChangeTheTransferManyTime,
                          style: TextStyle(fontSize: subtitleFontSize, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  : SizedBox()
              : SizedBox(),
          Container(
            margin: EdgeInsets.all(1),
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: cardcolor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.toHotel,
                    style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  // Icon(Icons.calendar_today),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Text(
                  //   _oldTransDetails[0].date,
                  //   style: TextStyle(
                  //       fontSize: subtitleFontSize,
                  //       fontWeight: FontWeight.normal),
                  // ),
                ],
              ),
            ),
          ),
          Container(
            width: 100.w,
            margin: EdgeInsets.all(10),
            child: Text('${AppLocalizations.of(context)!.selectTheTransfer}  : '),
          ),
          Expanded(
            //  height: size.height * 0.75,
            child: ListView.builder(
              itemCount: _transfer.data.dataIn.isNotEmpty ? _transfer.data.dataIn.length : 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    inTransID = _transfer.data.dataIn[index].id;
                    setState(() {
                      inSelectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: index == inSelectedIndex ? yellowColor.withOpacity(0.8) : cardcolor,
                      boxShadow: [shadow],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: CachedNetworkImage(
                                    imageUrl: _transfer.data.dataIn[index].images,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => Center(
                                          child: ImageSpinning(
                                            withOpasity: true,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) => Image.asset(
                                          'assets/images/image-not-available.png',
                                          height: 200,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        )),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _transfer.data.dataIn[index].name,
                                      style: TextStyle(
                                        fontSize: subtitleFontSize,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: false,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${AppLocalizations.of(context)!.type} : ',
                                          style: TextStyle(
                                            fontSize: subtitleFontSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: false,
                                        ),
                                        Text(
                                          _transfer.data.dataIn[index].serviceTypeName,
                                          style: TextStyle(
                                            fontSize: subtitleFontSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: false,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${AppLocalizations.of(context)!.packagePriceDifference} : ',
                                          style: TextStyle(
                                            fontSize: subtitleFontSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: false,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _transfer.data.dataIn[index].priceDifference
                                                      .toString()
                                                      .substring(0, 1) !=
                                                  '-'
                                              ? '+ ${_transfer.data.dataIn[index].priceDifference} ${localizeCurrency(_transfer.data.dataIn[index].currency)}'
                                              : '${_transfer.data.dataIn[index].priceDifference} ${localizeCurrency(_transfer.data.dataIn[index].currency)}',
                                          style: TextStyle(
                                            color: _transfer.data.dataIn[index].priceDifference
                                                        .toString()
                                                        .substring(0, 1) !=
                                                    '-'
                                                ? Colors.red.shade400
                                                : greencolor,
                                            fontSize:
                                                AdaptiveTextSize().getadaptiveTextSize(context, 22),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: false,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       'Total: ',
                                    //       style: TextStyle(
                                    //         fontSize: AdaptiveTextSize()
                                    //             .getadaptiveTextSize(
                                    //                 context, 22),
                                    //         fontWeight: FontWeight.w500,
                                    //       ),
                                    //       overflow: TextOverflow.ellipsis,
                                    //       maxLines: 3,
                                    //       softWrap: false,
                                    //     ),
                                    //     Text(
                                    //       _transfer.data.dataIn[index]
                                    //               .totalAmount
                                    //               .toString() +
                                    //           ' ' +
                                    //           _transfer
                                    //               .data.dataIn[index].currency,
                                    //       style: TextStyle(
                                    //         color: greencolor,
                                    //         fontSize: AdaptiveTextSize()
                                    //             .getadaptiveTextSize(
                                    //                 context, 22),
                                    //         fontWeight: FontWeight.w500,
                                    //       ),
                                    //       overflow: TextOverflow.ellipsis,
                                    //       maxLines: 3,
                                    //       softWrap: false,
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),

                              // Container(
                              //   alignment: Alignment.bottomCenter,
                              //   margin: EdgeInsets.symmetric(horizontal: 10),
                              //   child: OutlinedButton(
                              //     child: Text('Next'),
                              //     onPressed: () async {
                              //       inTransID = _transfer.data.dataIn[index].id;
                              //
                              //       showDialog(
                              //           context: context,
                              //           builder: (context) => PressIndcator());
                              //       await Future.delayed(Duration(seconds: 1),
                              //           () {
                              //         Navigator.of(context).pop();
                              //       });
                              //
                              //       setState(() {
                              //         isInTrans = !isInTrans;
                              //       });
                              //
                              //       //    Navigator.of(context)
                              //       //        .pushNamed(MiniLoader.idScreen);
                              //       //
                              //       // saveddata = {
                              //       //      "transferId": _transfer.data.dataIn[index].id,
                              //       //      "customizeId": Provider.of<AppData>(context,
                              //       //              listen: false)
                              //       //          .packagecustomiz
                              //       //          .result
                              //       //          .customizeId,
                              //       //      "sellingCurrency": "USD"
                              //       //    };
                              //       //
                              //
                              //       //  var data = jsonEncode(saveddata);
                              //       // try {
                              //       //   await AssistantMethods.updateTransfer(data);
                              //       //
                              //       //   await AssistantMethods.updatehotelDetails(
                              //       //       Provider.of<AppData>(context,
                              //       //               listen: false)
                              //       //           .packagecustomiz
                              //       //           .result
                              //       //           .customizeId,
                              //       //       context);
                              //       //   Navigator.of(context).pushNamedAndRemoveUntil(
                              //       //       CustomizeSlider.idScreen,
                              //       //       (Route<dynamic> route) => false);
                              //       // } catch (e) {
                              //       //   print(e.toString());
                              //       // }
                              //     },
                              //     style: OutlinedButton.styleFrom(
                              //       primary: greencolor,
                              //       side:
                              //           BorderSide(color: greencolor, width: 1),
                              //     ),
                              //   ),
                              // ),
                              //
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Provider.of<AppData>(context, listen: false).transferChangeCounter > 1
              ? SizedBox(
                  height: 1.h,
                )
              : SizedBox(),
          SizedBox(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // OutlinedButton(
                //   onPressed: () async {
                //     inSelectedIndex = null;
                //     showDialog(context: context, builder: (context) => PressIndcator());
                //     await Future.delayed(Duration(seconds: 1), () {
                //       Navigator.of(context).pop();
                //     });
                //     inTransID = null;
                //     setState(() {
                //       isInTrans = !isInTrans;
                //     });
                //   },
                //   style: OutlinedButton.styleFrom(
                //     foregroundColor: greencolor,
                //     fixedSize: Size(45.w, 4.h),
                //     side: BorderSide(color: greencolor, width: 1),
                //   ),
                //   child: Text(AppLocalizations.of(context)!.skip),
                // ),

                ElevatedButton(
                  onPressed: () async {
                    if (inTransID == null) {
                      displayTostmessage(context, true,
                          message: AppLocalizations.of(context)!.selectOneOrPressSkip);
                    } else {
                      showDialog(context: context, builder: (context) => PressIndcator());
                      await Future.delayed(Duration(seconds: 1), () {
                        Navigator.of(context).pop();
                      });

                      setState(() {
                        isInTrans = !isInTrans;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    fixedSize: Size(95.w, 4.h),
                  ),
                  child: Text(AppLocalizations.of(context)!.next),
                ),
              ],
            ),
          ),
        ],
      );

  int? outSelectionIndex;

  Widget _buildOutTrans() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: cardcolor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.toAirport),
                Spacer(),
                SizedBox(
                  width: 10,
                ),
                // Text(
                //   _oldTransDetails[1].date,
                //   style: TextStyle(
                //       fontSize: subtitleFontSize,
                //       fontWeight: FontWeight.normal),
                // ),
              ],
            ),
          ),
          SizedBox(
            width: 100.w,
            child: InkWell(
              onTap: () {
                setState(() {
                  isInTrans = true;
                });
              },
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_left, color: primaryblue),
                  Text(
                    AppLocalizations.of(context)!.previous,
                    style: TextStyle(color: primaryblue),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            //  height: size.height * 0.75,
            child: ListView.builder(
              itemCount: _transfer.data.out.isNotEmpty ? _transfer.data.out.length : 0,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        outSelectionIndex = index;
                        outTransID = _transfer.data.out[index].id;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              index == outSelectionIndex ? yellowColor.withOpacity(0.8) : cardcolor,
                          boxShadow: [shadow],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: CachedNetworkImage(
                                        imageUrl: _transfer.data.out[index].images,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain,
                                        placeholder: (context, url) => Center(
                                              child: ImageSpinning(
                                                withOpasity: true,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) => Image.asset(
                                              'assets/images/image-not-available.png',
                                              height: 200,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            )),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _transfer.data.out[index].name,
                                          style: TextStyle(
                                            fontSize: subtitleFontSize,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: false,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${AppLocalizations.of(context)!.type} : ',
                                              style: TextStyle(
                                                fontSize: subtitleFontSize,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: false,
                                            ),
                                            Text(
                                              _transfer.data.out[index].serviceTypeName,
                                              style: TextStyle(
                                                fontSize: subtitleFontSize,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: false,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              '${AppLocalizations.of(context)!.packagePriceDifference} : ',
                                              style: TextStyle(
                                                fontSize: subtitleFontSize,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: false,
                                            ),
                                            Text(
                                              _transfer.data.out[index].priceDifference
                                                          .toString()
                                                          .substring(0, 1) !=
                                                      '-'
                                                  ? '+ ${_transfer.data.out[index].priceDifference} ${localizeCurrency(_transfer.data.out[index].currency)}'
                                                  : '${_transfer.data.out[index].priceDifference} ${localizeCurrency(_transfer.data.out[index].currency)}',
                                              style: TextStyle(
                                                color: _transfer.data.out[index].priceDifference
                                                            .toString()
                                                            .substring(0, 1) !=
                                                        '-'
                                                    ? Colors.red.shade400
                                                    : greencolor,
                                                fontSize: subtitleFontSize,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: false,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       'Total: ',
                                        //       style: TextStyle(
                                        //         fontSize: AdaptiveTextSize()
                                        //             .getadaptiveTextSize(
                                        //                 context, 22),
                                        //         fontWeight: FontWeight.w500,
                                        //       ),
                                        //       overflow: TextOverflow.ellipsis,
                                        //       maxLines: 3,
                                        //       softWrap: false,
                                        //     ),
                                        //     Text(
                                        //       _transfer
                                        //               .data.out[index].totalAmount
                                        //               .toString() +
                                        //           ' ' +
                                        //           _transfer
                                        //               .data.out[index].currency,
                                        //       style: TextStyle(
                                        //         color: greencolor,
                                        //         fontSize: AdaptiveTextSize()
                                        //             .getadaptiveTextSize(
                                        //                 context, 22),
                                        //         fontWeight: FontWeight.w500,
                                        //       ),
                                        //       overflow: TextOverflow.ellipsis,
                                        //       maxLines: 3,
                                        //       softWrap: false,
                                        //     ),
                                        //   ],
                                        // ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  //
                                  // Container(
                                  //   alignment: Alignment.bottomCenter,
                                  //   margin: EdgeInsets.symmetric(horizontal: 10),
                                  //   child: OutlinedButton(
                                  //     child: Text('Select'),
                                  //     onPressed: () async {
                                  //       Navigator.of(context)
                                  //           .pushNamed(MiniLoader.idScreen);
                                  //       outTransID = _transfer.data.out[index].id;
                                  //
                                  //       final isDone =
                                  //           await AssistantMethods.updateTransfer(
                                  //               Provider.of<AppData>(context,
                                  //                       listen: false)
                                  //                   .packagecustomiz
                                  //                   .result
                                  //                   .customizeId,
                                  //               inTransID,
                                  //               outTransID,
                                  //               context);
                                  //
                                  //       if (isDone) {
                                  //         Navigator.of(context)
                                  //             .pushNamedAndRemoveUntil(
                                  //                 CustomizeSlider.idScreen,
                                  //                 (Route<dynamic> route) =>
                                  //                     false);
                                  //         displayTostmessage(context, false,
                                  //             messeage:
                                  //                 'Transfer has been added');
                                  //       } else {
                                  //         Navigator.of(context).pop();
                                  //         displayTostmessage(context, true,
                                  //             messeage:
                                  //                 "We can't add Transfer for this Package");
                                  //       }
                                  //     },
                                  //     style: OutlinedButton.styleFrom(
                                  //       primary: greencolor,
                                  //       side: BorderSide(
                                  //           color: greencolor, width: 1),
                                  //     ),
                                  //   ),
                                  // ),
                                  //
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // inTransID == null
                //     ? SizedBox()
                //     : OutlinedButton(
                //         onPressed: () async {
                //           if (outTransID == null && inTransID == null) {
                //             displayTostmessage(context, true,
                //                 message: AppLocalizations.of(context)!.cantSkipBoth);
                //           } else {
                //             Navigator.of(context).pushNamed(MiniLoader.idScreen);

                //             final isDone = await AssistantMethods.updateTransfer(
                //                 Provider.of<AppData>(context, listen: false)
                //                     .packagecustomiz
                //                     .result
                //                     .customizeId,
                //                 inTransID,
                //                 outTransID,
                //                 context);

                //             if (isDone) {
                //               if (Provider.of<AppData>(context, listen: false).isPreBookFailed) {
                //                 Navigator.of(context).pop();
                //                 Navigator.of(context).pop();
                //               } else {
                //                 Navigator.of(context).pushNamedAndRemoveUntil(
                //                     CustomizeSlider.idScreen, (Route<dynamic> route) => false);
                //                 displayTostmessage(context, false,
                //                     message: AppLocalizations.of(context)!.transferHasBeenAdded);
                //               }
                //             } else {
                //               Navigator.of(context).pop();
                //               displayTostmessage(context, true,
                //                   message: AppLocalizations.of(context)!.cantAddTransferFor);
                //             }
                //           }

                //           // showDialog(
                //           //     context: context,
                //           //     builder: (context) => PressIndcator());
                //           // await Future.delayed(Duration(seconds: 1), () {
                //           //   Navigator.of(context).pop();
                //           // });
                //           //
                //           // inTransID = null;
                //           //
                //           // setState(() {
                //           //   isInTrans = !isInTrans;
                //           // });
                //         },
                //         style: OutlinedButton.styleFrom(
                //           foregroundColor: greencolor, fixedSize: Size(45.w, 4.h),
                //           side: BorderSide(color: greencolor, width: 1),
                //         ),
                //         child: Text(AppLocalizations.of(context)!.skip),
                //       ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (outTransID == null) {
                        displayTostmessage(context, true,
                            message: AppLocalizations.of(context)!.selectOneOrPressSkip);
                      } else {
                        Navigator.of(context).pushNamed(MiniLoader.idScreen);

                        final isDone = await AssistantMethods.updateTransfer(
                            Provider.of<AppData>(context, listen: false)
                                .packagecustomiz
                                .result
                                .customizeId,
                            inTransID,
                            outTransID,
                            context);

                        if (isDone) {
                          if (Provider.of<AppData>(context, listen: false).isPreBookFailed) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          } else {
                            displayTostmessage(context, false,
                                message: AppLocalizations.of(context)!.transferHasBeenAdded);

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                CustomizeSlider.idScreen, (Route<dynamic> route) => false);
                          }
                        } else {
                          Navigator.of(context).pop();
                          displayTostmessage(context, true,
                              message: AppLocalizations.of(context)!.selectOneOrPressSkip);
                        }
                      }
                    } catch (e) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          CustomizeSlider.idScreen, (Route<dynamic> route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    fixedSize: Size(95.w, 4.h),
                  ),
                  child: Text(AppLocalizations.of(context)!.select),
                ),
              ],
            ),
          ),
        ],
      );
}

  // Widget _buildTransferContainer(TransferData data, String direction) {
  //   return GestureDetector(
  //     onTap: () {
  //       if (selectedTransfer.containsValue(data)) {
  //         selectedTransfer.remove(direction);
  //       } else {
  //         selectedTransfer[direction] = data;
  //       }
  //       setState(() {});
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(vertical: 5),
  //       padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //           color: cardcolor,
  //           borderRadius: BorderRadius.circular(10),
  //           boxShadow: [shadow],
  //           border: Border.all(
  //               width: 1.2,
  //               color: selectedTransfer.containsValue(data) ? greencolor : Colors.transparent)),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CachedNetworkImage(
  //             imageUrl: data.content.images[getRightImageIndex(data.content.images)].url,
  //             fit: BoxFit.cover,
  //           ),
  //           SizedBox(height: 2.h),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 "${data.content.category.name} ${data.content.vehicle.name}",
  //                 style: TextStyle(fontSize: subtitleFontSize.sp - 1, fontWeight: FontWeight.w600),
  //               ),
  //               Text(data.transferType),
  //             ],
  //           ),
  //           SizedBox(height: 1.h),
  //           for (var content in data.content.transferDetailInfo)
  //             Text(
  //               content.name,
  //               style: TextStyle(color: inCardColor),
  //             ),
  //           SizedBox(height: 1.h),
  //           Align(
  //             alignment: Alignment.centerRight,
  //             child: Text(
  //               "${data.price.sellingAmount} ${data.price.sellingCurrency}",
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w700,
  //                   color: greencolor,
  //                   fontSize: subtitleFontSize.sp - 2),
  //             ),
  //           ),
  //           SizedBox(height: 1.h)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // int getRightImageIndex(List<TransferImage> list) {
  //   return list.length - 1;
  // }
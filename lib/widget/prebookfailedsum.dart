// import 'package:flutter/material.dart';
// import 'package:lamar_travel_packages/Model/prebookfaild.dart';
// import 'package:lamar_travel_packages/config.dart';
// import 'package:intl/intl.dart';
// import 'package:rive/rive.dart';
// import 'package:sizer/sizer.dart';
//
// class PrebookFailedSum extends StatelessWidget {
//   PrebookFailedSum(this.prebookFalid, {Key? key}) : super(key: key);
//   PrebookDetails prebookFalid;
//   RiveAnimationController controller=SimpleAnimation('show');
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//
//       child: Container(
//
//         //height: 50.h,
//         padding: EdgeInsets.all(25).copyWith(top: 5),
//         child: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 15.h,
//                     width: 100.w,
//                     child: Align(
//                       alignment:Alignment.center,
//                       child: RiveAnimation.asset('assets/images/alert_icon.riv',
//                         fit: BoxFit.cover,
//                         controllers: [controller],
//                         onInit: (_) => setState(() {},)
//                       ),
//                      // Image.asset('assets/images/vectors/warning.png',width: 20.w,),
//                     ),
//                   ),
//                   SizedBox(height: 1.h,),
//                   Text("We can't book some services please change :\n",
//                     style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),),
//                   this.prebookFalid.flights.prebookSuccess
//                       ? SizedBox()
//                       : SizedBox(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("We we couldn't secure your flights :\n",
//                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: titleFontSize),),
//                         prebookFalid.flights.failedReasons == null
//                             ? SizedBox()
//                             :prebookFalid.flights.failedReasons!.fielderrors
//
//                             ?Text('• You enter some invalid passenger information please check' )
//                             :  Text('• ' + this.prebookFalid.flights.message.replaceAll(
//                             'failed to prebook', '') + '\n'),
//                       ],
//                     ),
//                   ),
//                   this.prebookFalid.hotels.prebookSuccess
//                       ? SizedBox()
//                       : SizedBox(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("We we couldn't secure your hotel :\n",
//                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: titleFontSize),),
//                         Text('• ' + this.prebookFalid.hotels.message.replaceAll(
//                             'failed to prebook', '')),
//                       ],
//                     ),
//                   ),
//                   this.prebookFalid.activites.prebookSuccess
//                       ? SizedBox()
//                       : SizedBox(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("We we couldn't secure your activities :\n",
//                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: titleFontSize),),
//                         for(var i in prebookFalid.activites.details) Text('• ' + i.details.name +
//                             ' ' "on " + DateFormat('dd - MMM').format(i.date) + '\n',)
//                       ],
//                     ),
//                   ),
//                   this.prebookFalid.transfers.prebookSuccess
//                       ? SizedBox()
//                       : SizedBox(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("We we couldn't secure your transfer :\n",
//                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: titleFontSize),),
//                         Text('• ' + this.prebookFalid.transfers.message.replaceAll(
//                             'failed to prebook', '')),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 100.w,
//                     child: ElevatedButton(onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                       child: Text('Change'),
//                     style: ElevatedButton.styleFrom(fixedSize: Size(95.w,5.h),primary: yellowColor),),),
//                 ],
//               );
//             }),),
//     );
//   }
// }

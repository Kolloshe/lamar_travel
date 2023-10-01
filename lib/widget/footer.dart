// import 'package:flutter/material.dart';
// import '../config.dart';
// import 'pdfpage.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class Footer extends StatelessWidget {
//   const Footer({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       // height: 160,
//       child: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             child: Container(
//               color: cardcolor,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       _launchURL('');
//                     },
//                     child: Text(
//                       'Blog',
//                       style: TextStyle(
//                         color: footerbuttoncolor,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: size.height * 0.06,
//                     child: VerticalDivider(
//                       color: Colors.black.withOpacity(0.25),
//                       thickness: 0.7,
//                       indent: 8,
//                       endIndent: 8,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       _launchURL('https://ibookholiday.com/services/faq');
//                     },
//                     child: Text(
//                       'FAQs',
//                       style: TextStyle(
//                         color: footerbuttoncolor,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: size.height * 0.06,
//                     child: VerticalDivider(
//                       color: Colors.black.withOpacity(0.25),
//                       thickness: 0.7,
//                       indent: 8,
//                       endIndent: 8,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) =>
//                               PdfScreen(path: 'assets/images/PrivacyPolicy.pdf')));
//                     },
//                     child: Text(
//                       'Privacy \n Policy',
//                       style: TextStyle(
//                         color: footerbuttoncolor,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: size.height * 0.06,
//                     child: VerticalDivider(
//                       color: Colors.black.withOpacity(0.25),
//                       thickness: 0.5,
//                       indent: 8,
//                       endIndent: 8,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) =>
//                               PdfScreen(path: 'assets/images/terms.pdf')));
//                     },
//                     child: Text(
//                       'Terms & \n Conditions',
//                       style: TextStyle(
//                         color: footerbuttoncolor,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 13,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                       softWrap: false,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8),
//             color: cardcolor,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   'assets/images/mascot+logo1.png',
//                   width: 50,
//                   height: 50,
//                 ),
//                 SizedBox(
//                   height: 2,
//                 ),
//                 Container(
//                   child: Text(
//                     'Copyright © 2020 Ibookholiday.com. All rights reserved.'
//                     'Site Operator: Ibookholiday.com (Dubai, UAE) Limited',
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void _launchURL(String _url) async =>
//     await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

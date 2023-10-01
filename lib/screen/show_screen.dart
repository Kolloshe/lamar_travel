// import 'package:flutter/material.dart';
// import 'package:lamar_travel_packages/config.dart';
// import 'package:lamar_travel_packages/widget/trending_package.dart';

// // ignore: camel_case_types
// class Show_screen extends StatefulWidget {
//   const Show_screen({Key? key}) : super(key: key);

//   @override
//   _Show_screenState createState() => _Show_screenState();
// }

// // ignore: camel_case_types
// class _Show_screenState extends State<Show_screen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Top Trending Travel Packages',
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: false,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 5,
//                       itemBuilder: (BuildContext context, int index) =>
//                           Trending(),
//                     ),
//                   ),
//                   Text(
//                     'The Most Budget Travel Packages',
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                   ),
                  
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: false,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 5,
//                       itemBuilder: (BuildContext context, int index) =>
//                           BudgetTravelpackages(),
//                     ),
//                   ),
//                   Text(
//                     'The Most Exotic Travel Packages',
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                   ),
//                   SizedBox(height: 5,),
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: false,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 5,
//                       itemBuilder: (BuildContext context, int index) =>
//                           BudgetTravelpackages(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

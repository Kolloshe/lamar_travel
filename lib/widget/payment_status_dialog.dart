//
// import 'package:material_dialogs/material_dialogs.dart';
// import 'package:material_dialogs/widgets/buttons/icon_button.dart';
// import 'package:sizer/sizer.dart';
// import 'package:flutter/material.dart';
//
// class PaymentDialogStatus extends StatelessWidget {
//   const PaymentDialogStatus({Key? key,required this.status}) : super(key: key);
//   final String status;
//
//   @override
//   Widget build(BuildContext context) {
//     return  Dialogs.materialDialog(
//         barrierDismissible: false,
//         context: context,
//         color: Colors.white,
//         msg: 'Prebooking is successfully',
//         title: 'Congratulations',
//         lottieBuilder: Lottie.asset(
//           'assets/images/loading/done.json',
//           fit: BoxFit.contain,
//         ),
//         actions: [
//           IconsButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.of(context)
//                   .pushReplacement(MaterialPageRoute(builder: (context) => SumAndPay()));
//             },
//             text: 'To Final step',
//             iconData: Icons.done,
//             color: Colors.blue,
//             textStyle: TextStyle(color: Colors.white),
//             iconColor: Colors.white,
//           ),
//         ]);
//   }
// }

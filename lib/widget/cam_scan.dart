// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_mrz_scanner/flutter_mrz_scanner.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:intl/intl.dart';

enum Sex { none, male, female }

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.isAdult}) : super(key: key);
  final bool isAdult;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool isParsed = false;
 // MRZController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // MRZScanner(
          // withOverlay: true,
          // onControllerCreated: onControllerCreated,
        // ),
        Positioned(
            left: 20,
            top: 40,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            )),
        Positioned(
            left: 10,
            right: 10,
            top: 100,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: cardcolor),
              child: Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: Colors.grey,
                  ),
                  Text(AppLocalizations.of(context)!.notSavingAnyDocuments)
                ],
              ),
            )),
      ],
    ));
  }

  //  void dispose() {
//    controller?.stopPreview();
//    super.dispose();
//  }
//  void onControllerCreated(MRZController controller) {
//    this.controller = controller;
//    controller.onParsed = (result) async {
//      if (isParsed) {
//        return;
//      }
//      print(result.documentType);
//      if (result.documentType == 'P' ||
//          result.documentType == 'p' ||
//          result.documentType == 'PC' ||
//          result.documentType == 'pc') {
//        isParsed = true;
//        controller.stopPreview();
//        print(result.surnames);
//        final tempName = result.givenNames.split(' ');
//        String passengername = '';
//        if (tempName.length > 1) {
//          passengername = tempName[0] + ' ' + tempName[1];
//        } else {
//          passengername = tempName[0];
//        }
//        final passenger = users.data.passengers;
//        final x = passenger!
//            .where(
//                (element) => element.name.toLowerCase().startsWith(result.givenNames.toLowerCase()))
//            .toList();
//        final isAduls = isAdult(DateFormat("yyyy-MM-dd").format(result.birthDate));
//        if (widget.isAdult != isAduls) {
//          if (widget.isAdult) {
//            displayTostmessage(context, true, message: "this passenger should be an adult");
//          } else {
//            displayTostmessage(context, true, message: "this passenger should be a child");
//          }
//          setState(() {
//            isParsed = false;
//          });
//          return;
//        }
//        final nationality = await AssistantMethods.getCountryFormDoc(result.nationalityCountryCode);
//        Forms form = Forms(
//          nationality: nationality,
//          passportexpirydate: DateFormat("yyyy-MM-dd").format(result.expiryDate),
//          firstName: passengername,
//          surname: result.surnames,
//          dateofbirth: DateFormat("yyyy-MM-dd").format(result.birthDate),
//          passportnumber: result.documentNumber,
//          passportissuedcountry: nationality,
//          ageType: '',
//          type: widget.isAdult
//              ? result.sex.toString().toLowerCase() == Sex.male.toString().toLowerCase()
//                  ? 'Mr.'
//                  : 'Mrs.'
//              : result.sex.toString().toLowerCase() == Sex.male.toString().toLowerCase()
//                  ? "Mstr."
//                  : "Miss.",
//          id: x.isEmpty ? null : x[0].id,
//          email: '',
//          phone: '',
//          holderType: 'passenger',
//        );
//        isParsed = false;
//        return Navigator.pop(context, form);
//      } else {
//        displayTostmessage(context, false,
//            isInformation: true, message: 'Please scan correct document');
//        isParsed = true;
//        await Future.delayed(Duration(seconds: 2), () {
//          isParsed = false;
//        });
//        controller.startPreview();
//      }
//    };
//    controller.onError = (error) {};
//    controller.startPreview();
//  }

  bool isAdult(String birthDateString) {
    String datePattern = "yyyy-MM-dd";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 11 || yearDiff == 11 && monthDiff >= 0 && dayDiff >= 0;
  }
}

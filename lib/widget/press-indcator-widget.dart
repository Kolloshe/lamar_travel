
// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/config.dart';

import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'image_spinnig.dart';

class PressIndcator extends StatefulWidget {
  const PressIndcator({Key? key}) : super(key: key);

  @override
  _PressIndcatorState createState() => _PressIndcatorState();
}

class _PressIndcatorState extends State<PressIndcator> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 20.w,
        height: 10.h,
        padding: const EdgeInsets.all(10),
        child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 10.w,
                  height: 7.h,
                  child: const ImageSpinning(
                    withOpasity: false,
                  )),
              Text(
                '   ${AppLocalizations.of(context)!.pleasewait}',
                style: TextStyle(fontSize: subtitleFontSize),
              ),
            ],
          );
        }),
      ),
    );
  }
}

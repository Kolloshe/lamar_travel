import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Errordislog extends Dialog {
  const Errordislog({super.key});



 Widget error (BuildContext context,String e ,{String? title}) {
  return AlertDialog(
    title: Text( title ?? "Something went wrong"),
    content: Text(e),
    actions: <Widget>[
      // usually buttons at the bottom of the dialog
      TextButton(
        child: Text(AppLocalizations.of(context)!.close),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
}
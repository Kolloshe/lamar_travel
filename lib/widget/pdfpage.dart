// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, unused_field

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/widget/press-indcator-widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PdfScreen extends StatefulWidget {
  static String idScreen = 'PdfScreen';

  const PdfScreen({Key? key, required this.path, required this.title, required this.isPDF})
      : super(key: key);

  final String path;
  final String title;
  final bool isPDF;

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  late WebViewController controller;
  PdfViewerController pdfViewerController = PdfViewerController();

  UniqueKey _key = UniqueKey();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    if (widget.isPDF) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        pressIndcatorDialog(context);
      });

      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            elevation: 0.1,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                    ? Icons.keyboard_arrow_left
                    : Icons.keyboard_arrow_right,
                size: 30,
                color: primaryblue,
              ),
            ),
            backgroundColor: cardcolor,
            actions: [
              widget.isPDF && widget.title.contains(AppLocalizations.of(context)!.voucherDetails)
                  ? IconButton(
                      onPressed: () {
                        Share.share(widget.path, subject: widget.title);
                      },
                      icon: Icon(
                        Icons.share,
                        color: primaryblue,
                      ))
                  : const SizedBox(),
            ]),

        //appbar(context, ''),

        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //   currentState('Customize', context, PdfScreen.idScreen),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: widget.isPDF
                      ? SfPdfViewer.network(
                          widget.path,
                          controller: pdfViewerController,
                          onDocumentLoaded: (dec) {
                            Navigator.of(context).pop();
                          },
                          onDocumentLoadFailed: (v) {
                            displayTostmessage(context, true,
                                message: 'Failed to load PDF please try again later');
                            Navigator.of(context).pop();
                          },
                        )
                      : WebView(
                          javascriptMode: JavascriptMode.unrestricted,
                          initialUrl: widget.path,
                          gestureRecognizers: gestureRecognizers,
                          onPageFinished: (s) async {
                            Navigator.of(context).pop();
                            await injectJS();
                            if (kDebugMode) {
                              print('on Finish $s');
                            }
                            //injectJS();
                          },
                          onPageStarted: (s) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const PressIndcator());
                          },
                          onWebViewCreated: (controller) {
                            this.controller = controller;
                          },
                        )

                  //SfPdfViewer.asset(widget.path, scrollDirection: PdfScrollDirection.vertical),
                  ),
            ],
          ),
        ));
  }

  injectJS() {
    // this.controller.runJavascriptReturningResult(
    //   "document.getElementsByClassName('design-header')[0].style.display='none'");
    controller
        .runJavascript("document.getElementsByClassName('explore-main')[0].style.display='none'");
    controller.runJavascriptReturningResult(
        "document.getElementsByTagName('footer')[0].style.display='none'");
  }
}

//class="explore-main"

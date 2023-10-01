// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'Assistants/assistant_methods.dart';
import 'Datahandler/app_data.dart';

class TestStream extends StatefulWidget {
  const TestStream({Key? key}) : super(key: key);

  @override
  _TestStreamState createState() => _TestStreamState();
}

class _TestStreamState extends State<TestStream> {
  Stream<Response> getData() {
    final x = AssistantMethods.getRandomNumberFact(
        context
            .read<AppData>()
            .coupon!
            .data
            .paymentData
            .streamApi);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<Response>(
          stream: getData(),
          builder: (context, AsyncSnapshot<Response> snap) {
            String statusText = '';
            if (snap.data?.body != null) {
              final dd = json.decode(snap.data?.body.replaceFirst('data: ', '') ?? '');

              statusText = dd['status_text'].toString();
            }
            switch (statusText.trim().toLowerCase()) {
              case 'transaction declined : insufficient funds':
                return const Text('case 1');

              default:
            return const Text('case 2');
            }

          },
        ),
      ),
    );
  }
}

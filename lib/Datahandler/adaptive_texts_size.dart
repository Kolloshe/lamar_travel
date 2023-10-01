import 'package:flutter/material.dart';

class AdaptiveTextSize {
  const AdaptiveTextSize();

  getadaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    return (value / (MediaQuery.of(context).size.height)/2) * MediaQuery.of(context).size.height;
  }
}

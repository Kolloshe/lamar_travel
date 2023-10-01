import 'dart:io';

import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'package:hyperpay_plugin/model/ready_ui.dart';

import '../config.dart';

class PaymentCore {
  static late FlutterHyperPay flutterHyperPay;

  static init() {
    flutterHyperPay = FlutterHyperPay(
      shopperResultUrl: InAppPaymentSetting.shopperResultUrl, // return back to app
      paymentMode: PaymentMode.live, // test or live
      lang: InAppPaymentSetting.getLang(),
    );
  }

  static Future<PaymentResultData> payRequestNowReadyUI(
      {required List<String> brandsName, required String checkoutId}) async {
    init();
    PaymentResultData paymentResultData;
    paymentResultData = await flutterHyperPay.readyUICards(
      readyUI: ReadyUI(
          brandsName: brandsName,
          checkoutId: checkoutId,
          merchantIdApplePayIOS: InAppPaymentSetting.merchantId, // applepay
          countryCodeApplePayIOS: InAppPaymentSetting.countryCode, // applePay
          companyNameApplePayIOS: "lamartravel", // applePay
          themColorHexIOS: "#000000", // FOR IOS ONLY
          setStorePaymentDetailsMode: true // store payment details for future use
          ),
    );

    if (paymentResultData.paymentResult == PaymentResult.success) {
      return paymentResultData;
    } else {
      return paymentResultData;
    }

//   static const platform = MethodChannel('com.lamarTravel/paymentMethod');

//   static Future getPaymentResponse(BuildContext context) async {
//     try {
//       String checkOutId = await AssistantMethods.fetchCheckOutId();
//       if (checkOutId.isEmpty) return;
//       var result = await platform.invokeMethod(
//           'getPaymentMethod', <String, dynamic>{'checkoutId': checkOutId, 'brand': "ApplePay"});

//       print(result.toString());
//     } on PlatformException catch (e) {
//       print("Faild ro get payment method: ${e.message}");
//     }
//   }
  }
}

class InAppPaymentSetting {
  // shopperResultUrl : this name must like scheme in intent-filter , url scheme in xcode
  static String shopperResultUrl =
      Platform.isIOS ? "com.lamarTravelPackages" : "com.lamartravelpackages";
  static String merchantId = appleMerchantId;
  static const String countryCode = "SA";
  static getLang() {
    if (Platform.isIOS) {
      return "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}

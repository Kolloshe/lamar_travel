import UIKit
import Flutter
import FirebaseCore
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      GMSServices.provideAPIKey("AIzaSyBcDNURPotMs5U9M8frup8v-f2MNueERgQ");
      GeneratedPluginRegistrant.register(with: self)
      let controller :FlutterViewController = window?.rootViewController as! FlutterViewController
     
//      let paymentChannel = FlutterMethodChannel(name:"com.lamarTravel/paymentMethod",binaryMessenger: controller.binaryMessenger)
//
//      paymentChannel.setMethodCallHandler({(call:FlutterMethodCall,result: @escaping FlutterResult) ->Void in
//      guard call.method == "getPaymentMethod" else {
//          result(FlutterMethodNotImplemented)
//          return
//
//      }
//      self.recivePayment(result: result , call: call)
//
//  })
//
      
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
//    private func recivePayment(result:@escaping FlutterResult,call: FlutterMethodCall ){
//        let provider = OPPPaymentProvider(mode: OPPProviderMode.test)
//
//        let checkoutSettings = OPPCheckoutSettings()
//        var checkoutProvider = OPPCheckoutProvider()
//
//        let args = call.arguments as? Dictionary<String, Any>
//
//        let checkoutId = (args?["checkoutId"] as? String)!
//
//        let paymentBrand = (args?["brand"] as? String)!
//
//        if(paymentBrand == "ApplePay"){
//
//            let provider = OPPPaymentProvider(mode: OPPProviderMode.test)
//
//
//            let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: "merchant.lamartravelMerchant", countryCode: "SA")
//            checkoutSettings.applePayPaymentRequest = paymentRequest
//            checkoutSettings.shopperResultURL = "com.lamarTravelPackages"
//
//            let checkoutProvider = OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutId, settings: checkoutSettings)
//            checkoutProvider?.presentCheckout(withPaymentBrand: "APPLEPAY",
//               loadingHandler: { (inProgress) in
//                // Executed whenever SDK sends request to the server or receives the answer.
//                // You can start or stop loading animation based on inProgress parameter.
//            }, completionHandler: { (transaction, error) in
//                guard let transaction = transaction else {
//                    // Handle invalid transaction, check error
//                    result(FlutterError(code: "UNAVAILABLE ELSE",
//                                        message: "Payemt info unavailable",
//                                        details: nil))
//                    return
//
//                }
//                if transaction.type == .synchronous {
//                    // If a transaction is synchronous, just request the payment status
//                    // You can use transaction.resourcePath or just checkout ID to do it
//                    result(transaction.resourcePath)
//
//                } else if transaction.type == .asynchronous {
//                    // The SDK opens transaction.redirectUrl in a browser
//                    // See 'Asynchronous Payments' guide for more details
//                    result(transaction.redirectURL?.absoluteString)
//
//                } else {
//                    // Executed in case of failure of the transaction for any reason
//                    result(FlutterError(code: "UNAVAILABLE Else",
//                                        message: error.debugDescription,
//                                        details: nil))
//
//                }
//
//            }, cancelHandler: {
//                // Executed if the shopper closes the payment page prematurely
//                result(FlutterError(code: "UNAVAILABLE Error",
//                                    message: "Executed if the shopper closes the payment page prematurely",
//                                    details: nil))
//                })
//
//        }else{
//
//
//            if (paymentBrand == "Mada"){
//                checkoutSettings.paymentBrands = ["MADA"]
//
//                checkoutSettings.shopperResultURL = "com.lamarTravelPackages"
//
//
//                checkoutProvider = OPPCheckoutProvider(paymentProvider: provider,
//                                                       checkoutID: checkoutId , settings: checkoutSettings)!
//            }
//            else {
//                checkoutSettings.paymentBrands = ["VISA", "MASTER"]
//
//                checkoutSettings.shopperResultURL = "com.lamarTravelPackages"
//
//
//                checkoutProvider = OPPCheckoutProvider(paymentProvider: provider,
//                                                       checkoutID: checkoutId , settings: checkoutSettings)!
//
//            }
//
//            checkoutProvider.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
//
//                guard let transaction = transaction else {
//                    // Handle invalid transaction, check error
//                    result(FlutterError(code: "UNAVAILABLE ELSE",
//                                        message: "Payemt info unavailable",
//                                        details: nil))
//                    return
//
//                }
//                if transaction.type == .synchronous {
//                    // If a transaction is synchronous, just request the payment status
//                    // You can use transaction.resourcePath or just checkout ID to do it
//                    result(transaction.resourcePath)
//
//                } else if transaction.type == .asynchronous {
//                    // The SDK opens transaction.redirectUrl in a browser
//                    // See 'Asynchronous Payments' guide for more details
//                    result(transaction.redirectURL?.absoluteString)
//
//                } else {
//                    // Executed in case of failure of the transaction for any reason
//                    result(FlutterError(code: "UNAVAILABLE Else",
//                                        message: error.debugDescription,
//                                        details: nil))
//
//                }
//
//            }, cancelHandler: {
//                // Executed if the shopper closes the payment page prematurely
//                result(FlutterError(code: "UNAVAILABLE Error",
//                                    message: "Executed if the shopper closes the payment page prematurely",
//                                    details: nil))
//                })
//
//            }
        }
      





package com.lamartravelpackages

import android.content.Intent
import android.os.Build
import androidx.annotation.NonNull
import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity
import com.oppwa.mobile.connect.checkout.meta.CheckoutActivityResultContract
import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings
import com.oppwa.mobile.connect.exception.PaymentError
import com.oppwa.mobile.connect.provider.Connect
import com.oppwa.mobile.connect.provider.Transaction
import com.oppwa.mobile.connect.provider.TransactionType
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.lamarTravel/paymentMethod"
    var _result: MethodChannel.Result? = null
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
//
//            if (call.method.equals("getPaymentMethod")) {
//                _result = result ;
//                getPayment(call);
//
//                println(_result)
////
//            } else {
//                result.notImplemented();
//            }


        }
    }
//    private fun getPayment(call:MethodCall) {
//
//        val checkoutId = call.argument<String>("checkoutId")!!
//        val paymentBrands: MutableSet<String> = LinkedHashSet()
//        paymentBrands.add("VISA")
//        paymentBrands.add("MASTER")
//        val checkoutSettings =
//            CheckoutSettings(checkoutId, paymentBrands, Connect.ProviderMode.TEST)
//
//// Set shopper result URL
//        checkoutSettings.setShopperResultUrl("companyname://result");
//        val intent = CheckoutActivityResultContract().createIntent(this, checkoutSettings)
//        startActivityForResult(intent, CheckoutActivity.REQUEST_CODE_CHECKOUT)
//    }
//
//    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
//        super.onActivityResult(requestCode, resultCode, data)
//        println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//            println(
//                data.getParcelableExtra(
//                    "com.oppwa.mobile.connect.checkout.dialog.CHECKOUT_RESULT_TRANSACTION",
//                    Transaction::class.java
//                )
//            )
//        } else {
//            println(
//                data.getParcelableExtra("com.oppwa.mobile.connect.checkout.dialog.CHECKOUT_RESULT_TRANSACTION")
//            )
//        }
//        println(requestCode)
//        println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
//       if (data.data != null) {
//            when (resultCode) {
//                CheckoutActivity.RESULT_OK -> {
//                    println("OK  ")
//                    /* transaction completed */
//                    val transaction: Transaction? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//                        data.getParcelableExtra(
//                            CheckoutActivity.CHECKOUT_RESULT_TRANSACTION,
//                            Transaction::class.java
//                        )
//                    } else {
//                        data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_TRANSACTION)
//                    }
//
//
//                    /* resource path if needed */
//                    val resourcePath =
//                        data.getStringExtra(CheckoutActivity.CHECKOUT_RESULT_RESOURCE_PATH)
//                    if (transaction!!.transactionType == TransactionType.SYNC) {
//                        /* check the result of synchronous transaction */
//                        _result!!.success(transaction.paymentParams)
//                        println("OK TransactionType.SYNC")
//                    } else {
//                        /* wait for the asynchronous transaction callback in the onNewIntent() */
//                        _result!!.success(transaction.paymentParams)
//                        println("OK TransactionType.ASYNC")
//                    }
//
//                    println("OK")
//                }
//
//                CheckoutActivity.RESULT_CANCELED ->        {
//                    println("RESULT_CANCELED")
//                    _result!!.error(
//                            "UNAVAILABLE",
//                    "shopper canceled the checkout process",
//                    null
//
//                    )
//                }         /* shopper canceled the checkout process */
//
//
//                CheckoutActivity.RESULT_ERROR -> {
//                    println("ERROR  ")
//                    /* error occurred */_result!!.error(
//                        "UNAVAILABLE",
//                        CheckoutActivity.CHECKOUT_RESULT_ERROR,
//                        null
//                    )
//                    /* resource path if needed */
//                    var error: PaymentError?
//                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
//
//                        // error = data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_ERROR,PaymentError.class);
//                    } else {
//                        //  error = data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_ERROR);
//                    }
//                    println("ERROR  ")
//                }
//            }
//
//        }
//    }


}



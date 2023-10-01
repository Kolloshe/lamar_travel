package com.lamartravelpackages;

import static com.tekartik.sqflite.Constant.TAG;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity;
import com.oppwa.mobile.connect.checkout.meta.CheckoutActivityResultContract;
import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings;
import com.oppwa.mobile.connect.exception.PaymentError;
import com.oppwa.mobile.connect.provider.Connect;
import com.oppwa.mobile.connect.provider.Transaction;
import com.oppwa.mobile.connect.provider.TransactionType;

import java.util.LinkedHashSet;
import java.util.Set;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class checkoutBroadcastReceiver extends AppCompatActivity {
    MethodChannel.Result _result  ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_checkout_brodcast);
    }


    @Override
    protected void onResume() {
        super.onResume();
        getPayment();

    }

    private void getPayment() {
        Intent oldIntent = getIntent();
        String checkoutId = oldIntent.getStringExtra("checkoutId");
        Set<String> paymentBrands = new LinkedHashSet<String>();

        paymentBrands.add("VISA");
        paymentBrands.add("MASTER");


        CheckoutSettings checkoutSettings = new CheckoutSettings(checkoutId, paymentBrands, Connect.ProviderMode.TEST);

// Set shopper result URL
        checkoutSettings.setShopperResultUrl("https://test.oppwa.com://result");

        Intent intent =  new CheckoutActivityResultContract().createIntent(this,checkoutSettings);
  startActivityForResult(intent,CheckoutActivity.REQUEST_CODE_CHECKOUT);



    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

        if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            System.out.println( data.getParcelableExtra("com.oppwa.mobile.connect.checkout.dialog.CHECKOUT_RESULT_TRANSACTION",Transaction.class));

        } else {
            System.out.println(
                    data.getParcelableExtra("com.oppwa.mobile.connect.checkout.dialog.CHECKOUT_RESULT_TRANSACTION")

            );
        }

        System.out.println(requestCode);
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
     if( data.getData() !=null){
        switch (resultCode) {
            case CheckoutActivity.RESULT_OK:
                /* transaction completed */
                Transaction transaction;
                if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {

                    transaction = data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_TRANSACTION,Transaction.class);

                } else {
                    transaction = data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_TRANSACTION);
                }


                /* resource path if needed */
             String resourcePath = data.getStringExtra(CheckoutActivity.CHECKOUT_RESULT_RESOURCE_PATH);

                if (transaction.getTransactionType() == TransactionType.SYNC) {
                    /* check the result of synchronous transaction */
                    _result.success(transaction.getPaymentParams());
                } else {
                    /* wait for the asynchronous transaction callback in the onNewIntent() */
                    _result.success(transaction.getPaymentParams());
                }

                break;
            case CheckoutActivity.RESULT_CANCELED:
                /* shopper canceled the checkout process */
                _result.error("UNAVAILABLE", "shopper canceled the checkout process", null);
                break;
            case CheckoutActivity.RESULT_ERROR:
                /* error occurred */
                _result.error("UNAVAILABLE", CheckoutActivity.CHECKOUT_RESULT_ERROR, null);
                /* resource path if needed */
                PaymentError error;


                if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {

                 // error = data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_ERROR,PaymentError.class);

                } else {
                  //  error = data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_ERROR);
                }

        }

        finish();
   }
    }





}


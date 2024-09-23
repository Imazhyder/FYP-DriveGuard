import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paymob_pakistan/paymob_payment.dart';

class Paymob {
  Future<PaymobResponse> makePayment(
      BuildContext context, double totalprice) async {
    Completer<PaymobResponse> completer = Completer();

    int convertedTotalPrice = (totalprice * 100).toInt();

    try {
      PaymobPakistan.instance.initialize(
        apiKey:
            "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRVd05qY3hMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuVmhVRnk4cmZBTllQcmRTQmZ6ZjB5ZjVWTFdWeDlDV1ltVUhoekRGdUt4dUptT2NYaEhXLXdOMEdHeng0dU1POHVFZFcwaDVEemdSMVRFSnp5Y1R5TkE=",
        integrationID: 172913,
        iFrameID: 182213,
        jazzcashIntegrationId: 123456,
        easypaisaIntegrationID: 123456,
      );
      PaymentInitializationResult response =
          await PaymobPakistan.instance.initializePayment(
        currency: "PKR",
        amountInCents: convertedTotalPrice.toString(),
      );

      String authToken = response.authToken;
      int orderID = response.orderID;

      if (context.mounted) {
        PaymobPakistan.instance.makePayment(context,
            currency: "PKR",
            amountInCents: convertedTotalPrice.toString(),
            paymentType: PaymentType.card,
            authToken: authToken,
            orderID: orderID, onPayment: (response) {
          completer.complete(response);
        });
      }

      return completer.future;
    } catch (err) {
      rethrow;
    }
  }
}

// Card Number	5123456789012346
// Expiry Month	12
// Expiry Year	25
// CVV	123
// Name	Test Account


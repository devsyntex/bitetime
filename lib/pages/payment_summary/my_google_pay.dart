import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';

class MyGooglePay extends StatefulWidget {
  const MyGooglePay({super.key});

  @override
  State<MyGooglePay> createState() => _MyGooglePayState();
}

class _MyGooglePayState extends State<MyGooglePay> {
  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server or PSP
  }

  Future<Map<String, dynamic>> loadPaymentConfiguration() async {
    final String configString = await rootBundle.loadString('assets/sample_payment_configuration.json');
    return jsonDecode(configString);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: loadPaymentConfiguration(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        return GooglePayButton(
          paymentConfiguration: PaymentConfiguration.fromJsonString(snapshot.data! as String),
          paymentItems: _paymentItems,
          onPaymentResult: onGooglePayResult,
        );
      },
    );
  }
}

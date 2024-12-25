import 'dart:convert';

import 'package:bitetime/widget/app_constant.dart';
import 'package:http/http.dart' as http;

class Paymentservice {
  createPaymentintent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var secretkey = "sk_test_51QGkSCJnAJJSUSy0tdN4K1dtaWYY1hfTMCDPk6mRxuAqH0QbKJRdGx5fwppPAthJtF3VawePEc4MpriWRJyXv3U700ieD4gVVM";
      ;
      var response = await http.post(
        Uri.parse('http://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'bearer $secretkey',
          'Content-type': 'application/x-www-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body.toString());
    } catch (e) {
      print("error $e");
    }
  }
}

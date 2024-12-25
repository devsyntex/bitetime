import 'package:bitetime/service/database.dart';
import 'package:bitetime/service/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:bitetime/widget/app_widgets.dart';
import 'package:bitetime/widget/paymentsercice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int?add;

  getthesharedpref()async{
    wallet=await SharedPrefrenceHelper().getUserWallet();
    id = await SharedPrefrenceHelper().getUserId();
    setState(() {

    });
  }

  ontheload()async{
    await getthesharedpref();
    setState(() {

    });
  }

  @override
  void initState(){
    ontheload();
    super.initState();
  }
  Map<String, dynamic>? paymentIntent;
  Paymentservice paymentService = Paymentservice();
  final TextEditingController _customAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Center(
                      child: Text("Wallet",
                          style: AppWidget.headlineTextFieldStyle()))),
            ),
            SizedBox(height: 35.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xfff2f2f2)),
              child: Row(
                children: [
                  Icon(Icons.wallet_outlined, size: 60),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your Wallet", style: AppWidget.semiboldTextFieldStyle()),
                      SizedBox(height: 5.0),
                      Text("\$+100", style: AppWidget.boldTextFieldStyle()),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Add Money", style: AppWidget.semiboldTextFieldStyle()),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                pricebox(text: "\$500", onTap: () => makepayment("500")),
                pricebox(text: "\$1000", onTap: () => makepayment("1000")),
                pricebox(text: "\$2000", onTap: () => makepayment("2000")),
                pricebox(text: "\$5000", onTap: () => makepayment("5000")),
              ],
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => _showCustomAmountSheet(),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Add Money (Custom Amount)", style: AppWidget.boldTextFieldStyle()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makepayment(String amount) async {
    try {
      paymentIntent = await paymentService.createPaymentintent(amount, "USD");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: "US",
              testEnv: true,
              currencyCode: "PKR",
            ),
            merchantDisplayName: "DevSynex",
          ));
      displayPaymentSheet(amount);
    } catch (e) {
      print("Error: $e");
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentCustomerSheet();
      add= int.parse(wallet!)+int.parse(amount);
      await SharedPrefrenceHelper().saveUserWallet(add.toString());
      await DatabaseMethods().updateUserWallet(id!, add.toString());
      await getthesharedpref();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Paid Successfully")));
    } on StripeException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment Cancelled")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment Failed")));
      print("Error: $e");
    }
  }

  void _showCustomAmountSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Enter Amount", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            SizedBox(height: 10),
            TextField(
              controller: _customAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String enteredAmount = _customAmountController.text;
                if (enteredAmount.isNotEmpty && int.tryParse(enteredAmount) != null) {
                  Navigator.pop(context); // Close the bottom sheet
                  makepayment(enteredAmount); // Proceed with payment
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid amount")));
                }
              },
              child: Text("Proceed to Pay"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }
}

class pricebox extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const pricebox({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(5)),
          child: Text(text, style: AppWidget.lightTextFieldStyle()),
        ),
      ),
    );
  }
}

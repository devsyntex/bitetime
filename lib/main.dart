import 'package:bitetime/admin/home_admin.dart';
import 'package:bitetime/pages/Sign%20Up.dart';
import 'package:bitetime/pages/bottomnav.dart';
import 'package:bitetime/pages/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:bitetime/admin/add_food.dart';
import 'package:bitetime/admin/admin_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bitetime/pages/home.dart';
import 'package:bitetime/pages/onboard.dart';
import 'package:bitetime/pages/payment_summary/my_google_pay.dart';
import 'package:bitetime/widget/app_constant.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   // Stripe.publishableKey=publishablekey;


  // Initialize Firebase for Web
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //   apiKey: "AIzaSyD0r9U7S6ujMm1jv77enoRgJXBDZ2DKKT8",
    //   authDomain: "bitetime-6d9e3.firebaseapp.com",
    //   databaseURL: "https://bitetime-6d9e3-default-rtdb.firebaseio.com",
    //   projectId: "bitetime-6d9e3",
    //   storageBucket: "bitetime-6d9e3.appspot.com",
    //   messagingSenderId: "88068859744",
    //   appId: "1:88068859744:web:bf1982579eb8b218472005",
    //   measurementId: "G-6D24GX0618",
    // ),
  );



  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      // Wallet()
      // Bottomnav()
      // Signup()
      // Onboard()
      // AdminLogin()
      // AddFood()
      HomeAdmin()
      ,
      debugShowCheckedModeBanner: false,
    );
  }
}


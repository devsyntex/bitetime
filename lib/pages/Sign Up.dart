import 'package:bitetime/service/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitetime/pages/bottomnav.dart';
import 'package:bitetime/pages/home.dart';
import 'package:bitetime/pages/login.dart';
import 'package:bitetime/service/database.dart';
import 'package:bitetime/widget/app_widgets.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Declare variables to store user inputs
  String email = "", password = "", name = "";
  // Text editing controllers to retrieve input values from text fields
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  // Global key to uniquely identify the form and validate its input
  final _formkey = GlobalKey<FormState>();

  // Function to handle user registration
  regestration() async {
    // Check if the form is valid before proceeding
    if (_formkey.currentState!.validate()) {
      try {
        // Create a new user with email and password using Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // Show a success dialog if registration is successful
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Successful",
              style: AppWidget.boldTextFieldStyle(),
            ),
            content: Text("Registered Successfully"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("Got it"),
              )
            ],
          ),
        );
        String Id=randomAlphaNumeric(10);
        Map<String, dynamic>addUserInfo={
          "Name":namecontroller.text,
          "Email":emailcontroller.text,
          "Wallet":"0"
        };
        await DatabaseMethods().addUserDetail(addUserInfo, Id);
        await SharedPrefrenceHelper().saveUserName(namecontroller.text);
        await SharedPrefrenceHelper().saveUserEmail(emailcontroller.text);
        await SharedPrefrenceHelper().saveUserWallet('0');
        await SharedPrefrenceHelper().saveUserId(Id);
        // Navigate to the bottom navigation screen after the dialog is dismissed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Bottomnav(),
          ),
        );

        // Navigate to the bottom navigation screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Bottomnav(),
          ),
        );
      } on FirebaseException catch (e) {
        // Handle specific Firebase exceptions with customized messages
        if (e.code == 'weak-password') {
          // Show a SnackBar message for weak password
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                'Password Provided is too Weak',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          // Show a SnackBar message if the email is already in use
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.yellowAccent,
              content: Text('Account Already Exist'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is the main visual structure of the app screen
      body: Container(
        child: Stack(
          // Stack allows layering of widgets on top of each other
          children: [
            // Background container with gradient
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFff5c30), Color(0xFFe74b1a)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
            // Foreground container with white background
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Text(''), // Placeholder for additional content
            ),
            // Main content container with form fields and buttons
            Container(
              margin: EdgeInsets.only(top: 60.0, left: 20, right: 20),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.jpg', // Logo image
                      width: MediaQuery.of(context).size.width / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 50.0), // Space between elements
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // Form widget for input validation
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(height: 5.0),
                            Text(
                              'Sign Up',
                              style: AppWidget.headlineTextFieldStyle(),
                            ),
                            SizedBox(height: 15.0),
                            // Name input field
                            TextFormField(
                              controller: namecontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your Name";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'User Name',
                                hintStyle: AppWidget.semiboldTextFieldStyle(),
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            // Email input field
                            TextFormField(
                              controller: emailcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your E-mail";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: AppWidget.semiboldTextFieldStyle(),
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            // Password input field
                            TextFormField(
                              controller: passwordcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your Password";
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: AppWidget.semiboldTextFieldStyle(),
                                prefixIcon: Icon(Icons.password_outlined),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            // Sign-Up button
                            Material(
                              elevation: 5.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Update state and initiate registration
                                  setState(() {
                                    email = emailcontroller.text;
                                    name = namecontroller.text;
                                    password = passwordcontroller.text;
                                  });
                                  regestration(); // Call registration function
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffff5722), // Button background color
                                  padding: EdgeInsets.symmetric(vertical: 10.0), // Padding inside the button
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: 200, // Button width
                                  alignment: Alignment.center, // Center the text inside the button
                                  child: Text(
                                    'Sign-Up',
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Button to navigate to login page if the user already has an account
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: AppWidget.semiboldTextFieldStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bitetime/admin/home_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.only(top: 45, left: 20, right: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110.0))),
            ),
            Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 60),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Text(
                          "Let\'s Start with \n Admin!",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 20, top: 5.0,right: 20.0),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black,
                                        )),
                                    child: Center(
                                        child: TextFormField(
                                      controller: usernamecontroller,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Valid User-name";
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter user name",
                                          hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 160, 160, 147)),
                                          border: InputBorder.none),
                                    ))),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 20, top: 5.0,right: 20),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black,
                                        )),
                                    child: Center(
                                        child: TextFormField(
                                      controller: userpasswordcontroller,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Password here";
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter Your Password",
                                          hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 160, 160, 147)),
                                          border: InputBorder.none),
                                    ))),
                                SizedBox(
                                  height: 40.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    HomeAdmin();
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "LogIn",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["id"] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Your Id Is Not Correct",
            style: TextStyle(
              fontSize: 18.0,
            ),
          )));
        } else if (result.data()["Password"] !=
            userpasswordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Your Password Is Not Correct",
            style: TextStyle(
              fontSize: 18.0,
            ),
          )));
        } else {
          Route route = MaterialPageRoute(
            builder: (context) => HomeAdmin(),
          );
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}

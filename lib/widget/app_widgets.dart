import 'package:flutter/material.dart';
class AppWidget{
  static TextStyle boldTextFieldStyle(){
    return TextStyle(
      fontSize: 20,fontWeight: FontWeight.bold,
        color: Colors.black,fontFamily: 'poppins'
      );
}
static TextStyle headlineTextFieldStyle(){
    return TextStyle(
                 fontSize: 24.0,fontWeight: FontWeight.bold,
                 color: Colors.black,fontFamily: 'poppins'
    );
}
static TextStyle lightTextFieldStyle(){
    return TextStyle(
        fontSize: 15.0,fontWeight: FontWeight.w500,
        color: Colors.black38,fontFamily: 'poppins'
    );
}
  static TextStyle semiboldTextFieldStyle(){
    return TextStyle(
        fontSize: 18.0,fontWeight: FontWeight.w500,
        color: Colors.black38,fontFamily: 'poppins'
    );
  }
}
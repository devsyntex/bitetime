import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitetime/pages/Sign%20Up.dart';
class forget_password extends StatefulWidget {
  const forget_password({super.key});

  @override
  State<forget_password> createState() => _forget_passwordState();
}

class _forget_passwordState extends State<forget_password> {
  TextEditingController mailcontroller= new TextEditingController();

  String email='';
  final _formkey=GlobalKey<FormState>();

  resetpassword()async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
        "Password Reset Mail has been send  !", style: TextStyle(
          fontSize: 18.0
      ),
      )));
    } on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
          "No User Found for that email",style: TextStyle(fontSize: 18.0),
        )));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(

          children: [
            SizedBox(height: 70.0,),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "Password Recovery",style: TextStyle(
                  color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 10.0),
            Container(child: Text(
              "Enter Your Email",style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.white,fontSize: 20.0),),),
            Expanded(child: Form(
              key: _formkey,
              child: Padding(padding: EdgeInsets.only(left: 10.0),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 2.0),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextFormField(
                      controller: mailcontroller,
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Please-Enter-Email";
                        } return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person_outlined,size: 30,color: Colors.white70,),
                        hintText: "Email",
                        hintStyle: TextStyle(fontSize: 8.0,color: Colors.white)
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0,),
                  GestureDetector(
                    onTap: (){
                      if(_formkey.currentState!.validate()){
                        setState(() {
                          email = mailcontroller.text;
                        });
                        resetpassword();
                      }
                    },
                    child: Container(
                      width: 140,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Center(
                        child: (
                        Text('Send Email',style: TextStyle(
                          fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.bold
                        ),)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont Have an Account",style: TextStyle(fontSize: 10.0,color: Colors.white),),
                      SizedBox(width: 5.0,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:  (context) => Signup(),));
                        },
                        child: Text("Create",style: TextStyle(fontSize: 20.0,color: Color.fromARGB(225, 184, 166, 6),
                            fontWeight: FontWeight.w500),),
                      )
                    ],
                  )
                ],
              ),
            ),)),

          ],
        ),
      ),
    );
  }
}

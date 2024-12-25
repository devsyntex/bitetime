import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitetime/pages/Sign%20Up.dart';
import 'package:bitetime/pages/bottomnav.dart';
import 'package:bitetime/pages/forget-password.dart';
import 'package:bitetime/widget/app_widgets.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email='', password='';

  TextEditingController useremailcontroller= new TextEditingController();
  TextEditingController userpasswordcontroller= new TextEditingController();
  final _formkey=GlobalKey<FormState>();

  userLogin()async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(

            content: Text('No User Found at that Email',style:
              TextStyle(
                fontSize: 18.0,color: Colors.black
              ),)));
      } else if (e.code =='wrong-password'){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Wrong Password Provided by user',style:
          TextStyle(fontSize: 18.0,color: Colors.black),)));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Container(
          child: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFff5c30),Color(0xFFe74b1a)
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),topRight: Radius.circular(40.0)),
              ),
              child: Text(''),
            ),
            Container(
              margin: EdgeInsets.only(top: 60.0,left: 20,right: 20),
              child: Column(
                children: [
                  Center(child: Image.asset('assets/images/logo.jpg',width: MediaQuery.of(context).size.width/2,fit: BoxFit.cover,)),
                  SizedBox(height: 50.0,),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 20,right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/2,
                      decoration: BoxDecoration(
                        color: Colors.white,borderRadius: BorderRadius.circular(20)
                      ),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(height: 5.0,),
                            Text('Login',style: AppWidget.headlineTextFieldStyle(),),
                            SizedBox(height: 30.0,),
                            TextFormField(
                              controller: useremailcontroller,
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return "Please-Enter-Email";
                                }return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: AppWidget.semiboldTextFieldStyle(),
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            SizedBox(height: 30.0,),
                            TextFormField(
                              controller: userpasswordcontroller,
                              validator: (value){
                                if(value==null || value.isEmpty){
                                  return 'Please-provide-Password';
                                } return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Passward',
                                hintStyle: AppWidget.semiboldTextFieldStyle(),
                                prefixIcon: Icon(Icons.password_outlined)
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Container(alignment: Alignment.topRight,
                                child: TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => forget_password(),));
                                },
                                    child:Text('Forget Passward?',style: AppWidget.semiboldTextFieldStyle(),))),
                            SizedBox(height: 25,),
                            Material(elevation: 5.0,
                              child: ElevatedButton(
                                onPressed: (){
                                  if (_formkey.currentState!.validate()){
                                    setState(() {
                                      email=useremailcontroller.text;
                                      password=userpasswordcontroller.text;
                                    });
                                    userLogin();
                                  }
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  => Bottomnav(),));
                                },
                                style: ElevatedButton.styleFrom(

                                  backgroundColor: Color(0xffff5722), // Background color
                                  padding: EdgeInsets.symmetric(vertical: 10.0), // Vertical padding
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  width: 200, // Width of the button
                                  alignment: Alignment.center, // Center the text
                                  child: Text('Login',style: TextStyle(
                                    fontFamily: 'poppins',fontWeight: FontWeight.bold,
                                    color: Colors.white,fontSize: 18.0
                                  ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(),));
                  },
                      child:Text('Don\'t have an account? Sign Up',style: AppWidget.semiboldTextFieldStyle(),) ),

                ],
              ),
            )
          ],),
        ),
      ),
    );
  }
}


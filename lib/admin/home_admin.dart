import 'package:flutter/material.dart';
import 'package:bitetime/admin/add_food.dart';
import 'package:bitetime/widget/app_widgets.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(margin: EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(children: [
        Text("Home Admin",style: AppWidget.headlineTextFieldStyle(),),
        SizedBox(height: 50),
        GestureDetector(onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddFood(),));
        },
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10),
            child: Center(child: Container(padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset("assets/icons/pizza.png",height: 100,width: 100,),
                ),
                // SizedBox(width: 20,),
                Text("Add Food Items",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
              ],),
            ),),

          ),
        )
      ],),),

    );
  }
}

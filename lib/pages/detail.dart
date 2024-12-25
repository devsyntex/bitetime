import 'package:flutter/material.dart';
import 'package:bitetime/pages/home.dart';
import 'package:bitetime/widget/app_widgets.dart';

class Details extends StatefulWidget {
  const Details({super.key});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a=1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50,left: 20.0,right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context) => Home(),));
            },
                icon: Icon(Icons.navigate_before_outlined)),
            Image.asset('assets/icons/burger.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,fit: BoxFit.fill,          
            ),
            SizedBox(height: 15,),
           
            Row(
              children: [
                Column(
                  children: [
                    Text('Mediterian',style: AppWidget.semiboldTextFieldStyle(),),
                    Text('Chicken Burger',style: AppWidget.boldTextFieldStyle(),),
                  ],
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(onPressed: (){
                    if(a>1){
                      --a;
                    }
                    
                    setState(() {
                      
                    });
                  },
                      icon: Icon(Icons.remove,color: Colors.white,)),
                ),
                SizedBox(width: 20,),
                Text(a.toString(),style: AppWidget.semiboldTextFieldStyle(),),
                SizedBox(width: 20.0,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(onPressed: (){
                    ++a;
                    setState(() {
                      
                    });
                  },
                      icon: Icon(Icons.remove,color: Colors.white,)),
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style:AppWidget.lightTextFieldStyle(),maxLines: 5,),
            SizedBox(height: 30.0,),
            Row(
              children: [
                Text('Delivery Time',style: AppWidget.semiboldTextFieldStyle(),),
                SizedBox(width: 25,),
                Icon(Icons.alarm,color: Colors.grey,),
                SizedBox(width: 5.0,),
                Text('30 min',style: AppWidget.semiboldTextFieldStyle(),),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text('Total Price',style: AppWidget.boldTextFieldStyle(),),
                    Text('\$25',style: AppWidget.semiboldTextFieldStyle(),)
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Add to card',style: TextStyle(
                        fontFamily: 'poppins',color: Colors.white,
                      ),),
                      SizedBox(width: 30,),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.grey,borderRadius: BorderRadius.circular(8)
                        ),
                          child: Icon(Icons.shopping_cart_outlined,color: Colors.white,)),
                      SizedBox(width: 10,)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


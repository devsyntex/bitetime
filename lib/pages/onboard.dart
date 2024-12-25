import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitetime/pages/Sign%20Up.dart';
import 'package:bitetime/widget/app_widgets.dart';

import '../widget/content_Model.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex=0;
  late PageController _controller;
  @override
  void initState() {
    _controller=PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index){
                  setState(() {
                    currentIndex=index;

                  });
                },
                itemBuilder: (_, i){
              return Padding(padding: EdgeInsets.all(20),
                child: Column(children: [
                  Image.asset(contents[i].image,height: 300,width: MediaQuery.of(context).size.width/1.5,
                    fit: BoxFit.fill,),
                  SizedBox(height: 40.0,),
                  Text(contents[i].title,style: AppWidget.semiboldTextFieldStyle(),),
                  SizedBox(height: 20.0,),
                  Text(contents[i].description,style: AppWidget.lightTextFieldStyle(),)
                ],),
              );
            }),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centering the dots horizontally
            children: List.generate(contents.length, (index) => buildDot(index, context)),
          ),

          ElevatedButton(onPressed: (){
            if(currentIndex==contents.length -1){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signup(),));
            }
            _controller.nextPage(
                duration:Duration(milliseconds: 100),
                curve: Curves.bounceIn);
          }, child: Text(
              -currentIndex==contents.length -1?"Start":'Next'))
        ],
      ),
    );
  }
  Container buildDot(int index, BuildContext context){
    return Container(
      height: 10.0,
      width: currentIndex==index?18:7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),color: Colors.black38
      ),
    );
  }
}

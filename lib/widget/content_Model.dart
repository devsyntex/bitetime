import 'package:flutter/material.dart';

class onboardingContent{
  String image;
  String title;
  String description;
  onboardingContent({required this.description,required this.image,required this.title});
}
List<onboardingContent> contents=[
  onboardingContent(
      description:'Pick your food from our menu \n     more than 35 times' ,
      image: 'assets/onboardingicons/welcome.png',
      title: 'Select From our \n     Best menu'),

  onboardingContent(
      description:'Pick your food from our menu \n     more than 35 times' ,
      image: 'assets/icons/burger.png',
      title: 'Select From our \n     Best menu'),
];
import 'package:flutter/material.dart';
import 'package:social_app/Social_app/Login/social%20login.dart';
import 'package:social_app/Social_app/Cubit/cashe%20helper.dart';
import 'package:social_app/Network/reusable%20components.dart';
String? token ='';
void signout(context)
{
  CachHelper.removeData(key: 'token',).then((value){
    if(value)
    {
      navigateandFinish(context, SocialLogin());
    }
  });
}
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
const defaultcolor=Colors.blue;
String? uid;
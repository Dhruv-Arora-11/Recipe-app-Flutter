import 'package:flutter/material.dart';
import 'package:recipe_app/Screens/profile/alreadyLogin.dart';
import 'package:recipe_app/Screens/profile/notLogin.dart';

// ignore: must_be_immutable
class profile extends StatelessWidget {
  profile({super.key});

  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return ProfilePage(subTime: "woi",email:"qpo" ,fullName:"wo" ,subType:"wo" ,);
    }else{
      return RegisterModal();
    }
  }
}
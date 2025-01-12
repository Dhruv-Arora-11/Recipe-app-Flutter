
import 'package:flutter/material.dart';
import 'package:recipe_app/Screens/profile/alreadyLogin.dart';
import 'package:recipe_app/Screens/profile/notLoginUI.dart';

// ignore: must_be_immutable
class profile extends StatelessWidget {

  bool isLoginButtonPressed = false;

  profile({  
    super.key,
    required this.isLoginButtonPressed,
  });

  

  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return ProfilePage(subTime: "woi",email:"qpo" ,fullName:"wo" ,subType:"wo" ,);
    }else{
      return Notloginui();
    }
  }
}
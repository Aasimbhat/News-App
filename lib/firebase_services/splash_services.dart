import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view/homescreen.dart';
import 'package:news_app/view/login_screen.dart';

class SplashService{
  
  void isLogin(BuildContext,context){

    final auth=FirebaseAuth.instance;
  final user=auth.currentUser;
  if(user!=null){
    Timer(Duration(seconds: 3), () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
     }
     );
  }else{
    Timer(Duration(seconds: 3), () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>const LogInScreen())
);
     }
     );
    
    
  }
  }
}
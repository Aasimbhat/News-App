import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/firebase_services/splash_services.dart';
import 'package:news_app/view/homescreen.dart';
import 'package:news_app/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
SplashService splashService=SplashService();
@override


class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
  
    splashService.isLogin(BuildContext ,context);
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height * 1;
    final width=MediaQuery.of(context).size.width * 1;
    return Scaffold(
      
      body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [           
           Color(0xFFFFBBEC),
                Color(0xFFA9C9FF),
            

          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('images/Animation - 1696340221146.json'),
            // Image.asset('images/splash_pic.jpg',
            // fit: BoxFit.cover,
            // height:height * .5 ,
            // ),
            SizedBox(
              height: height*0.04,
            ),
             Text("Quick News--Your go to news app ",
            style: GoogleFonts.anton(letterSpacing: .6,color: Colors.white,fontSize: 24),
            ),
             SizedBox(
              height: height*0.04,
            ),
          const  SpinKitChasingDots(
              color: Color.fromARGB(255, 165, 233, 8),
              size: 60,
            )
            
          ],
        ),
      ),
    );
  }
}
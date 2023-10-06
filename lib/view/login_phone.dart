import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/utlis/Utlis.dart';
import 'package:news_app/view/verify_screen.dart';

class PhoneNumberLogin extends StatefulWidget {
  const PhoneNumberLogin({super.key});

  @override
  State<PhoneNumberLogin> createState() => _PhoneNumberLoginState();
}

class _PhoneNumberLoginState extends State<PhoneNumberLogin> {
  final phonecontroller = TextEditingController();
  final _formfield = GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFBBEC),
                Color(0xFFA9C9FF),
              ],
              // begin: Alignment.topCenter,
              // end: Alignment.bottomCenter
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 330,
                child: Lottie.asset(
                  'images/Animation9.json',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Enter Phone Number To Get The Code ",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formfield,
                child: Column(
                  children: [
                    TextFormField(
                      controller: phonecontroller,
                      decoration: InputDecoration(
                          hintText: 'Please enter +91 manually',
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          errorStyle: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 65, 60, 60)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          prefixIcon: Icon(Icons.mail)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Phone Number cant be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if (_formfield.currentState!.validate()) {}
                  auth.verifyPhoneNumber(
                    phoneNumber: phonecontroller.text,
                    verificationCompleted: (_){

                    },
                   verificationFailed: (e){
                    Utlis().toastMessage(e.toString());
                   }, 
                   
                   codeSent: (String verificationId,int? token){
                      Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>
                   VerifyScreen (verificationId: verificationId,)
                  )
                  );
                   },
                    codeAutoRetrievalTimeout: (e){
                     Utlis().toastMessage(e.toString());
                    });
                    
                },
                child: Container(
                  height: 60,
                  width: 200,
                  child: Center(
                    child: Text('Send Code',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 224, 16, 172),
                        Color(0xFF00DBDE),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

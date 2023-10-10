import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/utlis/Utlis.dart';
import 'package:news_app/view/forgot_password.dart';
import 'package:news_app/view/homescreen.dart';
import 'package:news_app/view/login_phone.dart';
import 'package:news_app/view/signup_screen.dart';
import 'package:news_app/widgets/Round_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formfield = GlobalKey<FormState>();
  final _auth=FirebaseAuth.instance;
  bool loading=false;
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, 
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                  fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration:const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFBBEC),
                  Color(0xFFA9C9FF),
                ],
                // begin: Alignment.topCenter,
                // end: Alignment.bottomCenter
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
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
                  height: 300,
                  child: Lottie.asset(
                    'images/Animation2.json',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formfield,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black) ,
                               errorStyle:GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 65, 60, 60)) ,
                         
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: const Icon(Icons.mail)),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please enter email";
                              }
    
                            },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black) ,
                               errorStyle:GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 65, 60, 60)) ,
                           
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                                ),
                            prefixIcon: const Icon(Icons.password)
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please enter password";
                              }
    
                            },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                  onTap: () {
                       Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PhoneNumberLogin()));
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    child: Center(
                      child: Text('Login with phone',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 55, 100, 184),
                          Color(0xFF00DBDE),
                        ],
                      ),
                    ),
                  ),
                ),
                   
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen()));
                          
                          },
                          child: Text('Forgot Password?',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: Text('Dont have an account Sign up',
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),

                            RoundButton(
                              loading: loading,
                              onTap: (){
                            if(_formfield.currentState!.validate()){
                                setState(() {
                  loading=true;
                });
                        
                      }
                      _auth.signInWithEmailAndPassword(email: emailcontroller.text.toString(), 
                      password: passwordcontroller.text.toString()).then((value) {
                       Utlis().toastMessage('Welcome to quick news');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        setState(() {
                          loading=true;
                        });

                      }).onError((error, stackTrace) {
                      Utlis().toastMessage(error.toString());
                      setState(() {
                        loading=false;
                      });
                      });

                            },
                            title: 'Login',
                            
                            ),
                // InkWell(
                //   onTap: () {
                //       if(_formfield.currentState!.validate()){
                        
                //       }
                //       _auth.signInWithEmailAndPassword(email: emailcontroller.text.toString(), 
                //       password: passwordcontroller.text.toString()).then((value) {
                //        Utlis().toastMessage('Welcome to quick news');
                //         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                //       }).onError((error, stackTrace) {
                //       Utlis().toastMessage(error.toString());
                //       });
                //   },
                //   child: Container(
                //     height: 60,
                //     width: 200,
                //     child: Center(
                //       child: Text('Login',
                //           style: GoogleFonts.poppins(
                //               fontSize: 25,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black)),
                //     ),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       gradient:  LinearGradient(
                //         colors: [
                //           Color.fromARGB(255, 55, 100, 184),
                //           Color(0xFF00DBDE),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

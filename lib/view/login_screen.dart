import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/view/signup_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Login',
          style: GoogleFonts.poppins(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black)
          ,),
        ),
         backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
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
        ),
      ),
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
                height: 300,
                child: Lottie.asset('images/Animation2.json',
                
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(30)
                  ),
                  prefixIcon: Icon(Icons.mail)
                  
                ),
              ),
               SizedBox(
                height: 30,
              ),
                 TextFormField(
                controller: passwordcontroller,
                obscureText: true,
                
                decoration: InputDecoration(
                  hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  prefixIcon: Icon(Icons.password)
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: (){
              
                }, child: Text('Forgot Password?',
                 style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black)
                )
                ),
                

              ),
              TextButton(onPressed: (){
              
                }, child: Text('Dont have an account Sign up',
                 style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black)
                )
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  },
                  child: Container(
                    height: 60,
                    width: 200,
                    child: Center(
                      child: Text('Login',
                                     style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black)
                    
                      
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                       gradient: LinearGradient(colors: [
                            Color(0xFFFC00FF),
                            Color(0xFF00DBDE),
                          ], ),
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
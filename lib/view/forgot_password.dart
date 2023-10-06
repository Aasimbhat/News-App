import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/utlis/Utlis.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
    final emailcontroller=TextEditingController();
  final _formfield=GlobalKey<FormState>();

  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                child: Lottie.asset('images/Animation4.json',
                
                ),
              ),
              SizedBox(
                height: 30,
              ),
               Text("Forgot password--we got you covered ",
               style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,
               
               ),
               SizedBox(
                height: 30,
              ),
              Form(
                key: _formfield,

                child: Column(
                  children: [
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: ' Enter Email',
                        hintStyle:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black) ,
                        
         errorStyle:GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 65, 60, 60)) ,

                        border: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(30)
                        ),
                        prefixIcon: Icon(Icons.mail)
                        
                      ),
                      validator: (value){
                        
                        
                       if(value!.isEmpty){
                        return ' Email cant be empty';
                       }else{
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
                  onTap: (){
                    if(_formfield.currentState!.validate()){
              
                    }
                    auth.sendPasswordResetEmail(email: emailcontroller.text.toString()).then((value) {
                    Utlis().toastMessage('Email send to reset password');
                    }).onError((error, stackTrace){
                      Utlis().toastMessage(error.toString());
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 200,
                    child: Center(
                      child: Text('Send Code',
                                     style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)
                    
                      
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
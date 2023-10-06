// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/utlis/Utlis.dart';
import 'package:news_app/view/homescreen.dart';

class VerifyScreen extends StatefulWidget {
    final String verificationId;

  const VerifyScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
    final phoneVerifycontroller=TextEditingController();
  final _formfield=GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
                child: Lottie.asset('images/Animation8.json',
                
                ),
              ),
              SizedBox(
                height: 30,
              ),
               Text("Enter the code sent....... ",
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
                      keyboardType: TextInputType.number,
                      controller: phoneVerifycontroller,
                      decoration: InputDecoration(
                        hintText: 'Enter 6 digit code',
                        hintStyle:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black) ,
                        
         errorStyle:GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 65, 60, 60)) ,

                        border: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(30)
                        ),
                        prefixIcon: Icon(Icons.mail)
                        
                      ),
                      validator: (value){
                        
                        
                       if(value!.isEmpty){
                        return ' Required';
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
                  onTap: ()async{
                    if(_formfield.currentState!.validate()){
              
                    }
                    final credential=PhoneAuthProvider.credential(verificationId:widget. verificationId, 
                    smsCode: phoneVerifycontroller.text.toUpperCase());
                    try{
                  await auth.signInWithCredential(credential);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    }catch(e){
                     Utlis().toastMessage(e.toString());
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 200,
                    child: Center(
                      child: Text('Verify',
                                     style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)
                    
                      
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                       gradient: LinearGradient(colors: [
                             Color.fromARGB(255, 224, 16, 172),
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
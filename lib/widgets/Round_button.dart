import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
 final bool loading;
  const RoundButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.loading=false
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
                    width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
                      gradient:  LinearGradient(
                        colors: [
                          Color.fromARGB(255, 55, 100, 184),
                          Color(0xFF00DBDE),
                        ],
                      ),
        ),
        child: Center(
          child: loading?CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): Center(
                      child: Text(title,
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
          ),
      ),
    );
  }
}
// Container(
//                     height: 60,
//                     width: 200,
//                     child: Center(
//                       child: Text('Login',
//                           style: GoogleFonts.poppins(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black)),
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       gradient:  LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 55, 100, 184),
//                           Color(0xFF00DBDE),
//                         ],
//                       ),
//                     ),
//                   ),

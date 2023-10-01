import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channel_headline_model.dart';
import 'package:news_app/view_model/news_view_model.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({super.key});

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
    NewsViewModel newsViewModel = NewsViewModel();

  @override
  final format=DateFormat('MMMM dd,yyyy');
  String name='bbc-news';
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text("Sample Page",
          style: GoogleFonts.poppins(
            fontSize: 24,
            color: Colors.black54        
          )),
        ),
      ),
      body: ListView(
        children:[
           Container(
          height:height*.55 ,
          width: width,
          child: FutureBuilder<NewsChannelHeadlineModel>(
            future: newsViewModel.fetchNewsChannelHeadlines(name), 
            builder: (BuildContext context, snapshot){
              
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: SpinKitChasingDots(size: 30,color: Colors.amber,),
              );
            }else{
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.articles!.length,
                itemBuilder: (context,index){
               return Container(
                 height: height*0.6,
                                    width: width*.9,
                                    padding: EdgeInsets.symmetric(horizontal: height*.02),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl:snapshot.data!.articles![index].urlToImage.toString() ,
                    fit: BoxFit.cover,
                    
                    
                    ),
                ),
               );
              });
            }
            }
          ),
        ),
        SizedBox(
          height: 20,
        ),
        //  Container(
        //   child:FutureBuilder<NewsChannelHeadlineModel>(
        //     future:newsViewModel. fetchNewsChannelHeadlines(name), 
            
        //     builder: (BuildContext context, snapshot) {
        //       if(snapshot.connectionState==ConnectionState.waiting){
        //        return SpinKitDancingSquare(
        //         color: Colors.amberAccent,
        //         size: 30,
        //        );
        //       }else{
        //         return ListView.builder(
        //           itemCount: snapshot.data!.articles!.length,
        //           itemBuilder: (context,index){
        //          return Container(
                 
        //          );
        //         });
        //       }
        //     })) ,
         
        ]
      
      ),
      
    );
  }
}
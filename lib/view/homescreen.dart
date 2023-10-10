import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/firebase_services/notification_services.dart';
import 'package:news_app/models/news_channel_headline_model.dart';
import 'package:news_app/models/sample_news_model.dart';
import 'package:news_app/utlis/Utlis.dart';
import 'package:news_app/view/categories.dart';
import 'package:news_app/view/login_screen.dart';
import 'package:news_app/view/news_detail_page.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, independent, reuters, cnn, aljazeera }

class _HomeScreenState extends State<HomeScreen> {
  
  NewsViewModel newsViewModel = NewsViewModel();
  final auth=FirebaseAuth.instance;
  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd,yyyy');
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
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
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoryScreen()));
            },
            icon: Image.asset(
              "images/category_icon.png",
              height: 30,
              width: 30,
            )),
        actions: [
          IconButton(onPressed: (){
             auth.signOut().then((value){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInScreen()));

             }).onError((error, stackTrace){
              Utlis().toastMessage(error.toString());
             });
          },
           icon: Icon(Icons.logout,color: Colors.black),),
          SizedBox(width: 10,),
          PopupMenuButton<FilterList>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }

                if (FilterList.cnn.name == item.name) {
                  name = 'cnn';
                }

                if (FilterList.aljazeera.name == item.name) {
                  name = 'al-jazeera-english';
                }

                setState(() {
                  selectedMenu = item;
                });
              },
              initialValue: selectedMenu,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews, child: Text('Bbc News')),
                    PopupMenuItem<FilterList>(
                        value: FilterList.cnn, child: Text('CNN News')),
                    PopupMenuItem<FilterList>(
                        value: FilterList.aljazeera,
                        child: Text('Aljazeera News')),
                  ])
        ],
        title: Center(
          child: Text('News',
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
             Color(0xFFFFBBEC),
                  Color(0xFFA9C9FF),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
             
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                height: height * .55,
                width: width,
                child: FutureBuilder<NewsChannelHeadlineModel>(
                    future: newsViewModel.fetchNewsChannelHeadlines(name),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitCircle(
                            color: Colors.blue,
                            size: 50,
                          ),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data?.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              return InkWell(
                                onTap: (){
                                     Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => NewsDetailScreen(
                      author: snapshot
                                  .data!.articles![index].author
                                  .toString(),
                     content: snapshot
                                  .data!.articles![index].content
                                  .toString(),
                      newsDate: snapshot
                                  .data!.articles![index].publishedAt
                                  .toString(), 
                      description: snapshot
                                  .data!.articles![index].description
                                  .toString(),
                       newsImage: snapshot
                                  .data!.articles![index].urlToImage
                                  .toString(),
                        newsTitle: snapshot
                                  .data!.articles![index].title
                                  .toString(),
                         source: snapshot
                                  .data!.articles![index].source!.name
                                  .toString(),
                         )
                         )
                         )
                         );

                                },
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: height * 0.6,
                                        width: width * .9,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: height * .02),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot
                                                .data!.articles![index].urlToImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                              child: spinkit2,
                                            ),
                                            errorWidget: (context, url, error) =>
                                                Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        child: Card(
                                          elevation: 5,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                   Color(0xFFFFBBEC),
                  Color(0xFFA9C9FF),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter),
                                            ),
                                            height: height * 0.22,
                                            alignment: Alignment.bottomCenter,
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width * 0.7,
                                                  child: Text(
                                                      snapshot.data!
                                                          .articles![index].title
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Spacer(),
                                                Container(
                                                  width: width * 0.7,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          snapshot
                                                              .data!
                                                              .articles![index]
                                                              .source!
                                                              .name
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              GoogleFonts.poppins(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                      Text(
                                                          format.format(dateTime),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              GoogleFonts.poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: height * .55,
                width: width,
                child: FutureBuilder<sampleText>(
                    future: newsViewModel.sampleTextApi(name),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitCircle(
                            color: Colors.blue,
                            size: 50,
                          ),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.articles!.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: height * .18,
                                        width: width * .3,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: const Center(
                                            child: SpinKitCircle(
                                              color: Colors.blue,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: height * .18,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            });
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);

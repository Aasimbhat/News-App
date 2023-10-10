import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headline_model.dart';
import 'package:news_app/models/sample_news_model.dart';

class NewsRepository{
  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlines(String channelName) async{
  String url="https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=317e185eb1d5442da43b35418ef15b0c";
  final response=await http.get(Uri.parse(url));

 
  

  if(response.statusCode==200){
    final body=jsonDecode(response.body);
  return NewsChannelHeadlineModel.fromJson(body);
  }
  throw Exception("Error Occured");
  }


  Future<CategoriesNewsModel> fetchCatagoriesNewsApi(String category) async{
  String url="https://newsapi.org/v2/everything?q=${category}&apiKey=317e185eb1d5442da43b35418ef15b0c";
  final response=await http.get(Uri.parse(url));

  if(response.statusCode==200){
    final body=jsonDecode(response.body);
  return CategoriesNewsModel.fromJson(body);
  }
  throw Exception("Error Occured");
  }

  Future<sampleText> sampleTextApi(String general) async{
  String url="https://newsapi.org/v2/everything?q=${general}&apiKey=317e185eb1d5442da43b35418ef15b0c";
  final response=await http.get(Uri.parse(url));
  

 
  

  if(response.statusCode==200){
    final body=jsonDecode(response.body);
  return sampleText.fromJson(body);
  }
  throw Exception('error occured');
}
}
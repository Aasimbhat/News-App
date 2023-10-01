

import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headline_model.dart';
import 'package:news_app/repository/news_repository.dart';

import '../models/sample_news_model.dart';

class NewsViewModel{
  final _rep=NewsRepository();

  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlines(String channelName)async{
    final response=await  _rep.fetchNewsChannelHeadlines(channelName);
    return response;
  }

    Future<CategoriesNewsModel> fetchCatagoriesNewsApi(String category)async{
    final response=await  _rep.fetchCatagoriesNewsApi(category);
    return response;
  }

  Future<sampleText> sampleTextApi(String category)async{
    final response=await  _rep.sampleTextApi(category);
    return response;
  }
}
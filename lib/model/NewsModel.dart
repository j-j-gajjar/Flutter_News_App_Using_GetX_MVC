import 'dart:convert';

import 'package:newsappflutter/model/ArticalModel.dart';

class NewsModel {
  NewsModel({required this.status, required this.totalResults, required this.articles});

  final String status;
  final int totalResults;
  final List<Article> articles;

  factory NewsModel.newsFromJson(String str) => NewsModel.fromJson(json.decode(str));

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"] == null ? null : json["status"],
        totalResults: json["totalResults"] == null ? null : json["totalResults"],
        articles: json["articles"] == [] ? [] : List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
      );
}

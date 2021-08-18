// // To parse this JSON data, do
// //
// //     final news = newsFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// import 'package:newsappflutter/model/SourceModel.dart';
//
// News newsFromJson(String str) => News.fromJson(json.decode(str));
//
// // String newsToJson(News data) => json.encode(data.toJson());
//
// class News {
//   News({
//     required this.source,
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });
//
//   final Source source;
//   final String author;
//   final String title;
//   final String description;
//   final String url;
//   final String urlToImage;
//   final String publishedAt;
//   final String content;
//
//   factory News.fromJson(Map<String, dynamic> json) => News(
//         source: Source.fromJson(json["source"]),
//         author: json["author"] == null ? '' : json["author"],
//         title: json["title"] == null ? '' : json["title"],
//         description: json["description"] == null ? '' : json["description"],
//         url: json["url"] == null ? '' : json["url"],
//         urlToImage: json["urlToImage"] == null ? '' : json["urlToImage"],
//         publishedAt: json["publishedAt"] == null ? '' : json["publishedAt"],
//         content: json["content"] == null ? '' : json["content"],
//       );
//
//   // Map<String, dynamic> toJson() => {
//   //       "source": source == null ? '' : source.toJson(),
//   //       "author": author == null ? '' : author,
//   //       "title": title == null ? '' : title,
//   //       "description": description == null ? '' : description,
//   //       "url": url == null ? '' : url,
//   //       "urlToImage": urlToImage == null ? '' : urlToImage,
//   //       "publishedAt": publishedAt == null ? '' : publishedAt,
//   //       "content": content == null ? '' : content,
//   //     };
// }

import 'dart:convert';

import 'package:newsappflutter/model/ArticalModel.dart';

//
// String newsToJson(News data) => json.encode(data.toJson());

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

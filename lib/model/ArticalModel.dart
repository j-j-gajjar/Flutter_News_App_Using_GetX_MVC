import 'package:newsappflutter/model/SourceModel.dart';

class Article {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] == null ? '' : json["author"],
        title: json["title"] == null ? '' : json["title"],
        description: json["description"] == null ? '' : json["description"],
        url: json["url"] == null ? '' : json["url"],
        urlToImage: json["urlToImage"] == null ? '' : json["urlToImage"],
        publishedAt: json["publishedAt"] == null ? '' : json["publishedAt"],
        content: json["content"] == null ? '' : json["content"],
      );
}

import 'package:json_annotation/json_annotation.dart';
import 'SourceModel.dart';

part 'ArticalModel.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {
  Article(this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content);

  String? author, description, urlToImage, content;
  String title, url, publishedAt;
  Source source;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

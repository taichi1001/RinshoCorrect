import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  const factory Article({
    String id,
    DateTime publishedAt,
    String title,
    String subTitle,
    @JsonKey(fromJson: _parseTags) List<String> tags,
    @JsonKey(name: 'abstract') String abst,
    String body,
    Uri eyecath,
    String videoURL,
  }) = _Article;
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}

List<String> _parseTags(value) {
  final tagFromJson = value['tag'];
  return List<String>.from(tagFromJson);
}

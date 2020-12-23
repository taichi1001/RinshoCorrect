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
    @JsonKey(name: 'subtitle') String subTitle,
    @JsonKey(name: 'tag', fromJson: _parseTags) List<String> tags,
    @JsonKey(name: 'abstract') String abst,
    String body,
    // article.g.dartのeyecatchの欄を eyecatch: _parseEyeCatch(json['eyecatch']['url'])に書き換える
    @JsonKey(name: 'url', fromJson: _parseEyeCatch) Uri eyecatch,
    // @JsonKey(name: 'video_abs') String videoAbs,
    @JsonKey(name: 'video') String videoURL,
  }) = _Article;
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}

Uri _parseEyeCatch(value) => Uri.parse(value);

List<String> _parseTags(value) => List<String>.from(value);

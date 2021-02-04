import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:rinsho_collect/entity/term.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  const factory Article({
    String id,
    DateTime publishedAt,
    String title,
    @JsonKey(name: 'tag', fromJson: _parseTags) List<String> tags,
    @JsonKey(name: 'symptom_disorder', fromJson: _parseSymptomDisorder)
        List<String> symptomDisorder,
    String abstract,
    @JsonKey(name: 'approch_target') String approchTarget,
    String body,
    // article.g.dartのeyecatchの欄を eyecatch: _parseEyeCatch(json['eyecatch']['url'])に書き換える
    @JsonKey(name: 'url', fromJson: _parseEyeCatch) Uri eyecatch,
    @JsonKey(name: 'video', fromJson: _parseVideoURL) String videoURL,
    @JsonKey(fromJson: _parseGlossary) List<Term> glossary,
    String author,
    String twitter,
    String instagram,
    String webURL,
    String references,
  }) = _Article;
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}

Uri _parseEyeCatch(value) {
  if (value == null) {
    return null;
  }
  return Uri.parse(value);
}

List<String> _parseTags(value) {
  if (value == null) {
    return null;
  }
  return List<String>.from(value);
}

List<String> _parseSymptomDisorder(value) {
  if (value == null) {
    return null;
  }
  return List<String>.from(value);
}

String _parseVideoURL(String value) {
  if (value == null) {
    return null;
  } else {
    final splitURL = value?.split('/');
    final videoId = splitURL[splitURL.length - 2];
    return 'https://drive.google.com/uc?id=$videoId';
  }
}

List<Term> _parseGlossary(value) {
  if (value == null) {
    return null;
  } else {
    final terms = List<Map<String, dynamic>>.from(value);
    return terms.map((json) => Term.fromJson(json)).toList();
  }
}

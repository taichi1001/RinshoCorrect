// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Article _$_$_ArticleFromJson(Map<String, dynamic> json) {
  return _$_Article(
    id: json['id'] as String,
    publishedAt: json['publishedAt'] == null ? null : DateTime.parse(json['publishedAt'] as String),
    title: json['title'] as String,
    tags: _parseTags(json['tag']),
    symptomDisorder: _parseSymptomDisorder(json['symptom_disorder']),
    abstract: json['abstract'] as String,
    body: json['body'] as String,
    eyecatch: _parseEyeCatch(json['eyecatch']['url']),
    videoURL: _parseVideoURL(json['video'] as String),
    glossary: _parseGlossary(json['glossary']),
    author: json['author'] as String,
    twitter: json['twitter'] as String,
    instagram: json['instagram'] as String,
    webURL: json['webURL'] as String,
    references: json['references'] as String,
  );
}

Map<String, dynamic> _$_$_ArticleToJson(_$_Article instance) => <String, dynamic>{
      'id': instance.id,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'title': instance.title,
      'tag': instance.tags,
      'symptom_disorder': instance.symptomDisorder,
      'abstract': instance.abstract,
      'body': instance.body,
      'url': instance.eyecatch?.toString(),
      'video': instance.videoURL,
      'glossary': instance.glossary,
      'author': instance.author,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'webURL': instance.webURL,
      'references': instance.references,
    };

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
    subTitle: json['subtitle'] as String,
    tags: _parseTags(json['tag']),
    abst: json['abstract'] as String,
    body: json['body'] as String,
    eyecatch: _parseEyeCatch(json['eyecatch']['url']),
    videoURL: json['video'] as String,
  );
}

Map<String, dynamic> _$_$_ArticleToJson(_$_Article instance) => <String, dynamic>{
      'id': instance.id,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'title': instance.title,
      'subtitle': instance.subTitle,
      'tag': instance.tags,
      'abstract': instance.abst,
      'body': instance.body,
      'url': instance.eyecatch?.toString(),
      'video': instance.videoURL,
    };

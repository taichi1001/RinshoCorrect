// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Article _$_$_ArticleFromJson(Map<String, dynamic> json) {
  return _$_Article(
    id: json['id'] as String,
    publishedAt: json['publishedAt'] == null
        ? null
        : DateTime.parse(json['publishedAt'] as String),
    title: json['title'] as String,
    subTitle: json['subTitle'] as String,
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
    abst: json['abstract'] as String,
    body: json['body'] as String,
    eyecath:
        json['eyecath'] == null ? null : Uri.parse(json['eyecath'] as String),
    videoURL: json['videoURL'] as String,
  );
}

Map<String, dynamic> _$_$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'id': instance.id,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'title': instance.title,
      'subTitle': instance.subTitle,
      'tags': instance.tags,
      'abstract': instance.abst,
      'body': instance.body,
      'eyecath': instance.eyecath?.toString(),
      'videoURL': instance.videoURL,
    };

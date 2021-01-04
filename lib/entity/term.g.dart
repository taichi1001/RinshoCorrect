// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Term _$_$_TermFromJson(Map<String, dynamic> json) {
  return _$_Term(
    id: json['id'] as String,
    publishedAt: json['publishedAt'] == null
        ? null
        : DateTime.parse(json['publishedAt'] as String),
    term: json['term'] as String,
    detail: json['body'] as String,
  );
}

Map<String, dynamic> _$_$_TermToJson(_$_Term instance) => <String, dynamic>{
      'id': instance.id,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'term': instance.term,
      'body': instance.detail,
    };

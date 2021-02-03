// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bookmark _$_$_BookmarkFromJson(Map<String, dynamic> json) {
  return _$_Bookmark(
    id: json['id'] as String,
    isBookmark: _isBookmarkFromJson(json['isBookmark']),
  );
}

Map<String, dynamic> _$_$_BookmarkToJson(_$_Bookmark instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isBookmark': _isBookmarkToJson(instance.isBookmark),
    };

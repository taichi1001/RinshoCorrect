import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'bookmark.freezed.dart';
part 'bookmark.g.dart';

@freezed
abstract class Bookmark with _$Bookmark {
  const factory Bookmark({
    String id,
    @JsonKey(fromJson: _isBookmarkFromJson, toJson: _isBookmarkToJson) bool isBookmark,
  }) = _Bookmark;
  factory Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);
}

bool _isBookmarkFromJson(value) {
  return value == 0 ? true : false;
}

int _isBookmarkToJson(value) {
  return value ? 0 : 1;
}

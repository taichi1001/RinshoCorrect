// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bookmark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Bookmark _$BookmarkFromJson(Map<String, dynamic> json) {
  return _Bookmark.fromJson(json);
}

/// @nodoc
class _$BookmarkTearOff {
  const _$BookmarkTearOff();

// ignore: unused_element
  _Bookmark call(
      {String id,
      @JsonKey(fromJson: _isBookmarkFromJson, toJson: _isBookmarkToJson)
          bool isBookmark}) {
    return _Bookmark(
      id: id,
      isBookmark: isBookmark,
    );
  }

// ignore: unused_element
  Bookmark fromJson(Map<String, Object> json) {
    return Bookmark.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Bookmark = _$BookmarkTearOff();

/// @nodoc
mixin _$Bookmark {
  String get id;
  @JsonKey(fromJson: _isBookmarkFromJson, toJson: _isBookmarkToJson)
  bool get isBookmark;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $BookmarkCopyWith<Bookmark> get copyWith;
}

/// @nodoc
abstract class $BookmarkCopyWith<$Res> {
  factory $BookmarkCopyWith(Bookmark value, $Res Function(Bookmark) then) =
      _$BookmarkCopyWithImpl<$Res>;
  $Res call(
      {String id,
      @JsonKey(fromJson: _isBookmarkFromJson, toJson: _isBookmarkToJson)
          bool isBookmark});
}

/// @nodoc
class _$BookmarkCopyWithImpl<$Res> implements $BookmarkCopyWith<$Res> {
  _$BookmarkCopyWithImpl(this._value, this._then);

  final Bookmark _value;
  // ignore: unused_field
  final $Res Function(Bookmark) _then;

  @override
  $Res call({
    Object id = freezed,
    Object isBookmark = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      isBookmark:
          isBookmark == freezed ? _value.isBookmark : isBookmark as bool,
    ));
  }
}

/// @nodoc
abstract class _$BookmarkCopyWith<$Res> implements $BookmarkCopyWith<$Res> {
  factory _$BookmarkCopyWith(_Bookmark value, $Res Function(_Bookmark) then) =
      __$BookmarkCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @JsonKey(fromJson: _isBookmarkFromJson, toJson: _isBookmarkToJson)
          bool isBookmark});
}

/// @nodoc
class __$BookmarkCopyWithImpl<$Res> extends _$BookmarkCopyWithImpl<$Res>
    implements _$BookmarkCopyWith<$Res> {
  __$BookmarkCopyWithImpl(_Bookmark _value, $Res Function(_Bookmark) _then)
      : super(_value, (v) => _then(v as _Bookmark));

  @override
  _Bookmark get _value => super._value as _Bookmark;

  @override
  $Res call({
    Object id = freezed,
    Object isBookmark = freezed,
  }) {
    return _then(_Bookmark(
      id: id == freezed ? _value.id : id as String,
      isBookmark:
          isBookmark == freezed ? _value.isBookmark : isBookmark as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Bookmark with DiagnosticableTreeMixin implements _Bookmark {
  const _$_Bookmark(
      {this.id,
      @JsonKey(fromJson: _isBookmarkFromJson, toJson: _isBookmarkToJson)
          this.isBookmark});

  factory _$_Bookmark.fromJson(Map<String, dynamic> json) =>
      _$_$_BookmarkFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(fromJson: _isBookmarkFromJson, toJson: _isBookmarkToJson)
  final bool isBookmark;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Bookmark(id: $id, isBookmark: $isBookmark)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Bookmark'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('isBookmark', isBookmark));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Bookmark &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.isBookmark, isBookmark) ||
                const DeepCollectionEquality()
                    .equals(other.isBookmark, isBookmark)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(isBookmark);

  @JsonKey(ignore: true)
  @override
  _$BookmarkCopyWith<_Bookmark> get copyWith =>
      __$BookmarkCopyWithImpl<_Bookmark>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BookmarkToJson(this);
  }
}

abstract class _Bookmark implements Bookmark {
  const factory _Bookmark(
      {String id,
      @JsonKey(fromJson: _isBookmarkFromJson, toJson: _isBookmarkToJson)
          bool isBookmark}) = _$_Bookmark;

  factory _Bookmark.fromJson(Map<String, dynamic> json) = _$_Bookmark.fromJson;

  @override
  String get id;
  @override
  @JsonKey(fromJson: _isBookmarkFromJson, toJson: _isBookmarkToJson)
  bool get isBookmark;
  @override
  @JsonKey(ignore: true)
  _$BookmarkCopyWith<_Bookmark> get copyWith;
}

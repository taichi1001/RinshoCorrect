// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
class _$ArticleTearOff {
  const _$ArticleTearOff();

// ignore: unused_element
  _Article call(
      {String id,
      DateTime publishedAt,
      String title,
      String subTitle,
      @JsonKey(fromJson: _parseTags) List<String> tags,
      @JsonKey(name: 'abstract') String abst,
      String body,
      Uri eyecath,
      String videoURL}) {
    return _Article(
      id: id,
      publishedAt: publishedAt,
      title: title,
      subTitle: subTitle,
      tags: tags,
      abst: abst,
      body: body,
      eyecath: eyecath,
      videoURL: videoURL,
    );
  }

// ignore: unused_element
  Article fromJson(Map<String, Object> json) {
    return Article.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Article = _$ArticleTearOff();

/// @nodoc
mixin _$Article {
  String get id;
  DateTime get publishedAt;
  String get title;
  String get subTitle;
  @JsonKey(fromJson: _parseTags)
  List<String> get tags;
  @JsonKey(name: 'abstract')
  String get abst;
  String get body;
  Uri get eyecath;
  String get videoURL;

  Map<String, dynamic> toJson();
  $ArticleCopyWith<Article> get copyWith;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res>;
  $Res call(
      {String id,
      DateTime publishedAt,
      String title,
      String subTitle,
      @JsonKey(fromJson: _parseTags) List<String> tags,
      @JsonKey(name: 'abstract') String abst,
      String body,
      Uri eyecath,
      String videoURL});
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res> implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  final Article _value;
  // ignore: unused_field
  final $Res Function(Article) _then;

  @override
  $Res call({
    Object id = freezed,
    Object publishedAt = freezed,
    Object title = freezed,
    Object subTitle = freezed,
    Object tags = freezed,
    Object abst = freezed,
    Object body = freezed,
    Object eyecath = freezed,
    Object videoURL = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as DateTime,
      title: title == freezed ? _value.title : title as String,
      subTitle: subTitle == freezed ? _value.subTitle : subTitle as String,
      tags: tags == freezed ? _value.tags : tags as List<String>,
      abst: abst == freezed ? _value.abst : abst as String,
      body: body == freezed ? _value.body : body as String,
      eyecath: eyecath == freezed ? _value.eyecath : eyecath as Uri,
      videoURL: videoURL == freezed ? _value.videoURL : videoURL as String,
    ));
  }
}

/// @nodoc
abstract class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) then) =
      __$ArticleCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      DateTime publishedAt,
      String title,
      String subTitle,
      @JsonKey(fromJson: _parseTags) List<String> tags,
      @JsonKey(name: 'abstract') String abst,
      String body,
      Uri eyecath,
      String videoURL});
}

/// @nodoc
class __$ArticleCopyWithImpl<$Res> extends _$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(_Article _value, $Res Function(_Article) _then)
      : super(_value, (v) => _then(v as _Article));

  @override
  _Article get _value => super._value as _Article;

  @override
  $Res call({
    Object id = freezed,
    Object publishedAt = freezed,
    Object title = freezed,
    Object subTitle = freezed,
    Object tags = freezed,
    Object abst = freezed,
    Object body = freezed,
    Object eyecath = freezed,
    Object videoURL = freezed,
  }) {
    return _then(_Article(
      id: id == freezed ? _value.id : id as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as DateTime,
      title: title == freezed ? _value.title : title as String,
      subTitle: subTitle == freezed ? _value.subTitle : subTitle as String,
      tags: tags == freezed ? _value.tags : tags as List<String>,
      abst: abst == freezed ? _value.abst : abst as String,
      body: body == freezed ? _value.body : body as String,
      eyecath: eyecath == freezed ? _value.eyecath : eyecath as Uri,
      videoURL: videoURL == freezed ? _value.videoURL : videoURL as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Article with DiagnosticableTreeMixin implements _Article {
  const _$_Article(
      {this.id,
      this.publishedAt,
      this.title,
      this.subTitle,
      @JsonKey(fromJson: _parseTags) this.tags,
      @JsonKey(name: 'abstract') this.abst,
      this.body,
      this.eyecath,
      this.videoURL});

  factory _$_Article.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleFromJson(json);

  @override
  final String id;
  @override
  final DateTime publishedAt;
  @override
  final String title;
  @override
  final String subTitle;
  @override
  @JsonKey(fromJson: _parseTags)
  final List<String> tags;
  @override
  @JsonKey(name: 'abstract')
  final String abst;
  @override
  final String body;
  @override
  final Uri eyecath;
  @override
  final String videoURL;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Article(id: $id, publishedAt: $publishedAt, title: $title, subTitle: $subTitle, tags: $tags, abst: $abst, body: $body, eyecath: $eyecath, videoURL: $videoURL)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Article'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('publishedAt', publishedAt))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('subTitle', subTitle))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('abst', abst))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('eyecath', eyecath))
      ..add(DiagnosticsProperty('videoURL', videoURL));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Article &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.publishedAt, publishedAt) ||
                const DeepCollectionEquality()
                    .equals(other.publishedAt, publishedAt)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.subTitle, subTitle) ||
                const DeepCollectionEquality()
                    .equals(other.subTitle, subTitle)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.abst, abst) ||
                const DeepCollectionEquality().equals(other.abst, abst)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.eyecath, eyecath) ||
                const DeepCollectionEquality()
                    .equals(other.eyecath, eyecath)) &&
            (identical(other.videoURL, videoURL) ||
                const DeepCollectionEquality()
                    .equals(other.videoURL, videoURL)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(publishedAt) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(subTitle) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(abst) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(eyecath) ^
      const DeepCollectionEquality().hash(videoURL);

  @override
  _$ArticleCopyWith<_Article> get copyWith =>
      __$ArticleCopyWithImpl<_Article>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ArticleToJson(this);
  }
}

abstract class _Article implements Article {
  const factory _Article(
      {String id,
      DateTime publishedAt,
      String title,
      String subTitle,
      @JsonKey(fromJson: _parseTags) List<String> tags,
      @JsonKey(name: 'abstract') String abst,
      String body,
      Uri eyecath,
      String videoURL}) = _$_Article;

  factory _Article.fromJson(Map<String, dynamic> json) = _$_Article.fromJson;

  @override
  String get id;
  @override
  DateTime get publishedAt;
  @override
  String get title;
  @override
  String get subTitle;
  @override
  @JsonKey(fromJson: _parseTags)
  List<String> get tags;
  @override
  @JsonKey(name: 'abstract')
  String get abst;
  @override
  String get body;
  @override
  Uri get eyecath;
  @override
  String get videoURL;
  @override
  _$ArticleCopyWith<_Article> get copyWith;
}

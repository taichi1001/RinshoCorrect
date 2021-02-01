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
      @JsonKey(name: 'tag', fromJson: _parseTags)
          List<String> tags,
      @JsonKey(name: 'symptom_disorder', fromJson: _parseSymptomDisorder)
          List<String> symptomDisorder,
      String abstract,
      @JsonKey(name: 'approch_target')
          String approchTarget,
      String body,
      @JsonKey(name: 'url', fromJson: _parseEyeCatch)
          Uri eyecatch,
      @JsonKey(name: 'video', fromJson: _parseVideoURL)
          String videoURL,
      @JsonKey(fromJson: _parseGlossary)
          List<Term> glossary,
      String author,
      String twitter,
      String instagram,
      String webURL,
      String references}) {
    return _Article(
      id: id,
      publishedAt: publishedAt,
      title: title,
      tags: tags,
      symptomDisorder: symptomDisorder,
      abstract: abstract,
      approchTarget: approchTarget,
      body: body,
      eyecatch: eyecatch,
      videoURL: videoURL,
      glossary: glossary,
      author: author,
      twitter: twitter,
      instagram: instagram,
      webURL: webURL,
      references: references,
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
  @JsonKey(name: 'tag', fromJson: _parseTags)
  List<String> get tags;
  @JsonKey(name: 'symptom_disorder', fromJson: _parseSymptomDisorder)
  List<String> get symptomDisorder;
  String get abstract;
  @JsonKey(name: 'approch_target')
  String get approchTarget;
  String
      get body; // article.g.dartのeyecatchの欄を eyecatch: _parseEyeCatch(json['eyecatch']['url'])に書き換える
  @JsonKey(name: 'url', fromJson: _parseEyeCatch)
  Uri get eyecatch;
  @JsonKey(name: 'video', fromJson: _parseVideoURL)
  String get videoURL;
  @JsonKey(fromJson: _parseGlossary)
  List<Term> get glossary;
  String get author;
  String get twitter;
  String get instagram;
  String get webURL;
  String get references;

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
      @JsonKey(name: 'tag', fromJson: _parseTags)
          List<String> tags,
      @JsonKey(name: 'symptom_disorder', fromJson: _parseSymptomDisorder)
          List<String> symptomDisorder,
      String abstract,
      @JsonKey(name: 'approch_target')
          String approchTarget,
      String body,
      @JsonKey(name: 'url', fromJson: _parseEyeCatch)
          Uri eyecatch,
      @JsonKey(name: 'video', fromJson: _parseVideoURL)
          String videoURL,
      @JsonKey(fromJson: _parseGlossary)
          List<Term> glossary,
      String author,
      String twitter,
      String instagram,
      String webURL,
      String references});
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
    Object tags = freezed,
    Object symptomDisorder = freezed,
    Object abstract = freezed,
    Object approchTarget = freezed,
    Object body = freezed,
    Object eyecatch = freezed,
    Object videoURL = freezed,
    Object glossary = freezed,
    Object author = freezed,
    Object twitter = freezed,
    Object instagram = freezed,
    Object webURL = freezed,
    Object references = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as DateTime,
      title: title == freezed ? _value.title : title as String,
      tags: tags == freezed ? _value.tags : tags as List<String>,
      symptomDisorder: symptomDisorder == freezed
          ? _value.symptomDisorder
          : symptomDisorder as List<String>,
      abstract: abstract == freezed ? _value.abstract : abstract as String,
      approchTarget: approchTarget == freezed
          ? _value.approchTarget
          : approchTarget as String,
      body: body == freezed ? _value.body : body as String,
      eyecatch: eyecatch == freezed ? _value.eyecatch : eyecatch as Uri,
      videoURL: videoURL == freezed ? _value.videoURL : videoURL as String,
      glossary: glossary == freezed ? _value.glossary : glossary as List<Term>,
      author: author == freezed ? _value.author : author as String,
      twitter: twitter == freezed ? _value.twitter : twitter as String,
      instagram: instagram == freezed ? _value.instagram : instagram as String,
      webURL: webURL == freezed ? _value.webURL : webURL as String,
      references:
          references == freezed ? _value.references : references as String,
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
      @JsonKey(name: 'tag', fromJson: _parseTags)
          List<String> tags,
      @JsonKey(name: 'symptom_disorder', fromJson: _parseSymptomDisorder)
          List<String> symptomDisorder,
      String abstract,
      @JsonKey(name: 'approch_target')
          String approchTarget,
      String body,
      @JsonKey(name: 'url', fromJson: _parseEyeCatch)
          Uri eyecatch,
      @JsonKey(name: 'video', fromJson: _parseVideoURL)
          String videoURL,
      @JsonKey(fromJson: _parseGlossary)
          List<Term> glossary,
      String author,
      String twitter,
      String instagram,
      String webURL,
      String references});
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
    Object tags = freezed,
    Object symptomDisorder = freezed,
    Object abstract = freezed,
    Object approchTarget = freezed,
    Object body = freezed,
    Object eyecatch = freezed,
    Object videoURL = freezed,
    Object glossary = freezed,
    Object author = freezed,
    Object twitter = freezed,
    Object instagram = freezed,
    Object webURL = freezed,
    Object references = freezed,
  }) {
    return _then(_Article(
      id: id == freezed ? _value.id : id as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as DateTime,
      title: title == freezed ? _value.title : title as String,
      tags: tags == freezed ? _value.tags : tags as List<String>,
      symptomDisorder: symptomDisorder == freezed
          ? _value.symptomDisorder
          : symptomDisorder as List<String>,
      abstract: abstract == freezed ? _value.abstract : abstract as String,
      approchTarget: approchTarget == freezed
          ? _value.approchTarget
          : approchTarget as String,
      body: body == freezed ? _value.body : body as String,
      eyecatch: eyecatch == freezed ? _value.eyecatch : eyecatch as Uri,
      videoURL: videoURL == freezed ? _value.videoURL : videoURL as String,
      glossary: glossary == freezed ? _value.glossary : glossary as List<Term>,
      author: author == freezed ? _value.author : author as String,
      twitter: twitter == freezed ? _value.twitter : twitter as String,
      instagram: instagram == freezed ? _value.instagram : instagram as String,
      webURL: webURL == freezed ? _value.webURL : webURL as String,
      references:
          references == freezed ? _value.references : references as String,
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
      @JsonKey(name: 'tag', fromJson: _parseTags)
          this.tags,
      @JsonKey(name: 'symptom_disorder', fromJson: _parseSymptomDisorder)
          this.symptomDisorder,
      this.abstract,
      @JsonKey(name: 'approch_target')
          this.approchTarget,
      this.body,
      @JsonKey(name: 'url', fromJson: _parseEyeCatch)
          this.eyecatch,
      @JsonKey(name: 'video', fromJson: _parseVideoURL)
          this.videoURL,
      @JsonKey(fromJson: _parseGlossary)
          this.glossary,
      this.author,
      this.twitter,
      this.instagram,
      this.webURL,
      this.references});

  factory _$_Article.fromJson(Map<String, dynamic> json) =>
      _$_$_ArticleFromJson(json);

  @override
  final String id;
  @override
  final DateTime publishedAt;
  @override
  final String title;
  @override
  @JsonKey(name: 'tag', fromJson: _parseTags)
  final List<String> tags;
  @override
  @JsonKey(name: 'symptom_disorder', fromJson: _parseSymptomDisorder)
  final List<String> symptomDisorder;
  @override
  final String abstract;
  @override
  @JsonKey(name: 'approch_target')
  final String approchTarget;
  @override
  final String body;
  @override // article.g.dartのeyecatchの欄を eyecatch: _parseEyeCatch(json['eyecatch']['url'])に書き換える
  @JsonKey(name: 'url', fromJson: _parseEyeCatch)
  final Uri eyecatch;
  @override
  @JsonKey(name: 'video', fromJson: _parseVideoURL)
  final String videoURL;
  @override
  @JsonKey(fromJson: _parseGlossary)
  final List<Term> glossary;
  @override
  final String author;
  @override
  final String twitter;
  @override
  final String instagram;
  @override
  final String webURL;
  @override
  final String references;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Article(id: $id, publishedAt: $publishedAt, title: $title, tags: $tags, symptomDisorder: $symptomDisorder, abstract: $abstract, approchTarget: $approchTarget, body: $body, eyecatch: $eyecatch, videoURL: $videoURL, glossary: $glossary, author: $author, twitter: $twitter, instagram: $instagram, webURL: $webURL, references: $references)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Article'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('publishedAt', publishedAt))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('symptomDisorder', symptomDisorder))
      ..add(DiagnosticsProperty('abstract', abstract))
      ..add(DiagnosticsProperty('approchTarget', approchTarget))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('eyecatch', eyecatch))
      ..add(DiagnosticsProperty('videoURL', videoURL))
      ..add(DiagnosticsProperty('glossary', glossary))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('twitter', twitter))
      ..add(DiagnosticsProperty('instagram', instagram))
      ..add(DiagnosticsProperty('webURL', webURL))
      ..add(DiagnosticsProperty('references', references));
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
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.symptomDisorder, symptomDisorder) ||
                const DeepCollectionEquality()
                    .equals(other.symptomDisorder, symptomDisorder)) &&
            (identical(other.abstract, abstract) ||
                const DeepCollectionEquality()
                    .equals(other.abstract, abstract)) &&
            (identical(other.approchTarget, approchTarget) ||
                const DeepCollectionEquality()
                    .equals(other.approchTarget, approchTarget)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.eyecatch, eyecatch) ||
                const DeepCollectionEquality()
                    .equals(other.eyecatch, eyecatch)) &&
            (identical(other.videoURL, videoURL) ||
                const DeepCollectionEquality()
                    .equals(other.videoURL, videoURL)) &&
            (identical(other.glossary, glossary) ||
                const DeepCollectionEquality()
                    .equals(other.glossary, glossary)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.twitter, twitter) ||
                const DeepCollectionEquality()
                    .equals(other.twitter, twitter)) &&
            (identical(other.instagram, instagram) ||
                const DeepCollectionEquality()
                    .equals(other.instagram, instagram)) &&
            (identical(other.webURL, webURL) ||
                const DeepCollectionEquality().equals(other.webURL, webURL)) &&
            (identical(other.references, references) ||
                const DeepCollectionEquality()
                    .equals(other.references, references)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(publishedAt) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(symptomDisorder) ^
      const DeepCollectionEquality().hash(abstract) ^
      const DeepCollectionEquality().hash(approchTarget) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(eyecatch) ^
      const DeepCollectionEquality().hash(videoURL) ^
      const DeepCollectionEquality().hash(glossary) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(twitter) ^
      const DeepCollectionEquality().hash(instagram) ^
      const DeepCollectionEquality().hash(webURL) ^
      const DeepCollectionEquality().hash(references);

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
      @JsonKey(name: 'tag', fromJson: _parseTags)
          List<String> tags,
      @JsonKey(name: 'symptom_disorder', fromJson: _parseSymptomDisorder)
          List<String> symptomDisorder,
      String abstract,
      @JsonKey(name: 'approch_target')
          String approchTarget,
      String body,
      @JsonKey(name: 'url', fromJson: _parseEyeCatch)
          Uri eyecatch,
      @JsonKey(name: 'video', fromJson: _parseVideoURL)
          String videoURL,
      @JsonKey(fromJson: _parseGlossary)
          List<Term> glossary,
      String author,
      String twitter,
      String instagram,
      String webURL,
      String references}) = _$_Article;

  factory _Article.fromJson(Map<String, dynamic> json) = _$_Article.fromJson;

  @override
  String get id;
  @override
  DateTime get publishedAt;
  @override
  String get title;
  @override
  @JsonKey(name: 'tag', fromJson: _parseTags)
  List<String> get tags;
  @override
  @JsonKey(name: 'symptom_disorder', fromJson: _parseSymptomDisorder)
  List<String> get symptomDisorder;
  @override
  String get abstract;
  @override
  @JsonKey(name: 'approch_target')
  String get approchTarget;
  @override
  String get body;
  @override // article.g.dartのeyecatchの欄を eyecatch: _parseEyeCatch(json['eyecatch']['url'])に書き換える
  @JsonKey(name: 'url', fromJson: _parseEyeCatch)
  Uri get eyecatch;
  @override
  @JsonKey(name: 'video', fromJson: _parseVideoURL)
  String get videoURL;
  @override
  @JsonKey(fromJson: _parseGlossary)
  List<Term> get glossary;
  @override
  String get author;
  @override
  String get twitter;
  @override
  String get instagram;
  @override
  String get webURL;
  @override
  String get references;
  @override
  _$ArticleCopyWith<_Article> get copyWith;
}

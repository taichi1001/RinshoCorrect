// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'article_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ArticleStateTearOff {
  const _$ArticleStateTearOff();

// ignore: unused_element
  _ArticleState call(
      {List<Article> articles = const <Article>[],
      List<Article> sorted = const <Article>[],
      SortType sort = SortType.asc}) {
    return _ArticleState(
      articles: articles,
      sorted: sorted,
      sort: sort,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ArticleState = _$ArticleStateTearOff();

/// @nodoc
mixin _$ArticleState {
  List<Article> get articles;
  List<Article> get sorted;
  SortType get sort;

  $ArticleStateCopyWith<ArticleState> get copyWith;
}

/// @nodoc
abstract class $ArticleStateCopyWith<$Res> {
  factory $ArticleStateCopyWith(
          ArticleState value, $Res Function(ArticleState) then) =
      _$ArticleStateCopyWithImpl<$Res>;
  $Res call({List<Article> articles, List<Article> sorted, SortType sort});
}

/// @nodoc
class _$ArticleStateCopyWithImpl<$Res> implements $ArticleStateCopyWith<$Res> {
  _$ArticleStateCopyWithImpl(this._value, this._then);

  final ArticleState _value;
  // ignore: unused_field
  final $Res Function(ArticleState) _then;

  @override
  $Res call({
    Object articles = freezed,
    Object sorted = freezed,
    Object sort = freezed,
  }) {
    return _then(_value.copyWith(
      articles:
          articles == freezed ? _value.articles : articles as List<Article>,
      sorted: sorted == freezed ? _value.sorted : sorted as List<Article>,
      sort: sort == freezed ? _value.sort : sort as SortType,
    ));
  }
}

/// @nodoc
abstract class _$ArticleStateCopyWith<$Res>
    implements $ArticleStateCopyWith<$Res> {
  factory _$ArticleStateCopyWith(
          _ArticleState value, $Res Function(_ArticleState) then) =
      __$ArticleStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Article> articles, List<Article> sorted, SortType sort});
}

/// @nodoc
class __$ArticleStateCopyWithImpl<$Res> extends _$ArticleStateCopyWithImpl<$Res>
    implements _$ArticleStateCopyWith<$Res> {
  __$ArticleStateCopyWithImpl(
      _ArticleState _value, $Res Function(_ArticleState) _then)
      : super(_value, (v) => _then(v as _ArticleState));

  @override
  _ArticleState get _value => super._value as _ArticleState;

  @override
  $Res call({
    Object articles = freezed,
    Object sorted = freezed,
    Object sort = freezed,
  }) {
    return _then(_ArticleState(
      articles:
          articles == freezed ? _value.articles : articles as List<Article>,
      sorted: sorted == freezed ? _value.sorted : sorted as List<Article>,
      sort: sort == freezed ? _value.sort : sort as SortType,
    ));
  }
}

/// @nodoc
class _$_ArticleState extends _ArticleState {
  _$_ArticleState(
      {this.articles = const <Article>[],
      this.sorted = const <Article>[],
      this.sort = SortType.asc})
      : assert(articles != null),
        assert(sorted != null),
        assert(sort != null),
        super._();

  @JsonKey(defaultValue: const <Article>[])
  @override
  final List<Article> articles;
  @JsonKey(defaultValue: const <Article>[])
  @override
  final List<Article> sorted;
  @JsonKey(defaultValue: SortType.asc)
  @override
  final SortType sort;

  bool _didsortedArticles = false;
  List<Article> _sortedArticles;

  @override
  List<Article> get sortedArticles {
    if (_didsortedArticles == false) {
      _didsortedArticles = true;
      _sortedArticles = articles;
    }
    return _sortedArticles;
  }

  @override
  String toString() {
    return 'ArticleState(articles: $articles, sorted: $sorted, sort: $sort, sortedArticles: $sortedArticles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ArticleState &&
            (identical(other.articles, articles) ||
                const DeepCollectionEquality()
                    .equals(other.articles, articles)) &&
            (identical(other.sorted, sorted) ||
                const DeepCollectionEquality().equals(other.sorted, sorted)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(articles) ^
      const DeepCollectionEquality().hash(sorted) ^
      const DeepCollectionEquality().hash(sort);

  @override
  _$ArticleStateCopyWith<_ArticleState> get copyWith =>
      __$ArticleStateCopyWithImpl<_ArticleState>(this, _$identity);
}

abstract class _ArticleState extends ArticleState {
  _ArticleState._() : super._();
  factory _ArticleState(
      {List<Article> articles,
      List<Article> sorted,
      SortType sort}) = _$_ArticleState;

  @override
  List<Article> get articles;
  @override
  List<Article> get sorted;
  @override
  SortType get sort;
  @override
  _$ArticleStateCopyWith<_ArticleState> get copyWith;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'term.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Term _$TermFromJson(Map<String, dynamic> json) {
  return _Term.fromJson(json);
}

/// @nodoc
class _$TermTearOff {
  const _$TermTearOff();

// ignore: unused_element
  _Term call(
      {String id,
      DateTime publishedAt,
      String term,
      @JsonKey(name: 'body') String detail}) {
    return _Term(
      id: id,
      publishedAt: publishedAt,
      term: term,
      detail: detail,
    );
  }

// ignore: unused_element
  Term fromJson(Map<String, Object> json) {
    return Term.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Term = _$TermTearOff();

/// @nodoc
mixin _$Term {
  String get id;
  DateTime get publishedAt;
  String get term;
  @JsonKey(name: 'body')
  String get detail;

  Map<String, dynamic> toJson();
  $TermCopyWith<Term> get copyWith;
}

/// @nodoc
abstract class $TermCopyWith<$Res> {
  factory $TermCopyWith(Term value, $Res Function(Term) then) =
      _$TermCopyWithImpl<$Res>;
  $Res call(
      {String id,
      DateTime publishedAt,
      String term,
      @JsonKey(name: 'body') String detail});
}

/// @nodoc
class _$TermCopyWithImpl<$Res> implements $TermCopyWith<$Res> {
  _$TermCopyWithImpl(this._value, this._then);

  final Term _value;
  // ignore: unused_field
  final $Res Function(Term) _then;

  @override
  $Res call({
    Object id = freezed,
    Object publishedAt = freezed,
    Object term = freezed,
    Object detail = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as DateTime,
      term: term == freezed ? _value.term : term as String,
      detail: detail == freezed ? _value.detail : detail as String,
    ));
  }
}

/// @nodoc
abstract class _$TermCopyWith<$Res> implements $TermCopyWith<$Res> {
  factory _$TermCopyWith(_Term value, $Res Function(_Term) then) =
      __$TermCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      DateTime publishedAt,
      String term,
      @JsonKey(name: 'body') String detail});
}

/// @nodoc
class __$TermCopyWithImpl<$Res> extends _$TermCopyWithImpl<$Res>
    implements _$TermCopyWith<$Res> {
  __$TermCopyWithImpl(_Term _value, $Res Function(_Term) _then)
      : super(_value, (v) => _then(v as _Term));

  @override
  _Term get _value => super._value as _Term;

  @override
  $Res call({
    Object id = freezed,
    Object publishedAt = freezed,
    Object term = freezed,
    Object detail = freezed,
  }) {
    return _then(_Term(
      id: id == freezed ? _value.id : id as String,
      publishedAt:
          publishedAt == freezed ? _value.publishedAt : publishedAt as DateTime,
      term: term == freezed ? _value.term : term as String,
      detail: detail == freezed ? _value.detail : detail as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Term with DiagnosticableTreeMixin implements _Term {
  const _$_Term(
      {this.id,
      this.publishedAt,
      this.term,
      @JsonKey(name: 'body') this.detail});

  factory _$_Term.fromJson(Map<String, dynamic> json) =>
      _$_$_TermFromJson(json);

  @override
  final String id;
  @override
  final DateTime publishedAt;
  @override
  final String term;
  @override
  @JsonKey(name: 'body')
  final String detail;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Term(id: $id, publishedAt: $publishedAt, term: $term, detail: $detail)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Term'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('publishedAt', publishedAt))
      ..add(DiagnosticsProperty('term', term))
      ..add(DiagnosticsProperty('detail', detail));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Term &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.publishedAt, publishedAt) ||
                const DeepCollectionEquality()
                    .equals(other.publishedAt, publishedAt)) &&
            (identical(other.term, term) ||
                const DeepCollectionEquality().equals(other.term, term)) &&
            (identical(other.detail, detail) ||
                const DeepCollectionEquality().equals(other.detail, detail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(publishedAt) ^
      const DeepCollectionEquality().hash(term) ^
      const DeepCollectionEquality().hash(detail);

  @override
  _$TermCopyWith<_Term> get copyWith =>
      __$TermCopyWithImpl<_Term>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TermToJson(this);
  }
}

abstract class _Term implements Term {
  const factory _Term(
      {String id,
      DateTime publishedAt,
      String term,
      @JsonKey(name: 'body') String detail}) = _$_Term;

  factory _Term.fromJson(Map<String, dynamic> json) = _$_Term.fromJson;

  @override
  String get id;
  @override
  DateTime get publishedAt;
  @override
  String get term;
  @override
  @JsonKey(name: 'body')
  String get detail;
  @override
  _$TermCopyWith<_Term> get copyWith;
}

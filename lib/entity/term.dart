import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'term.freezed.dart';
part 'term.g.dart';

@freezed
abstract class Term with _$Term {
  const factory Term({
    String id,
    DateTime publishedAt,
    String term,
    @JsonKey(name: 'body') String detail,
  }) = _Term;
  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);
}

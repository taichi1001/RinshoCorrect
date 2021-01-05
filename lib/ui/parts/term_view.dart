import 'package:flutter/material.dart';
import 'package:rinsho_collect/entity/term.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final viewTerm = ScopedProvider<Term>(null);

class TermView extends HookWidget {
  const TermView({
    key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _viewTerm = useProvider(viewTerm);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          _viewTerm.term,
          style: const TextStyle(
            color: Colors.indigoAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          height: 16,
          thickness: 1,
        ),
        Html(data: _viewTerm.detail),
      ],
    );
  }
}

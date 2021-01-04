import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/term.dart';

class TerminologyScreen extends HookWidget {
  const TerminologyScreen({
    this.term,
    Key key,
  }) : super(key: key);

  final Term term;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用語'),
      ),
      body: Text(term.term),
    );
  }
}

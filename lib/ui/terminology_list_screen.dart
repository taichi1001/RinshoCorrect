import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/term.dart';
import 'package:rinsho_collect/model/terminology_list_screen_controller.dart';
import 'package:rinsho_collect/ui/terminology_screen.dart';

class TerminologyListScreen extends HookWidget {
  const TerminologyListScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(terminologyScreenController).fetch();
      return;
    }, []);

    final _terminologies = useProvider(sortedTerminologies).state;

    if (_terminologies == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('用語'),
      ),
      body: ListView.builder(
        itemCount: _terminologies.length,
        itemBuilder: (context, index) => ProviderScope(
          overrides: [
            currentTerminology.overrideWithValue(_terminologies[index]),
          ],
          child: const _TerminologyCard(),
        ),
      ),
    );
  }
}

final currentTerminology = ScopedProvider<Term>(null);

class _TerminologyCard extends HookWidget {
  const _TerminologyCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _term = useProvider(currentTerminology);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return TerminologyScreen(
                term: _term,
              );
            },
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(_term.term),
        ),
      ),
    );
  }
}

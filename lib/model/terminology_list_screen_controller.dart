import 'package:rinsho_collect/entity/term.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/repository/micro_cms_repository.dart';

final _terminologies = StateProvider<List<Term>>((ref) => null);

final sortedTerminologies = StateProvider.autoDispose<List<Term>>((ref) {
  final terminologies = ref.watch(_terminologies).state;
  return terminologies;
});

final terminologyScreenController =
    Provider.autoDispose((ref) => TerminologyScreenController(read: ref.read));

class TerminologyScreenController {
  TerminologyScreenController({
    this.read,
  });

  final Reader read;

  Future fetch() async {
    read(_terminologies).state = await read(microCMSRepository).getGlossary();
  }
}

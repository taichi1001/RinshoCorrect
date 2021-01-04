import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:rinsho_collect/client/micro_cms.dart';
import 'package:rinsho_collect/entity/term.dart';

final glossaryRepository =
    Provider.autoDispose<GlossaryRepository>((ref) => GlossaryRepositoryImpl(ref.read));

abstract class GlossaryRepository {
  Future<List<Term>> getGlossary();
}

class GlossaryRepositoryImpl implements GlossaryRepository {
  final Reader read;
  GlossaryRepositoryImpl(this.read);

  @override
  Future<List<Term>> getGlossary() async {
    final MicroCMSClient prefs = read(microCMSClient);
    final Response result = await prefs.getGlossary() ?? [];
    final List contents = jsonDecode(result.body)['contents'];
    return contents.map((json) => Term.fromJson(json)).toList();
  }
}

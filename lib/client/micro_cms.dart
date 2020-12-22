import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final microCMSClient = Provider.autoDispose((ref) => MicroCMSClient());

class MicroCMSClient {
  Future getJsonList() => http.get(
        'https://rinshotest.microcms.io/api/v1/article',
        headers: {'X-API-KEY': '3b36eb63-bfa1-493e-91be-64543308ba3c'},
      );
}

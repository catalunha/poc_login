import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'remote/dio/dio_client.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
DioClient dioClient(DioClientRef ref) {
  return DioClient();
}

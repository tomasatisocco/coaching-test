// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:storage_repository/storage_repository.dart';

void main() {
  group('StorageRepository', () {
    test('can be instantiated', () {
      expect(StorageRepository.development(), isNotNull);
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DataPersistenceRepository', () {
    test('can be instantiated', () {
      expect(DataPersistenceRepository(), isNotNull);
    });
  });
}

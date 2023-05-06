// ignore_for_file: prefer_const_constructors

import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirestoreRepository', () {
    test('can be instantiated', () {
      expect(FirestoreRepository.development(), isNotNull);
    });
  });
}

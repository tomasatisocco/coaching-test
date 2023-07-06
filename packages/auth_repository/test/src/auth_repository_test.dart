// ignore_for_file: prefer_const_constructors

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthRepository', () {
    test('can be instantiated', () {
      expect(AuthRepository(), isNotNull);
    });
  });
}

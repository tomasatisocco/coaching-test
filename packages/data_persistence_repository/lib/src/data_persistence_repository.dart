import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// {@template data_persistence_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class DataPersistenceRepository {
  /// {@macro data_persistence_repository}
  DataPersistenceRepository();

  late SharedPreferences _instance;

  /// Initialize the data persistence repository.
  Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  /// Set the coaching test in the data persistence repository.
  Future<void> setCoachingTest(Map<String, dynamic> coachingTest) async {
    await _instance.setString(BoxKeys.coachingTest, json.encode(coachingTest));
  }

  /// Set the email in the data persistence repository.
  Future<void> setUser(String userMap) async {
    await _instance.setString(BoxKeys.user, userMap);
  }

  /// Get the coaching test from the data persistence repository.
  Map<String, dynamic>? getCoachingTest() {
    final json = _instance.getString(BoxKeys.coachingTest);
    if (json == null) return null;
    return jsonDecode(json) as Map<String, dynamic>;
  }

  /// Get the email from the data persistence repository.
  String? getUser() {
    return _instance.getString(BoxKeys.user);
  }

  /// Delete the coaching test from the data persistence repository.
  Future<void> deleteCoachingTest() async {
    await _instance.remove(BoxKeys.coachingTest);
  }

  /// Delete the email from the data persistence repository.
  Future<void> deleteUser() async {
    await _instance.remove(BoxKeys.user);
  }
}

/// Box keys for the data persistence repository.
class BoxKeys {
  /// Key for the coaching test box.
  static const String coachingTest = 'coachingTest';

  /// Key for the email box.
  static const String user = 'user';
}

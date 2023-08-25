import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

/// {@template functions_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FunctionsRepository {
  /// {@macro functions_repository}
  const FunctionsRepository();

  /// Call a function.
  Future<void> call({
    required Map<String, dynamic> parameters,
  }) async {
    await FirebaseFunctions.instanceFor(
      region: 'southamerica-east1',
      app: Firebase.app(),
    )
        .httpsCallable(
          'mercadoPagoOAuth',
          options: HttpsCallableOptions(timeout: const Duration(seconds: 30)),
        )
        .call<void>(parameters);
  }
}

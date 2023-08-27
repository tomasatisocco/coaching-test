import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

/// {@template functions_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FunctionsRepository {
  /// {@macro functions_repository}
  const FunctionsRepository();

  /// Call to authorize in mercado pago.
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

  /// Create a preference.
  Future<Map<String, dynamic>> createPreference(String itemId) async {
    final response = await FirebaseFunctions.instanceFor(
      region: 'southamerica-east1',
      app: Firebase.app(),
    )
        .httpsCallable(
      'createCheckout',
      options: HttpsCallableOptions(timeout: const Duration(seconds: 30)),
    )
        .call<Map<String, dynamic>>(<String, dynamic>{
      'itemId': itemId,
    });
    return response.data;
  }

  /// Resend a test result
  Future<void> resendTest(String testId) async {
    try {
      await FirebaseFunctions.instanceFor(
        region: 'southamerica-east1',
        app: Firebase.app(),
      )
          .httpsCallable(
            'reSendEmail',
            options: HttpsCallableOptions(
              timeout: const Duration(seconds: 30),
            ),
          )
          .call<void>();
    } catch (e) {
      print(e);
    }
  }
}

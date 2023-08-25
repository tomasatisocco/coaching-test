import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigurations {
  RemoteConfigurations();

  late FirebaseRemoteConfig remoteConfig;

  Future<void> init() async {
    try {
      await Firebase.initializeApp();
      remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.ensureInitialized();
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 1),
        ),
      );
      await remoteConfig.setDefaults({
        RemoteConfigsKeys.dollarPrice: 450,
      });
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      log(e.toString());
    }
  }

  double get dollarPrice {
    return remoteConfig.getDouble(
      RemoteConfigsKeys.dollarPrice,
    );
  }

  List<String> get whiteListVendors {
    final value = remoteConfig
        .getValue(
          RemoteConfigsKeys.whiteListVendors,
        )
        .asString();
    return (jsonDecode(value) as List<dynamic>).cast();
  }

  String get clientId {
    return remoteConfig.getString(
      RemoteConfigsKeys.clientId,
    );
  }
}

class RemoteConfigsKeys {
  static const String dollarPrice = 'dollar_price';
  static const String whiteListVendors = 'whitelist_vendors';
  static const String clientId = 'client_id';
}

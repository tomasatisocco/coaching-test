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
}

class RemoteConfigsKeys {
  static const String dollarPrice = 'dollar_price';
}

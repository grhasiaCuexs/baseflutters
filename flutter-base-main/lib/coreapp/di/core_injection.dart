import 'package:flutter/material.dart';
import 'package:myeshop/coreapp/di/local_datasource_injection.dart';
import 'package:myeshop/coreapp/di/network_datasource_injection.dart';
import 'package:myeshop/coreapp/di/features_injection.dart';

class CoreInjection {
  static Future<void> initDependencies(String baseUrl) async {
    LocalDataSourceInjection.registerDependencies();
    NetworkDataSourceInjection.registerDependency(baseUrl);
    await FeaturesInjection.registerDependencies();
  }

  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState>? globaKeyNavigator() {
    return rootNavigatorKey;
  }
}

class CoreViewInjection {
  static void init() {}
}

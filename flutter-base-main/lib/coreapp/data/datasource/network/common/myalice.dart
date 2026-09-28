import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:myeshop/coreapp/di/core_injection.dart';

class MyAlice {
  static Alice create(AliceDioAdapter adapter) {
    final alice = Alice(
      configuration: AliceConfiguration(
        navigatorKey: CoreInjection.rootNavigatorKey,
        showNotification: kDebugMode ? true : false,
        showInspectorOnShake: kDebugMode ? true : false,
      ),
    );
    alice.addAdapter(adapter);
    return alice;
  }

  static AliceDioAdapter createAdapter() => AliceDioAdapter();
}

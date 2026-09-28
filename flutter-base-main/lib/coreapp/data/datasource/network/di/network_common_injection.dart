import 'package:alice/alice.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myeshop/coreapp/data/datasource/local/session_data_source.dart';
import 'package:myeshop/coreapp/data/datasource/network/common/common_network_interceptor_listener.dart';
import 'package:myeshop/coreapp/data/datasource/network/common/myalice.dart';
import 'package:myeshop/coreapp/data/datasource/network/common/mydio.dart';
import 'package:myeshop/coreapp/data/datasource/network/common/network_interceptor.dart';

class NetworkCommonInjection {
  static GetIt get _getIt => GetIt.instance;

  static const String dioMyApiInstance = "myapi-instance";

  static void registerCommonInterceptor(
      SessionDataSource sessionDataSource) {
    if (!_getIt.isRegistered<NetworkInterceptorListener>()) {
      _getIt.registerSingleton<NetworkInterceptorListener>(
          CommonNetworkInterceptorListener(sessionDataSource));
    }
  }

  static void registerDependencies() {

    if (!_getIt.isRegistered<AliceDioAdapter>()) {
      _getIt.registerSingleton<AliceDioAdapter>(MyAlice.createAdapter());
    }

    if (!_getIt.isRegistered<Alice>()) {
      _getIt.registerSingleton<Alice>(MyAlice.create(_getIt.get<AliceDioAdapter>()));
    }

    if (!_getIt.isRegistered<Dio>(instanceName: dioMyApiInstance)) {
      _getIt.registerSingleton<Dio>(
        MyDio.createDioMyApi(
          aliceAdapter: _getIt<AliceDioAdapter>(),
          networkInterceptorListener: _getIt<NetworkInterceptorListener>(),
        ),
        instanceName: dioMyApiInstance,
      );
    }
  }

  static void unRegisterCommonInterceptor() {
    if (_getIt.isRegistered<NetworkInterceptorListener>()) {
      _getIt.unregister<NetworkInterceptorListener>();
    }
  }

  static void unRegisterDependencies() {
    if (_getIt.isRegistered<Dio>(instanceName: dioMyApiInstance)) {
      _getIt.unregister<Dio>(instanceName: dioMyApiInstance);
    }

    if (_getIt.isRegistered<Alice>()) {
      _getIt.unregister<Alice>();
    }
  }

  static Alice? getAlice() {
    if (_getIt.isRegistered<Alice>()) {
      return get<Alice>();
    }
    return null;
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}

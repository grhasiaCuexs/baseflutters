import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myeshop/coreapp/data/api/api_service.dart';
import 'package:myeshop/coreapp/data/datasource/network/di/network_common_injection.dart';
import 'package:myeshop/coreapp/data/datasource/network/feature_network_datasource.dart';
import 'package:myeshop/coreapp/data/datasource/network/feature_network_datasource_impl.dart';
import 'package:myeshop/coreapp/di/local_datasource_injection.dart';

class NetworkDataSourceInjection {
  static GetIt get _getIt => GetIt.instance;

  static void registerDependency(
    String apiUrl,
  ) {
    NetworkCommonInjection.registerCommonInterceptor(
        LocalDataSourceInjection.getLocalDataSource());
    NetworkCommonInjection.registerDependencies();
    _getIt.registerSingleton<ApiService>(ApiService(
        _getIt<Dio>(instanceName: NetworkCommonInjection.dioMyApiInstance),
        baseUrl: apiUrl));
    _getIt.registerSingleton<FeatureNetworkDataSource>(
      FeatureNetworkDataSourceImpl(
        api: _getIt<ApiService>(),
      ),
    );
  }

  static void unregisterDependency() {
    _getIt.unregister<ApiService>();
    _getIt.unregister<FeatureNetworkDataSource>();
    NetworkCommonInjection.unRegisterDependencies();
  }

  // static FeatureNetworkDataSource getFeatureNetworkDataSource() {
  //   return _getIt<FeatureNetworkDataSource>();
  // }
}

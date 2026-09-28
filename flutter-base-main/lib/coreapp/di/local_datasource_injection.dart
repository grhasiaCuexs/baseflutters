import 'package:get_it/get_it.dart';
import 'package:myeshop/coreapp/data/datasource/local/feature_local_datasource.dart';
import 'package:myeshop/coreapp/data/datasource/local/feature_local_datasource_impl.dart';

class LocalDataSourceInjection {
  static GetIt get _getIt => GetIt.instance;

  static void registerDependencies() {
    if (!_getIt.isRegistered<FeatureLocalDataSource>()) {
      _getIt.registerSingleton<FeatureLocalDataSource>(FeatureLocalDataSourceImpl());
    }
  }

  static void unRegisterDependencies() {
    if (_getIt.isRegistered<FeatureLocalDataSource>()) {
      _getIt.unregister<FeatureLocalDataSource>();
    }
  }

  static FeatureLocalDataSource getLocalDataSource() {
    if (_getIt.isRegistered<FeatureLocalDataSource>()) {
      return _getIt.get<FeatureLocalDataSource>();
    }
    throw Exception("FeatureLocalDataSource has not been injected");
  }
}

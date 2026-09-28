import 'package:myeshop/coreapp/data/datasource/local/session_data_source.dart';
import 'package:myeshop/coreapp/data/datasource/network/common/network_interceptor.dart';
import 'package:myeshop/coreapp/helpers/constants.dart';

class CommonNetworkInterceptorListener implements NetworkInterceptorListener {
  CommonNetworkInterceptorListener(SessionDataSource localDataSource)
      : _localDataSource = localDataSource;

  final SessionDataSource _localDataSource;

  @override
  Future<String> getLocale() async {
    return Constants.defaultLocale;
  }

  @override
  Future<String?> getToken() async {
     final sessionToken = await _localDataSource.getSessionToken();
    return sessionToken?.token;
  }

  @override
  Future<bool> onRemoveSession() {
    return _localDataSource.removeSession();
  }

  @override
  List<String> getUrlWithoutToken() => ["login"];

  @override
  Future<Map<String, dynamic>?> getCustomHeader() async => null;
}

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/network_error_code.dart';
import 'package:package_info_plus/package_info_plus.dart';


abstract class NetworkInterceptorListener {
  Future<String?> getToken();
  Future<String> getLocale();
  Future<bool> onRemoveSession();
  List<String> getUrlWithoutToken();
  Future<Map<String, dynamic>?> getCustomHeader();
}

class NetworkInterceptor extends Interceptor {
  final NetworkInterceptorListener listener;

  NetworkInterceptor({required this.listener});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Content-Type"] = "application/json";
    options.headers["Accept"] = "application/json";

    if (kIsWeb) {
      options.headers["Access-Control-Allow-Origin"] = "*";
      options.headers["Access-Control-Allow-Methods"] = "POST,DELETE";
      options.headers["Access-Control-Allow-Headers"] = "X-Requested-With";
    }

    options.headers["is-mobile"] = "true";

    List<String> urlWithoutToken = listener.getUrlWithoutToken();
    if (!urlWithoutToken.contains(options.path)) {
      String? token = await listener.getToken();
      options.headers["Authorization"] = "Bearer $token";
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    options.headers["App-Name"] = appName;
    options.headers["Package-Name"] = packageName;
    options.headers["App-Version"] = version;
    options.headers["Build-Number"] = buildNumber;

    final customHeader = await listener.getCustomHeader();
    if (customHeader != null) {
      options.headers.addAll(customHeader);
    }

    try {
      final String deviceOS;
      final String deviceBrand;
      final String deviceModel;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceOS = "Android";
        deviceBrand = androidInfo.brand;
        deviceModel = androidInfo.model;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iOSInfo = await deviceInfo.iosInfo;
        deviceOS = "iOS";
        deviceBrand = "Apple";
        deviceModel = iOSInfo.model;
      } else {
        throw Exception("Undifined target platform");
      }

      options.headers["Device-Os"] = deviceOS;
      options.headers["device-brand"] = deviceBrand;
      options.headers["device-model"] = deviceModel;
    } catch (e) {
      debugPrint("Error platform info: $e");
    }

    final locale = await listener.getLocale();
    options.headers["X-Localization"] = locale;

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == NetworkErrorCode.unauthorized) {
      listener.onRemoveSession();
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == NetworkErrorCode.unauthorized) {
      listener.onRemoveSession();
    }
    return handler.next(response);
  }
}

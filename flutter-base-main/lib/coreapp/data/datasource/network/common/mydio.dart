import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:dio/dio.dart';
import 'package:myeshop/coreapp/data/datasource/network/common/network_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MyDio {
  static const int timeOut = 60000;

  static BaseOptions dioBaseOptions() {
    return BaseOptions(
      receiveTimeout: const Duration(milliseconds: timeOut),
      connectTimeout: const Duration(milliseconds: timeOut),
      sendTimeout: const Duration(milliseconds: timeOut),
    );
  }

  static Dio createDioMyApi({
    required NetworkInterceptorListener networkInterceptorListener,
    AliceDioAdapter? aliceAdapter,
  }) {
    return create(
      listener: networkInterceptorListener,
      aliceAdapter: aliceAdapter,
    );
  }

  static Dio create({
    required NetworkInterceptorListener listener,
    AliceDioAdapter? aliceAdapter,
  }) {
    final dio = Dio(dioBaseOptions());
    final interceptors = [
      NetworkInterceptor(listener: listener),
      PrettyDioLogger(requestBody: true, requestHeader: true)
    ];

    if (aliceAdapter != null) {
      interceptors.add(aliceAdapter);
    }

    dio.interceptors.addAll(interceptors);

    return dio;
  }
}

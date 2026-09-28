import 'package:get_it/get_it.dart';
import 'package:myeshop/modules/auth/main/di/my_auth_injection.dart';
import 'package:myeshop/modules/product/di/product_injection.dart';

class FeaturesInjection {
  static GetIt get _getIt => GetIt.instance;

  static Future<void> registerDependencies() async {
    await MyAuthInjection.registerDependencies();
    ProductInjection.registerDependencies(_getIt);
  }

  static void unRegisterDependencies() {
    MyAuthInjection.unRegisterDependencies();
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}

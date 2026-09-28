import 'package:get_it/get_it.dart';
import 'package:myeshop/modules/product/data/repositories/product_repository_impl.dart';
import 'package:myeshop/modules/product/domain/repositories/product_repository.dart';
import 'package:myeshop/modules/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:myeshop/modules/product/domain/usecases/get_products_usecase.dart';
import 'package:myeshop/modules/product/presentation/bloc/detail/product_detail_bloc.dart';
import 'package:myeshop/modules/product/presentation/bloc/list/product_list_bloc.dart';

class ProductInjection {
  static void registerDependencies(GetIt getIt) {
    // Data Layer
    getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(getIt()));

    // Domain Layer
    getIt.registerLazySingleton(() => GetProductsUseCase(getIt()));
    getIt.registerLazySingleton(() => GetProductDetailUseCase(getIt()));

    // Presentation Layer
    getIt.registerFactory(() => ProductListBloc(getIt()));
    getIt.registerFactory(() => ProductDetailBloc(getIt()));
  }
}

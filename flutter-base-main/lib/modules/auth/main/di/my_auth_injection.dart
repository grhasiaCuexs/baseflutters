import 'package:get_it/get_it.dart';
import 'package:myeshop/modules/auth/main/domain/repositories/auth_repository.dart';
import 'package:myeshop/modules/auth/main/data/repositories/auth_repository_impl.dart';
import 'package:myeshop/modules/auth/main/domain/repositories/session_repository.dart';
import 'package:myeshop/modules/auth/main/data/repositories/session_repository_impl.dart';
import 'package:myeshop/modules/auth/main/domain/usecases/signin_usecase.dart';
import 'package:myeshop/modules/auth/main/domain/usecases/signup_usecase.dart';
import 'package:myeshop/modules/auth/main/domain/usecases/get_session_usecase.dart';
import 'package:myeshop/modules/auth/main/domain/usecases/revoke_session_usecase.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/signin/signin_bloc.dart';

import 'package:myeshop/modules/root/domain/result.dart';

class MyAuthInjection {
  static GetIt get _getIt => GetIt.instance;

  static Future<void> registerDependencies() async {
    // Repositories
    _getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl());
    _getIt.registerLazySingleton<SessionRepository>(
        () => SessionRepositoryImpl(_getIt()));

    // UseCases
    _getIt.registerLazySingleton(() => SignInUseCase(_getIt(), _getIt()));
    _getIt.registerLazySingleton(() => SignUpUsecase(_getIt(), _getIt()));
    _getIt.registerLazySingleton(() => GetSessionDataUsecase(repository: _getIt()));
    _getIt.registerLazySingleton(() => RevokeSessionUseCase(repository: _getIt()));

    final loggedStatus = await _getIt<GetSessionDataUsecase>().call();

    // Blocs
    _getIt.registerFactory(() => SignInBloc(signInUseCase: _getIt()));
    _getIt.registerFactory(() => SessionBloc(
          getSessionUsecase: _getIt(),
          revokeSessionUseCase: _getIt(),
          statusLoggedInit: loggedStatus is ResultSuccess,
        ));
  }

  static void unRegisterDependencies() {
    _getIt.unregister<SignInBloc>();
    _getIt.unregister<SessionBloc>();
    _getIt.unregister<RevokeSessionUseCase>();
    _getIt.unregister<GetSessionDataUsecase>();
    _getIt.unregister<SignUpUsecase>();
    _getIt.unregister<SignInUseCase>();
    _getIt.unregister<SessionRepository>();
    _getIt.unregister<AuthRepository>();
  }
}

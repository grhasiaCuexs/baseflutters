import 'package:myeshop/coreapp/data/datasource/local/feature_local_datasource.dart';
import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';
import 'package:myeshop/modules/auth/main/domain/repositories/session_repository.dart';
import 'package:myeshop/modules/root/data/helpers/exceptions/empty_exception.dart';
import 'package:myeshop/modules/root/domain/result.dart';

class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl(FeatureLocalDataSource localDataSource)
      : _localDataSource = localDataSource;

  final FeatureLocalDataSource _localDataSource;

  @override
  Future<void> saveSession(SessionSignIn session) {
    return _localDataSource.saveSession(session);
  }

  @override
  Future<Result<DataSignIn?>> getSessionData() async {
    final result = await _localDataSource.getSessionData();
    if (result != null) {
      return ResultSuccess(data: result);
    } else {
      return ResultError(error: EmptyException("Session not found"));
    }
  }

  @override
  Future<Result<bool>> revokeSession() async {
    final result = await _localDataSource.removeSession();
    return ResultSuccess(data: result);
  }
}

import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';
import 'package:myeshop/modules/root/domain/result.dart';

abstract class SessionRepository {
  Future<Result<DataSignIn?>> getSessionData();
  Future<void> saveSession(SessionSignIn session);
  Future<Result<bool>> revokeSession();
}
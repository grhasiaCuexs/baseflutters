import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_token.dart';

abstract class SessionDataSource {
  Future<void> saveSession(SessionSignIn session);

  Future<DataSignIn?> getSessionData();

  Future<SessionToken?> getSessionToken();

  Future<bool> removeSession();
}
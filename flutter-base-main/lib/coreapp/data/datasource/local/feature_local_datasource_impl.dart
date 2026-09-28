import 'package:myeshop/coreapp/data/datasource/local/feature_local_datasource.dart';
import 'package:myeshop/coreapp/data/datasource/local/preferences/session_pref.dart';
import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_token.dart';

class FeatureLocalDataSourceImpl implements FeatureLocalDataSource {
  @override
  Future<void> saveSession(SessionSignIn session) {
    return SessionPref.saveSession(session);
  }

  @override
  Future<DataSignIn?> getSessionData() {
    return SessionPref.getSessionData();
  }

  @override
  Future<bool> removeSession() {
    return SessionPref.removeSession();
  }

  @override
  Future<SessionToken?> getSessionToken() {
    return SessionPref.getSessionToken();
  }
}

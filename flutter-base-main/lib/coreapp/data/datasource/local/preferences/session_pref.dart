import 'dart:convert';

import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_signin.dart';
import 'package:myeshop/modules/auth/main/data/models/response/session_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionPref {
  static const String _dataKey = "data";
  static const String _tokenKey = "token";

  static Future<SharedPreferences> get _preferences =>
      SharedPreferences.getInstance();

  static Future<void> saveSession(SessionSignIn session) async {
    SharedPreferences preferences = await _preferences;
    final SessionToken sessionToken = session;
    preferences.setString(_tokenKey, jsonEncode(sessionToken.toJson()));
    preferences.setString(_dataKey, jsonEncode(session.dataSignin.toJson()));
  }

  static Future<DataSignIn?> getSessionData() async {
    SharedPreferences preferences = await _preferences;
    String? sessionStr = preferences.getString(_dataKey);
    if (sessionStr == null) {
      return null;
    }
    return DataSignIn.fromJson(jsonDecode(sessionStr));
  }

  static Future<SessionToken?> getSessionToken() async {
    SharedPreferences preferences = await _preferences;
    String? sessionStr = preferences.getString(_tokenKey);
    if (sessionStr == null) {
      return null;
    }
    return SessionToken.fromJson(jsonDecode(sessionStr));
  }

  static Future<bool> removeSession() async {
    SharedPreferences preferences = await _preferences;
    await preferences.remove(_tokenKey);
    return await preferences.remove(_dataKey);
  }
}

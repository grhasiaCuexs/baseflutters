import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentType { dev, prod }

class MainEnvironment {
  static const _typeProductionName = "production";
  static const _envDevLocation = "assets/env/.env.dev";
  static const _envProdLocation = "assets/env/.env.prod";
  static const _envTempLocation = "assets/env/.env.temp";
  static const _keyApiUrl = "API_URL";
  static const _keyEnvType = "ENV_TYPE";
  static const _appName = "Base App";

  static String getEnvFile(EnvironmentType envType) {
    if (envType == EnvironmentType.prod) {
      return _envProdLocation;
    }
    return _envDevLocation;
  }

  static Future<void> loadEnv(EnvironmentType envType) async {
    final envFile = getEnvFile(envType);

    try {
      await dotenv.load(fileName: envFile);
    } catch (error) {
      await dotenv.load(fileName: _envTempLocation);
    }
  }

  static String _getEnvValue(String keyName) {
    final result = dotenv.env[keyName];
    if (result == null) {
      throw Exception("No value with key [$keyName]");
    }
    return result;
  }

  static String get apiUrl {
    return _getEnvValue(_keyApiUrl);
  }

  static String get typeName {
    return _getEnvValue(_keyEnvType);
  }

  static EnvironmentType get typeEnum {
    if (typeName == _typeProductionName) {
      return EnvironmentType.prod;
    }
    return EnvironmentType.dev;
  }

  static String get appName {
    if (typeName != _typeProductionName) {
      return "[Dev] $_appName";
    }
    return _appName;
  }
}

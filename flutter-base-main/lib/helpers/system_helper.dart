import 'package:package_info_plus/package_info_plus.dart';

class SystemHelper {
  static Future<void> getPackageInfo(
      Function(PackageInfo info) onGetPackageInfo) async {
    final info = await PackageInfo.fromPlatform();
    onGetPackageInfo.call(info);
  }
}

import 'package:myeshop/config/main_environment.dart';
import 'package:myeshop/main.dart';

//Command: flutter run -t lib/main_prod.dart --flavor prod
Future<void> main() async {
  mainCommon(EnvironmentType.prod);
}

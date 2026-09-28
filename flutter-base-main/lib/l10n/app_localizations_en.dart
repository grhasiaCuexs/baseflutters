// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'App Name';

  @override
  String general_required(String field_param, String isRequiredParam) {
    return '$field_param $isRequiredParam';
  }

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get is_required => 'is required';

  @override
  String get password => 'Password';

  @override
  String get email => 'Email';

  @override
  String emailRequired(String emailParam, String isRequiredParam) {
    return '$emailParam $isRequiredParam';
  }

  @override
  String get emailIsInvalid => 'Email is invalid';

  @override
  String passwordRequired(String passwordParam, String isRequiredParam) {
    return '$passwordParam $isRequiredParam';
  }

  @override
  String get data_not_found => 'Data not found!';

  @override
  String get sign_in => 'Sign In';

  @override
  String get empty_data => 'Empty Data';

  @override
  String get base_error_message => 'Oops, something went wrong. Please try again later or contact our support!';

  @override
  String get server_error_message => 'Sorry, an error occurred on the server. Please contact our support!';

  @override
  String get network_error_message => 'Sorry, an error occurred on network. Please check your connection or try again later.';

  @override
  String get bad_request_message => 'Sorry, an error occurred while sending the request to the server. Please contact our support!';

  @override
  String get page_not_found_message => 'Sorry, the request to the server was not found. Please contact our support!';

  @override
  String get unauthorized_error_message => 'Sorry, your authorization failed. Please re-login to continue!';

  @override
  String get sign_in_success => 'Login Success!';
}

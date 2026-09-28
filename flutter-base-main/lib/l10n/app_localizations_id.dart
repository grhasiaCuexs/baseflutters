// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get app_name => 'App Name';

  @override
  String general_required(String field_param, String isRequiredParam) {
    return '$field_param $isRequiredParam';
  }

  @override
  String get helloWorld => 'Halo Dunia!';

  @override
  String get is_required => 'harus diisi';

  @override
  String get password => 'Kata Sandi';

  @override
  String get email => 'Email';

  @override
  String emailRequired(String emailParam, String isRequiredParam) {
    return '$emailParam $isRequiredParam';
  }

  @override
  String get emailIsInvalid => 'Email salah';

  @override
  String passwordRequired(String passwordParam, String isRequiredParam) {
    return '$passwordParam $isRequiredParam';
  }

  @override
  String get data_not_found => 'Data tidak ditemukan!';

  @override
  String get sign_in => 'Masuk';

  @override
  String get empty_data => 'Data tidak tersedia';

  @override
  String get base_error_message => 'Maaf terjadi kesalahan. Silahkan coba untuk beberapa saat lagi atau Silahkan hubungi kontak support kami!';

  @override
  String get server_error_message => 'Maaf terjadi kesalahan pada server. Silahkan hubungi kontak support kami!';

  @override
  String get network_error_message => 'Maaf terjadi kesalahan pada jaringan. Silahkan cek jaringan anda atau coba untuk beberapa saat lagi.';

  @override
  String get bad_request_message => 'Maaf terjadi kesalahan ketika mengirim permintaan ke server. Silahkan hubungi kontak support kami!';

  @override
  String get page_not_found_message => 'Maaf permintaan ke server tidak ditemukan. Silahkan hubungi kontak support kami!';

  @override
  String get unauthorized_error_message => 'Maaf anda tidak memiliki otoritas untuk mengakses halaman ini. Lakukan login ulang untuk melanjutkan!';

  @override
  String get sign_in_success => 'Login Berhasil!';
}

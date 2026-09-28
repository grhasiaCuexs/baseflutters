class ValidatorHelpers {
  static bool isValidGmail(String email) {
    return RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        ).hasMatch(email) &&
        (email.endsWith("@gmail.com") ||
            email.contains("gamil.com") ||
            email.contains(
                "@mobile.com")); // yg gamilnya kalau udah fix bisa dihapus nanti
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    final isStartWithCode = phoneNumber.startsWith('+62');
    final isStartZero = phoneNumber.startsWith('0');
    final isStartValid = isStartWithCode || isStartZero;
    var isDigitValid = false;

    if (isStartZero) {
      isDigitValid = phoneNumber.length >= 11 && phoneNumber.length <= 13;
    } else if (isStartWithCode) {
      isDigitValid = phoneNumber.length >= 13 && phoneNumber.length <= 15;
    }

    return isStartValid && isDigitValid;
  }

  static bool isValidPassword(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]+$')
        .hasMatch(password);
  }

}
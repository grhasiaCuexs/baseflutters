import 'package:flutter/material.dart';

class MyColors {
  static const Color primaryColor = Color(0xFF149478);
  static const Color secondaryColor = Color(0xFF154397);
  static const Color defaultIconColor = Color(0xFF4F4F4F);
  static const Color backgroudColor = Color(0xFFFAFAFA); //Colors.white;
  static const Color onPrimaryBackgroundColor = Color(0xFF1A1A1A);
  static const Color dividerColor = Color(0xFF4C4C4C);
  static const Color titleFontColor = Colors.black;
  static const Color fontColor = onPrimaryBackgroundColor;
  static const Color hintColor = Color(0xFF636C5E);
  static const Color notificationColor = Color(0xFF149478);
  static const Color titleBarColor = Color(0xFF878BAB);
  static const Color colorDialog = Color(0xCC222225);
  static const Color backgroundDialog = Color(0xFFFFFFFF);
  static const Color medGreen = Color(0xFF1AC09C);

  // Feature Colors
  static const Color gray = Color(0xFF999EA1);
  static const Color borderBlueColor = Color(0xFF0F48A0);
  static const Color titleDark = Color(0xFF080C2F);
  static const Color mainBlue = Color(0xFF11499C);
  static const Color bodyText = Color(0xFF878BAB);
  static const Color outline = Color(0xFFCCCCCC);
  static const Color lightGreen = Color(0xFF32D8B2);
  static const Color purple = Color(0xFF3D3E90);
  static const Color warningSnackBarBackground = Color(0xFFFCED3A);
  static const Color warningSnackBarContent = Color(0xFF4B4601);
  static const Color iconTextFieldColor = Color(0xFF878BAB);
  static const Color greenButtonColor = Color(0xFF1AC09C);
  static const Color bgWhite = Color(0xFFFAFAFA);
}

class CustomStyles {
  static const double textFieldRadius = 16;

  static OutlineInputBorder generalOutlineBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(textFieldRadius)),
      borderSide: BorderSide(
        color: MyColors.outline,
      ),
    );
  }

  static OutlineInputBorder generalOutlineErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFFA8A8A)),
      borderRadius: BorderRadius.circular(textFieldRadius),
    );
  }

  static OutlineInputBorder generalFocusOutlineBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: MyColors.primaryColor),
      borderRadius: BorderRadius.circular(textFieldRadius),
    );
  }

  static InputDecoration get _generalInputDecorationStyle => InputDecoration(
        enabledBorder: generalOutlineBorder(),
        border: generalOutlineBorder(),
        focusedBorder: generalFocusOutlineBorder(),
        filled: true,
        fillColor: Colors.white,
        counterText: "", //counter text tidak akan muncul
        helperStyle: generalTextStyle().copyWith(
          fontSize: 12,
          color: MyColors.fontColor.withValues(alpha: 0.75),
          fontWeight: FontWeight.w300,
        ),
        contentPadding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
        focusedErrorBorder: generalOutlineErrorBorder(),
        errorBorder: generalOutlineErrorBorder(),
        errorStyle: errorTextStyle(),
        hintStyle: generalHintStyle(),
      );

  static InputDecoration generalTextFieldInputDecoration(
      {required String? hintText,
      required String? errorText,
      String? helperText,
      Widget? prefixIcon,
      Widget? suffixIcon}) {
    return _generalInputDecorationStyle.copyWith(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      errorText: errorText,
      helperText: helperText,
    );
  }

  static InputDecoration generalSearchTextFieldInputDecoration(
      {required String? hintText,
      String? errorText,
      String? helperText,
      int? errorMaxLines,
      Function()? onIconPressed}) {
    return _generalInputDecorationStyle.copyWith(
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        errorMaxLines: errorMaxLines,
        suffixIcon: IconButton(
            icon: Icon(Icons.search,
                color: MyColors.primaryColor.withValues(alpha: 0.5)),
            onPressed: onIconPressed));
  }

  static InputDecoration generalSelectTextFieldInputDecoration(
      {required String? hintText,
      String? errorText,
      String? helperText,
      int? errorMaxLines,
      Widget? prefixIcon,
      Function()? onIconPressed}) {
    return _generalInputDecorationStyle.copyWith(
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        errorMaxLines: errorMaxLines,
        prefixIcon: prefixIcon,
        suffixIcon: onIconPressed != null
            ? IconButton(
                icon: const Icon(Icons.arrow_right, color: MyColors.outline),
                onPressed: onIconPressed)
            : null);
  }

  static InputDecoration generalDateTimeFieldInputDecoration(
      {String? hintText,
      String? errorText,
      Widget? prefixIcon,
      Widget? suffixIcon,
      required Function() onIconPressed}) {
    return _generalInputDecorationStyle.copyWith(
      hintText: hintText ?? '--/--/--',
      errorText: errorText,
      prefixIcon: prefixIcon ??
          const Icon(
            Icons.date_range,
            size: 18,
            color: MyColors.iconTextFieldColor,
          ),
      suffixIcon: suffixIcon ??
          IconButton(
              icon: const Icon(
                Icons.arrow_drop_down,
                color: MyColors.iconTextFieldColor,
                size: 18,
              ),
              onPressed: onIconPressed),
    );
  }

  static InputDecoration passwordTextFormFieldInputDecoration({
    required BuildContext context,
    required String? hintText,
    required String? errorText,
    required bool showHidePassword,
    required bool passwordFocus,
    Widget? prefixIcon,
    required Function() onIconPressed,
  }) {
    return _generalInputDecorationStyle.copyWith(
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: IconButton(
            icon: Icon(
              !showHidePassword ? Icons.visibility : Icons.visibility_off,
              color: MyColors.outline,
              size: 18,
            ),
            onPressed: onIconPressed));
  }

  static const mediumTitle = TextStyle(
    color: Color(0xFF878BAB),
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static TextStyle generalHintStyle() {
    return const TextStyle(
      color: Color.fromARGB(200, 30, 30, 30),
      fontSize: 12,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle generalTextStyle() {
    return const TextStyle(
      color: MyColors.fontColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle generalTitleTextFieldStyle() {
    return const TextStyle(
      color: Color(0xFF878BAB),
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      height: 0,
    );
  }

  static TextStyle inputTextStyle() {
    return const TextStyle(color: MyColors.fontColor);
  }

  static TextStyle errorTextStyle() {
    return const TextStyle(color: Color(0xFFFF0000));
  }

  static TextStyle titleSettingTextStyle() {
    return const TextStyle(
      color: MyColors.fontColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 0,
      letterSpacing: -0.18,
    );
  }

  static TextStyle menuSettingTextStyle() {
    return const TextStyle(
      color: MyColors.fontColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 0,
      letterSpacing: -0.16,
    );
  }

  static TextStyle logoutTextStyle() {
    return const TextStyle(
      color: Color(0xFFC8141A),
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      height: 0,
      letterSpacing: -0.16,
    );
  }

  static TextStyle buttonMembershipTextStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle appBarTextStyle() {
    return const TextStyle(
      color: MyColors.titleBarColor,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle homeTitleTextStyle() {
    return const TextStyle(
        color: MyColors.fontColor, fontSize: 16, fontWeight: FontWeight.w700);
  }

  static TextStyle detailTitleTextStyle() {
    return const TextStyle(
      color: MyColors.fontColor,
      fontSize: 20,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle detailDescTextStyle() {
    return const TextStyle(
      color: MyColors.fontColor,
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle tagTextStyle() {
    return const TextStyle(
      color: MyColors.fontColor,
      fontSize: 13,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
    );
  }

  static const dialogTitleTextStyle = TextStyle(
    color: Color(0xFF283252),
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  static const dialogCancelTextStyle = TextStyle(
    color: Colors.red,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );

  static const dialogConfirmTextStyle = TextStyle(
    color: Colors.green,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
  );
  static const registrationFormStyle = TextStyle(
    color: Color(0xFF878BAB),
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
  );
  static const labelStyle = TextStyle(
    color: Color(0xFF070B2E),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
  );
  static const tinyText = TextStyle(
    color: Color(0xFF070B2E),
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
  static const medTitle = TextStyle(
    color: Color(0xFF878BAB),
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
  );
  static const titleCustomTextStyle = TextStyle(
    color: MyColors.fontColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const baseCustomTextStyle = TextStyle(
    color: MyColors.fontColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}

import 'package:flutter/material.dart';

class ColorWidget {
  static Color medGreen =
      const Color(0xFF1AC09C); // background color splashscreen
  static Color darkGreen = const Color(0xFF149478); // background color
  static Color colorDialog = const Color(0xCC222225); // background color

  static Color lightGreen = const Color(0xFF32D8B2); // color 1 for gradient
  static Color mainBlue = const Color(0xFF11499C); // color 2 for gradient
  static Color mainRed = const Color(0xFFED1C24); // label datetime
  static Color titleDark = const Color(0xFF080C2F); // for all shadows
  static Color bodyText = const Color(0xFF878BAB); // for button e-reservasi
  static Color bgWhite =
      const Color(0xFFFAFAFA); // for button riwayat reservasi
  static Color outline = const Color(0xFFCCCCCC); // for button tagihan

  static Color warningSnackBarBackground = const Color(0xFFFCED3A);
  static Color warningSnackBarContent = const Color(0xFF4B4601);

  Widget gradientColorBg() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [ColorWidget.medGreen, ColorWidget.lightGreen],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
        stops: const [0.0, 1.0],
      )),
    );
  }
}

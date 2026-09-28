import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myeshop/style/custom_styles.dart';

class ThemeFactory {
  static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: MyColors.primaryColor,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static ThemeData mainTheme(BuildContext context) => ThemeData(
      fontFamily: 'Roboto',
      splashColor: MyColors.primaryColor.withAlpha(10),
      colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor).copyWith(
        surface: Colors.white,
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        // surfaceTintColor: MyColors.backgroudColor,
        // backgroundColor: MyColors.backgroudColor,
        // foregroundColor: MyColors.backgroudColor,
        // systemOverlayStyle:
        //     const SystemUiOverlayStyle(statusBarColor: MyColors.primaryColor),
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: MyColors.primaryColor),
        titleTextStyle: CustomStyles.appBarTextStyle(),
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: MyColors.primaryColor,
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.primaryColor,
        unselectedItemColor: Color(0xFF1B1A1A),
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ),
      dialogTheme: Theme.of(context).dialogTheme.copyWith(
          backgroundColor: MyColors.backgroundDialog,
          titleTextStyle: Theme.of(context)
              .dialogTheme
              .titleTextStyle
              ?.copyWith(color: MyColors.fontColor),
          contentTextStyle: Theme.of(context)
              .dialogTheme
              .contentTextStyle
              ?.copyWith(color: MyColors.fontColor)),
      scaffoldBackgroundColor: MyColors.backgroudColor,
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: MyColors.fontColor,
            displayColor: MyColors.fontColor,
          ));
}

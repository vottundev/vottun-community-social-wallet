import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// A utility class that holds themes for the app.
/// This class has no constructor and all methods are `static`.
@immutable
class CustomTheme {
  const CustomTheme._();

  /// The main starting theme for the app.
  ///
  /// Sets the following defaults:
  /// * primaryColor: [Constants.primaryColor],
  /// * scaffoldBackgroundColor: [Constants.scaffoldColor],
  /// * fontFamily: [Constants.poppinsFont].fontFamily,
  /// * iconTheme: [Colors.white] for default icon
  /// * textButtonTheme: [TextButtonTheme] without the default padding,
  static final mainTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontFamily: 'TradeGothic',
          fontWeight: FontWeight.w400,
          fontSize: 32,
          color: AppColors.textBlack),
      titleMedium: TextStyle(
          fontFamily: 'TradeGothic',
          fontWeight: FontWeight.w400,
          fontSize: 25,
          color: AppColors.textBlack),
      titleSmall: TextStyle(
          fontFamily: 'TradeGothic',
          fontWeight: FontWeight.w400,
          fontSize: 22,
          color: AppColors.textBlack),
      bodyLarge: TextStyle(
          fontFamily: 'TradeGothic',
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: AppColors.textBlack),
      bodyMedium: TextStyle(
          fontFamily: 'TradeGothic',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.textBlack),
      bodySmall: TextStyle(
          fontFamily: 'TradeGothic',
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: AppColors.textBlack),
    ),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.black
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.0)
    ),
    inputDecorationTheme: const InputDecorationTheme(
      prefixStyle: TextStyle(
        fontSize: 18,
        color: Colors.black
      ),
      hintStyle: TextStyle(
        fontSize: 18
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0), textStyle: const TextStyle(
          fontFamily: 'TradeGothic',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: AppColors.primaryWhite)),
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryWhite),
  );
}

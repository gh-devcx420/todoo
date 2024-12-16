import 'package:flutter/material.dart';
import 'package:todoo_app/constants.dart';

class AppTheme {
  static ThemeData lightTheme(
      TextStyle baseTextStyle, ColorScheme appColourScheme) {
    return ThemeData(useMaterial3: true, colorScheme: appColourScheme).copyWith(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: appColourScheme.surface,
        titleTextStyle: TextStyle(
          fontFamily: 'JosefinSans',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: appColourScheme.primary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kTodooAppRoundness),
          borderSide: BorderSide(
            color: appColourScheme.primary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kTodooAppRoundness),
          borderSide: BorderSide(
            color: appColourScheme.primary,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kTodooAppRoundness),
          borderSide: BorderSide(
            color: appColourScheme.primary,
            width: 1,
          ),
        ),
        prefixIconColor: appColourScheme.primary,
        fillColor: appColourScheme.surfaceContainer,
        filled: true,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
          fontFamily: 'JosefinSans',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: appColourScheme.primary,
        ),
        subtitleTextStyle: TextStyle(
          fontFamily: 'JosefinSans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: appColourScheme.primary,
        ),
        tileColor: appColourScheme.primary.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kTodooAppRoundness),
        ),
      ),
      textTheme: setTextThemes(
        baseTextStyle,
        appColourScheme.primary,
      ),
    );
  }

  static ThemeData darkTheme(
      TextStyle baseTextStyle, ColorScheme appColourScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: appColourScheme,
    ).copyWith(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: appColourScheme.surface,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: appColourScheme.primary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kTodooAppRoundness),
          borderSide: BorderSide(
            color: appColourScheme.primary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kTodooAppRoundness),
          borderSide: BorderSide(
            color: appColourScheme.primary,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kTodooAppRoundness),
          borderSide: BorderSide(
            color: appColourScheme.primary,
            width: 1,
          ),
        ),
        prefixIconColor: appColourScheme.primary,
        fillColor: appColourScheme.surfaceContainer,
        filled: true,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
          fontFamily: 'JosefinSans',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: appColourScheme.primary,
        ),
      ),
      textTheme: setTextThemes(
        baseTextStyle,
        appColourScheme.primary,
      ),
    );
  }

  static setTextThemes(TextStyle baseStyle, Color textColor) {
    return TextTheme(
      titleLarge: baseStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: baseStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleSmall: baseStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelLarge: baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelMedium: baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      labelSmall: baseStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: baseStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: baseStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
    );
  }
}

import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColorSchemes {
  static const lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    inversePrimary: AppColors.secondary,
    tertiary: AppColors.tertiary,
    surface: AppColors.whiteColors,
    inverseSurface: AppColors.whiteColors,
  );

  static const darkColorScheme = ColorScheme.dark(
    primary: AppColors.secondary,
    inversePrimary: AppColors.primary,
    tertiary: AppColors.tertiary,
    surface: AppColors.primary,
    inverseSurface: AppColors.appBackGroundColors,
  );
}

class AppTheme {
  static final lightThemeCopy = ThemeData(
      // datePickerTheme: const DatePickerThemeData(
      //   backgroundColor: AppColors.primary,
      //   todayBackgroundColor: MaterialStatePropertyAll(AppColors.secondary),
      // ),
      fontFamily: GoogleFonts.dmSans().fontFamily,
      colorScheme: AppColorSchemes.lightColorScheme,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: AppColors.secondary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        backgroundColor: AppColorSchemes.lightColorScheme.primary,
      ),
      textTheme: AppTextTheme.textTheme(AppColorSchemes.lightColorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            shadowColor: AppColors.secondary.withOpacity(0.5),
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            minimumSize: const Size(double.infinity, 50),
            textStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary), // Add your text style here
        ),
      ),
      dialogTheme: DialogTheme(
          backgroundColor: AppColors.appBackGroundColors.withOpacity(0.5),
          surfaceTintColor: Colors.transparent));

  static final darkTheme = ThemeData(
    colorScheme: AppColorSchemes.darkColorScheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 5,
      shadowColor: AppColors.secondary.withOpacity(0.5),
      backgroundColor: AppColorSchemes.darkColorScheme.primary,
    ),
    textTheme: AppTextTheme.textTheme(AppColorSchemes.darkColorScheme),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          minimumSize: const Size(double.infinity, 50),
          textStyle: const TextStyle(fontSize: 12)),
    ),
  );
}

class AppTextTheme {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        /// Use this for titles like in app bars etc
        displayLarge: GoogleFonts.dmSans(
          color: AppColors.primary,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),

        /// Use this for attribute title or sub headings
        titleLarge: GoogleFonts.dmSans(
          color: colorScheme.inverseSurface,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),

        /// Use this for when to bold any kind of attributes in a card or UI widget
        bodyLarge: GoogleFonts.dmSans(
          color: colorScheme.inverseSurface,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),

        /// Use this for any kind of attributes in a card or UI widget
        bodyMedium: GoogleFonts.dmSans(
          color: AppColors.primary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),

        /// Used for bold headings of textfields and other widgets
        titleMedium: GoogleFonts.dmSans(
          color: colorScheme.inverseSurface,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),

        /// Used for non bold/regular headings of textfields and other widgets
        titleSmall: GoogleFonts.dmSans(
          color: colorScheme.inverseSurface,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),

        /// Use this for any kind of attributes in a card or UI widget
        bodySmall: GoogleFonts.dmSans(
          fontWeight: FontWeight.w400,
          color: colorScheme.inverseSurface,
          fontSize: 12,
        ),
      );
}

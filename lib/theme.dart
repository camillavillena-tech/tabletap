import 'package:flutter/material.dart';

final tableTapColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFFAE3C00),
  brightness: Brightness.light,
).copyWith(
  primary: const Color(0xFFAE3C00),
  onPrimary: const Color(0xFFFFFFFF),
  secondary: const Color(0xFFE47526),
  onSecondary: const Color(0xFF290E07),
  surface: const Color(0xFFFDF8EF),
  onSurface: const Color(0xFF290E07),
  error: const Color(0xFFD32F2F),
  onError: const Color(0xFFFFFFFF),
);

class AppColors {
  static const surfaceContainer = Color(0xFFFFFFFF);
  static const border = Color(0xFFE4E0DB);
  static const primaryText = Color(0xFF000000);
  static const secondaryText = Color(0xFF666666);
  static const navigationText = Color(0xFF726C6C);
}

const tableTapTextTheme = TextTheme(
  displaySmall: TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
  ),
  headlineMedium: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF290E07),
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  ),
  labelSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  ),
);

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

class AppStatusColors {
  static const received = Color(0xFFFB5154);
  static const preparing = Color(0xFFECB716);
  static const ready = Color(0xFF29A500);
  static const completed = Color(0xFF62920A);
  static const inactive = Color(0xFFBDBDBD);
}

final tableTapTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'AstaSans',
  colorScheme: tableTapColorScheme,
  scaffoldBackgroundColor: const Color(0xFFFDF8EF),
  textTheme: tableTapTextTheme,

  cardTheme: const CardThemeData(
    color: AppColors.surfaceContainer,
    margin: EdgeInsets.all(AppSpacing.sm),
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(48),
    ),
  ),
);
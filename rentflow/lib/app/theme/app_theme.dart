import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Shared brand and surface colors used by the app's themes and feature UI.
abstract final class RentFlowPalette {
  static const accent = Color(0xFF155FC0);
  static const accentBright = Color(0xFF3687FF);

  static const darkBackground = Color(0xFF050B14);
  static const darkPanel = Color(0xFF07111F);
  static const darkInput = Color(0xFF0B1726);
  static const darkBorder = Color(0xFF1B2A3D);
  static const darkText = Color(0xFFF3F6FC);
  static const darkMuted = Color(0xFF9AACC2);

  static const lightBackground = Color(0xFFF5F7FA);
  static const lightPanel = Color(0xFFFCFDFE);
  static const lightInput = Color(0xFFF7F9FC);
  static const lightBorder = Color(0xFFE2E8F0);
  static const lightText = Color(0xFF14263C);
  static const lightMuted = Color(0xFF62748A);
}

abstract final class RentFlowTypography {
  static const display = 'RentFlowDisplay';

  static TextStyle title(BuildContext context) => _style(
    context,
    ios: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
    android: Theme.of(context).textTheme.titleMedium!,
  );

  static TextStyle body(BuildContext context) {
    final iosStyle = CupertinoTheme.of(context).textTheme.textStyle;
    return _style(
      context,
      ios: iosStyle.copyWith(fontSize: (iosStyle.fontSize ?? 17) * .82),
      android: Theme.of(context).textTheme.bodyMedium!,
    );
  }

  static TextStyle supporting(BuildContext context) {
    final iosStyle = CupertinoTheme.of(context).textTheme.textStyle;
    return _style(
      context,
      ios: iosStyle.copyWith(fontSize: (iosStyle.fontSize ?? 17) * .70),
      android: Theme.of(context).textTheme.bodySmall!,
    );
  }

  static TextStyle control(BuildContext context) {
    final iosStyle = CupertinoTheme.of(context).textTheme.actionTextStyle;
    return _style(
      context,
      ios: iosStyle.copyWith(fontSize: (iosStyle.fontSize ?? 16) * .85),
      android: Theme.of(context).textTheme.labelLarge!,
    );
  }

  static TextStyle _style(
    BuildContext context, {
    required TextStyle ios,
    required TextStyle android,
  }) => Theme.of(context).platform == TargetPlatform.iOS ? ios : android;
}

class AppTheme {
  const AppTheme._();

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: RentFlowPalette.accent,
          brightness: Brightness.light,
        ).copyWith(
          primary: RentFlowPalette.accent,
          onPrimary: Colors.white,
          surface: RentFlowPalette.lightPanel,
          onSurface: RentFlowPalette.lightText,
        ),
    scaffoldBackgroundColor: RentFlowPalette.lightBackground,
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: RentFlowPalette.accent,
          brightness: Brightness.dark,
        ).copyWith(
          primary: RentFlowPalette.accentBright,
          onPrimary: RentFlowPalette.darkBackground,
          surface: RentFlowPalette.darkPanel,
          onSurface: RentFlowPalette.darkText,
        ),
    scaffoldBackgroundColor: RentFlowPalette.darkBackground,
  );
}

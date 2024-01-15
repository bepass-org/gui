import 'package:flutter/material.dart';

const int _primaryColor = 0xFF6366F1;
const MaterialColor primarySwatch = MaterialColor(_primaryColor, <int, Color>{
  50: Color(0xFFEEF2FF), // indigo-50
  100: Color(0xFFE0E7FF), // indigo-100
  200: Color(0xFFC7D2FE), // indigo-200
  300: Color(0xFFA5B4FC), // indigo-300
  400: Color(0xFF818CF8), // indigo-400
  500: Color(_primaryColor), // indigo-500
  600: Color(0xFF4F46E5), // indigo-600
  700: Color(0xFF4338CA), // indigo-700
  800: Color(0xFF3730A3), // indigo-800
  900: Color(0xFF312E81), // indigo-900
});

const int _textColor = 0xFF64748B;
const MaterialColor textSwatch = MaterialColor(_textColor, <int, Color>{
  50: Color(0xFFF8FAFC), // slate-50
  100: Color(0xFFF1F5F9), // slate-100
  200: Color(0xFFE2E8F0), // slate-200
  300: Color(0xFFCBD5E1), // slate-300
  400: Color(0xFF94A3B8), // slate-400
  500: Color(_textColor), // slate-500
  600: Color(0xFF475569), // slate-600
  700: Color(0xFF334155), // slate-700
  800: Color(0xFF1E293B), // slate-800
  900: Color(0xFF0F172A), // slate-900
});

const Color errorColor = Color(0xFFDC2626); // red-600

final ColorScheme lightColorScheme = ColorScheme.light(
  primary: primarySwatch.shade500,
  secondary: primarySwatch.shade500,
  onSecondary: Colors.white,
  error: errorColor,
  background: textSwatch.shade200,
  onBackground: textSwatch.shade500,
  onSurface: textSwatch.shade500,
  surface: textSwatch.shade50,
  surfaceVariant: Colors.white,
  shadow: textSwatch.shade900.withOpacity(.1),
);

final ColorScheme darkColorScheme = ColorScheme.dark(
  primary: primarySwatch.shade500,
  secondary: primarySwatch.shade500,
  onSecondary: Colors.white,
  error: errorColor,
  background: const Color(0xFF171724),
  onBackground: textSwatch.shade400,
  onSurface: textSwatch.shade300,
  surface: const Color(0xFF262630),
  surfaceVariant: const Color(0xFF282832),
  shadow: textSwatch.shade900.withOpacity(.2),
);

class Styles {
  static const _defaultTextStyle = TextStyle(fontWeight: FontWeight.w500);

  ThemeData themeData(int index, BuildContext context) {
    switch (index) {
      case 0:
        return setWhiteTheme(context);
      case 1:
        return setBlackTheme(context);
      case 2:
        return setOtherTheme(
            context: context, mColor: Colors.red, color: Colors.red);
      case 3:
        return setOtherTheme(
            context: context, mColor: Colors.green, color: Colors.greenAccent);
        ;
      case 4:
        return setOtherTheme(
            context: context, mColor: Colors.blue, color: Colors.blueAccent);
      case 5:
        return setOtherTheme(
            context: context,
            mColor: Colors.yellow,
            color: Colors.yellowAccent);
      case 6:
        return setOtherTheme(
            context: context, mColor: Colors.amber, color: Colors.amber);
      default:
        return setWhiteTheme(context);
    }
  }

  ThemeData setWhiteTheme(BuildContext context) {
    return ThemeData(
      colorScheme: lightColorScheme,
      useMaterial3: true,
      fontFamily: 'Nunito',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: textSwatch.shade700,
          fontFamily: 'Nunito',
        ),
        displayMedium: TextStyle(
          color: textSwatch.shade600,
          fontFamily: 'Nunito',
        ),
        displaySmall: TextStyle(
          color: textSwatch.shade500,
          fontFamily: 'Nunito',
        ),
        headlineLarge: TextStyle(
          color: textSwatch.shade700,
          fontFamily: 'Nunito',
        ),
        headlineMedium: TextStyle(
          color: textSwatch.shade600,
          fontFamily: 'Nunito',
        ),
        headlineSmall: TextStyle(
          color: textSwatch.shade500,
          fontFamily: 'Nunito',
        ),
        titleLarge: TextStyle(
          color: textSwatch.shade700,
          fontFamily: 'Nunito',
        ),
        titleMedium: TextStyle(
          color: textSwatch.shade600,
          fontFamily: 'Nunito',
        ),
        titleSmall: TextStyle(
          color: textSwatch.shade500,
          fontFamily: 'Nunito',
        ),
        bodyLarge: TextStyle(
          color: textSwatch.shade700,
          fontFamily: 'Nunito',
        ),
        bodyMedium: TextStyle(
          color: textSwatch.shade600,
          fontFamily: 'Nunito',
        ),
        bodySmall: TextStyle(
          color: textSwatch.shade500,
          fontFamily: 'Nunito',
        ),
        labelLarge: TextStyle(
          color: textSwatch.shade700,
          fontFamily: 'Nunito',
        ),
        labelMedium: TextStyle(
          color: textSwatch.shade600,
          fontFamily: 'Nunito',
        ),
        labelSmall: TextStyle(
          color: textSwatch.shade500,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }

  ThemeData setBlackTheme(BuildContext context) {
    return ThemeData(
      colorScheme: darkColorScheme,
      useMaterial3: true,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        displayMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        displaySmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
        headlineLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        headlineMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        headlineSmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
        titleLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        titleMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        titleSmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
        bodyLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        bodyMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        bodySmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
        labelLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        labelMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        labelSmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }

  ColorScheme setOtherColorScheme({
    required MaterialColor mColor,
  }) {
    return ColorScheme.dark(
      primary: mColor.shade500,
      secondary: primarySwatch.shade500,
      onSecondary: Colors.white,
      error: errorColor,
      background: const Color(0xFF171724),
      onBackground: textSwatch.shade400,
      onSurface: textSwatch.shade300,
      surface: const Color(0xFF262630),
      surfaceVariant: const Color(0xFF282832),
      shadow: textSwatch.shade900.withOpacity(.2),
    );
  }

  ThemeData setOtherTheme({
    required BuildContext context,
    required MaterialColor mColor,
    required Color color,
  }) {
    return ThemeData(
      colorScheme: setOtherColorScheme(mColor: mColor),
      useMaterial3: true,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        displayMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        displaySmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
        headlineLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        headlineMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        headlineSmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
        titleLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        titleMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        titleSmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
        bodyLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        bodyMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        bodySmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
        labelLarge: TextStyle(
          color: textSwatch.shade200,
          fontFamily: 'Nunito',
        ),
        labelMedium: TextStyle(
          color: textSwatch.shade300,
          fontFamily: 'Nunito',
        ),
        labelSmall: TextStyle(
          color: textSwatch.shade400,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }
}

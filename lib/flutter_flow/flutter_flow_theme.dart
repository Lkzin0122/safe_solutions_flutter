import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return FlutterFlowTheme();
  }
  static const Color primaryColor = Color(0xFF4B39EF);
  static const Color secondaryColor = Color(0xFF39D2C0);
  static const Color tertiaryColor = Color(0xFFEE8B60);
  static const Color alternate = Color(0xFFE0E3E7);
  static const Color primaryBackground = Color(0xFFF1F4F8);
  static const Color secondaryBackground = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF14181B);
  static const Color secondaryText = Color(0xFF57636C);
  static const Color accent1 = Color(0xFF616161);
  static const Color accent2 = Color(0xFF757575);
  static const Color accent3 = Color(0xFFE0E0E0);
  static const Color accent4 = Color(0xFFEEEEEE);
  static const Color success = Color(0xFF04A24C);
  static const Color error = Color(0xFFE21C3D);
  static const Color warning = Color(0xFFFCDC0C);
  static const Color info = Color(0xFF1C4494);

  // Getters para compatibilidade
  TextStyle get displayLarge => FlutterFlowTheme.displayLarge;
  TextStyle get displayMedium => FlutterFlowTheme.displayMedium;
  TextStyle get displaySmall => FlutterFlowTheme.displaySmall;
  TextStyle get headlineLarge => FlutterFlowTheme.headlineLarge;
  TextStyle get headlineMedium => FlutterFlowTheme.headlineMedium;
  TextStyle get headlineSmall => FlutterFlowTheme.headlineSmall;
  TextStyle get titleLarge => FlutterFlowTheme.titleLarge;
  TextStyle get titleMedium => FlutterFlowTheme.titleMedium;
  TextStyle get titleSmall => FlutterFlowTheme.titleSmall;
  TextStyle get labelLarge => FlutterFlowTheme.labelLarge;
  TextStyle get labelMedium => FlutterFlowTheme.labelMedium;
  TextStyle get labelSmall => FlutterFlowTheme.labelSmall;
  TextStyle get bodyLarge => FlutterFlowTheme.bodyLarge;
  TextStyle get bodyMedium => FlutterFlowTheme.bodyMedium;
  TextStyle get bodySmall => FlutterFlowTheme.bodySmall;

  String get displayLargeFamily => FlutterFlowTheme.displayLargeFamily;
  String get displayMediumFamily => FlutterFlowTheme.displayMediumFamily;
  String get displaySmallFamily => FlutterFlowTheme.displaySmallFamily;
  String get headlineLargeFamily => FlutterFlowTheme.headlineLargeFamily;
  String get headlineMediumFamily => FlutterFlowTheme.headlineMediumFamily;
  String get headlineSmallFamily => FlutterFlowTheme.headlineSmallFamily;
  String get titleLargeFamily => FlutterFlowTheme.titleLargeFamily;
  String get titleMediumFamily => FlutterFlowTheme.titleMediumFamily;
  String get titleSmallFamily => FlutterFlowTheme.titleSmallFamily;
  String get labelLargeFamily => FlutterFlowTheme.labelLargeFamily;
  String get labelMediumFamily => FlutterFlowTheme.labelMediumFamily;
  String get labelSmallFamily => FlutterFlowTheme.labelSmallFamily;
  String get bodyLargeFamily => FlutterFlowTheme.bodyLargeFamily;
  String get bodyMediumFamily => FlutterFlowTheme.bodyMediumFamily;
  String get bodySmallFamily => FlutterFlowTheme.bodySmallFamily;

  bool get displayLargeIsCustom => FlutterFlowTheme.displayLargeIsCustom;
  bool get displayMediumIsCustom => FlutterFlowTheme.displayMediumIsCustom;
  bool get displaySmallIsCustom => FlutterFlowTheme.displaySmallIsCustom;
  bool get headlineLargeIsCustom => FlutterFlowTheme.headlineLargeIsCustom;
  bool get headlineMediumIsCustom => FlutterFlowTheme.headlineMediumIsCustom;
  bool get headlineSmallIsCustom => FlutterFlowTheme.headlineSmallIsCustom;
  bool get titleLargeIsCustom => FlutterFlowTheme.titleLargeIsCustom;
  bool get titleMediumIsCustom => FlutterFlowTheme.titleMediumIsCustom;
  bool get titleSmallIsCustom => FlutterFlowTheme.titleSmallIsCustom;
  bool get labelLargeIsCustom => FlutterFlowTheme.labelLargeIsCustom;
  bool get labelMediumIsCustom => FlutterFlowTheme.labelMediumIsCustom;
  bool get labelSmallIsCustom => FlutterFlowTheme.labelSmallIsCustom;
  bool get bodyLargeIsCustom => FlutterFlowTheme.bodyLargeIsCustom;
  bool get bodyMediumIsCustom => FlutterFlowTheme.bodyMediumIsCustom;
  bool get bodySmallIsCustom => FlutterFlowTheme.bodySmallIsCustom;

  // Cores como getters
  Color get primaryColor => FlutterFlowTheme.primaryColor;
  Color get secondaryColor => FlutterFlowTheme.secondaryColor;
  Color get tertiaryColor => FlutterFlowTheme.tertiaryColor;
  Color get alternate => FlutterFlowTheme.alternate;
  Color get primaryBackground => FlutterFlowTheme.primaryBackground;
  Color get secondaryBackground => FlutterFlowTheme.secondaryBackground;
  Color get primaryText => FlutterFlowTheme.primaryText;
  Color get secondaryText => FlutterFlowTheme.secondaryText;
  Color get accent1 => FlutterFlowTheme.accent1;
  Color get accent2 => FlutterFlowTheme.accent2;
  Color get accent3 => FlutterFlowTheme.accent3;
  Color get accent4 => FlutterFlowTheme.accent4;
  Color get success => FlutterFlowTheme.success;
  Color get error => FlutterFlowTheme.error;
  Color get warning => FlutterFlowTheme.warning;
  Color get info => FlutterFlowTheme.info;

  static TextStyle get displayLarge => GoogleFonts.outfit(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    color: primaryText,
  );

  static TextStyle get displayMedium => GoogleFonts.outfit(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    color: primaryText,
  );

  static TextStyle get displaySmall => GoogleFonts.outfit(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: primaryText,
  );

  static TextStyle get headlineLarge => GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: primaryText,
  );

  static TextStyle get headlineMedium => GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: primaryText,
  );

  static TextStyle get headlineSmall => GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: primaryText,
  );

  static TextStyle get titleLarge => GoogleFonts.outfit(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: primaryText,
  );

  static TextStyle get titleMedium => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: primaryText,
  );

  static TextStyle get titleSmall => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryText,
  );

  static TextStyle get labelLarge => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryText,
  );

  static TextStyle get labelMedium => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: primaryText,
  );

  static TextStyle get labelSmall => GoogleFonts.outfit(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: primaryText,
  );

  static TextStyle get bodyLarge => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: primaryText,
  );

  static TextStyle get bodyMedium => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: primaryText,
  );

  static TextStyle get bodySmall => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: primaryText,
  );

  static String get displayLargeFamily => 'Outfit';
  static String get displayMediumFamily => 'Outfit';
  static String get displaySmallFamily => 'Outfit';
  static String get headlineLargeFamily => 'Outfit';
  static String get headlineMediumFamily => 'Outfit';
  static String get headlineSmallFamily => 'Outfit';
  static String get titleLargeFamily => 'Outfit';
  static String get titleMediumFamily => 'Outfit';
  static String get titleSmallFamily => 'Outfit';
  static String get labelLargeFamily => 'Outfit';
  static String get labelMediumFamily => 'Outfit';
  static String get labelSmallFamily => 'Outfit';
  static String get bodyLargeFamily => 'Outfit';
  static String get bodyMediumFamily => 'Outfit';
  static String get bodySmallFamily => 'Outfit';

  static bool get displayLargeIsCustom => false;
  static bool get displayMediumIsCustom => false;
  static bool get displaySmallIsCustom => false;
  static bool get headlineLargeIsCustom => false;
  static bool get headlineMediumIsCustom => false;
  static bool get headlineSmallIsCustom => false;
  static bool get titleLargeIsCustom => false;
  static bool get titleMediumIsCustom => false;
  static bool get titleSmallIsCustom => false;
  static bool get labelLargeIsCustom => false;
  static bool get labelMediumIsCustom => false;
  static bool get labelSmallIsCustom => false;
  static bool get bodyLargeIsCustom => false;
  static bool get bodyMediumIsCustom => false;
  static bool get bodySmallIsCustom => false;
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) {
    return copyWith(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      height: lineHeight,
    );
  }
}
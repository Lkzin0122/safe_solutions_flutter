import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return FlutterFlowTheme();
  }
  
  // Color constants
  static const Color primaryColor = Color(0xFF204060);
  static const Color secondaryColor = Color(0xFF2196F3);
  static const Color tertiaryColor = Color(0xFF204060);
  static const Color alternateColor = Color(0xFFE0E3E7);
  static const Color primaryBackgroundColor = Color(0xFFF1F4F8);
  static const Color secondaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color primaryTextColor = Color(0xFF14181B);
  static const Color secondaryTextColor = Color(0xFF57636C);
  static const Color accent1Color = Color(0xFF616161);
  static const Color accent2Color = Color(0xFF757575);
  static const Color accent3Color = Color(0xFFE0E0E0);
  static const Color accent4Color = Color(0xFFEEEEEE);
  static const Color successColor = Color(0xFF04A24C);
  static const Color errorColor = Color(0xFFE21C3D);
  static const Color warningColor = Color(0xFF204060);
  static const Color infoColor = Color(0xFF204060);

  // Instance color getters
  Color get primary => primaryColor;
  Color get secondary => secondaryColor;
  Color get tertiary => tertiaryColor;
  Color get alternate => alternateColor;
  Color get primaryBackground => primaryBackgroundColor;
  Color get secondaryBackground => secondaryBackgroundColor;
  Color get primaryText => primaryTextColor;
  Color get secondaryText => secondaryTextColor;
  Color get accent1 => accent1Color;
  Color get accent2 => accent2Color;
  Color get accent3 => accent3Color;
  Color get accent4 => accent4Color;
  Color get success => successColor;
  Color get error => errorColor;
  Color get warning => warningColor;
  Color get info => infoColor;

  // Text style getters
  TextStyle get displayLarge => _displayLarge;
  TextStyle get displayMedium => _displayMedium;
  TextStyle get displaySmall => _displaySmall;
  TextStyle get headlineLarge => _headlineLarge;
  TextStyle get headlineMedium => _headlineMedium;
  TextStyle get headlineSmall => _headlineSmall;
  TextStyle get titleLarge => _titleLarge;
  TextStyle get titleMedium => _titleMedium;
  TextStyle get titleSmall => _titleSmall;
  TextStyle get labelLarge => _labelLarge;
  TextStyle get labelMedium => _labelMedium;
  TextStyle get labelSmall => _labelSmall;
  TextStyle get bodyLarge => _bodyLarge;
  TextStyle get bodyMedium => _bodyMedium;
  TextStyle get bodySmall => _bodySmall;

  // Font family getters
  String get displayLargeFamily => 'Outfit';
  String get displayMediumFamily => 'Outfit';
  String get displaySmallFamily => 'Outfit';
  String get headlineLargeFamily => 'Outfit';
  String get headlineMediumFamily => 'Outfit';
  String get headlineSmallFamily => 'Outfit';
  String get titleLargeFamily => 'Outfit';
  String get titleMediumFamily => 'Outfit';
  String get titleSmallFamily => 'Outfit';
  String get labelLargeFamily => 'Outfit';
  String get labelMediumFamily => 'Outfit';
  String get labelSmallFamily => 'Outfit';
  String get bodyLargeFamily => 'Outfit';
  String get bodyMediumFamily => 'Outfit';
  String get bodySmallFamily => 'Outfit';

  // Custom font getters
  bool get displayLargeIsCustom => false;
  bool get displayMediumIsCustom => false;
  bool get displaySmallIsCustom => false;
  bool get headlineLargeIsCustom => false;
  bool get headlineMediumIsCustom => false;
  bool get headlineSmallIsCustom => false;
  bool get titleLargeIsCustom => false;
  bool get titleMediumIsCustom => false;
  bool get titleSmallIsCustom => false;
  bool get labelLargeIsCustom => false;
  bool get labelMediumIsCustom => false;
  bool get labelSmallIsCustom => false;
  bool get bodyLargeIsCustom => false;
  bool get bodyMediumIsCustom => false;
  bool get bodySmallIsCustom => false;

  // Private text style definitions
  static TextStyle get _displayLarge => GoogleFonts.outfit(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static TextStyle get _displayMedium => GoogleFonts.outfit(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static TextStyle get _displaySmall => GoogleFonts.outfit(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static TextStyle get _headlineLarge => GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static TextStyle get _headlineMedium => GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static TextStyle get _headlineSmall => GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static TextStyle get _titleLarge => GoogleFonts.outfit(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );

  static TextStyle get _titleMedium => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );

  static TextStyle get _titleSmall => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );

  static TextStyle get _labelLarge => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );

  static TextStyle get _labelMedium => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );

  static TextStyle get _labelSmall => GoogleFonts.outfit(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );

  static TextStyle get _bodyLarge => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static TextStyle get _bodyMedium => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );

  static TextStyle get _bodySmall => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: primaryTextColor,
  );


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
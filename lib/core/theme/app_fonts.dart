import 'package:flutter/material.dart';

/// Custom font helper for Satoshi font family
class AppFonts {
  AppFonts._();

  static const String satoshi = 'Satoshi';

  /// Creates a TextStyle using Satoshi font
  static TextStyle satoshiStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: satoshi,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }
}

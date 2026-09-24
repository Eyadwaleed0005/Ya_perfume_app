import 'package:flutter/material.dart';

abstract class AppColors {
  // ===== True Color Primitives =====
  static const Color darkBrown = Color(0xFF2F1C15);
  static const Color darkSurface = Color(0xFF0B0B0D);
  static const Color darkSurfaceRaised = Color(0xFF17171B);
  static const Color goldAccent = Color(0xFFC9A44E);
  static const Color goldAccentLight = Color(0xFFF1D58A);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFEDEDEF);
  static const Color mutedGray = Color(0xFFC7C7CC);
  static const Color ultraBlack = Color(0xFF050506);
  static const Color veryDarkGrayishBlue = Color(0xFF4D4D55);

  // ===== Semantic Background Colors =====
  static const Color bgCanvas = ultraBlack;
  static const Color bgSurface = darkSurface;
  static const Color bgSurfaceRaised = darkSurfaceRaised;
  static const Color bgAccent = goldAccent;

  // ===== Text Color Tokens =====

  static const Color textPrimary = pureWhite;
  static const Color textSecondary = offWhite;
  static const Color textMuted = mutedGray;
  static const Color textAccent = goldAccentLight;
  static const Color textDark = darkBrown;
  static const Color textUltraBlack = ultraBlack;
  static const Color textVeryDarkGrayishBlue = veryDarkGrayishBlue;

  // ===== Border & Divider Tokens =====
  static const Color borderDefault = pureWhite;
  static const Color borderSubtle = Color(0x24FFFFFF);
  static const Color borderAccent = goldAccent;
  static const Color borderFocus = goldAccentLight;
}

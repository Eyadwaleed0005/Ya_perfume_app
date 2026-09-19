import 'package:flutter/material.dart';

abstract class AppColors {
  // ===== True Color Primitives =====
  static const Color darkCanvas = Color(0xFF050506);
  static const Color darkSurface = Color(0xFF0B0B0D);
  static const Color darkSurfaceRaised = Color(0xFF17171B);
  static const Color goldAccent = Color(0xFFC9A44E);
  static const Color goldAccentLight = Color(0xFFF1D58A);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFEDEDEF);
  static const Color mutedGray = Color(0xFFC7C7CC);

  // ===== Semantic Background Colors =====
  static const Color bgCanvas = darkCanvas;
  static const Color bgSurface = darkSurface;
  static const Color bgSurfaceRaised = darkSurfaceRaised;
  static const Color bgAccent = goldAccent;

  // ===== Text Color Tokens =====
  static const Color textPrimary = pureWhite;
  static const Color textSecondary = offWhite;
  static const Color textMuted = mutedGray;
  static const Color textAccent = goldAccentLight;

  // ===== Border & Divider Tokens =====
  // opacity 14% -> 0.14 * 255 = 35 (HEX 0x24)
  static const Color borderSubtle = Color(0x24FFFFFF);
  static const Color borderAccent = goldAccent;
  static const Color borderFocus = goldAccentLight;
}

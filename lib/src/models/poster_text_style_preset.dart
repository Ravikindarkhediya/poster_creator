import 'package:flutter/material.dart';

/// Styling presets for text stickers.
class PosterTextStylePreset {
  final String frameId;
  final String fontKey;
  final int fontWeight;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final bool shadowEnabled;
  final Color shadowColor;
  final double shadowBlur;
  final double paddingFactor;
  final double letterSpacing;

  const PosterTextStylePreset({
    required this.frameId,
    required this.fontKey,
    required this.fontWeight,
    required this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.shadowEnabled = false,
    this.shadowColor = Colors.black,
    this.shadowBlur = 10,
    this.paddingFactor = 0.06,
    this.letterSpacing = 0,
  });

  static const PosterTextStylePreset plain = PosterTextStylePreset(
    frameId: 'plain',
    fontKey: 'Poppins',
    fontWeight: 400,
    textColor: Colors.white,
    paddingFactor: 0.035,
  );

  static const PosterTextStylePreset capsule = PosterTextStylePreset(
    frameId: 'capsule',
    fontKey: 'Poppins',
    fontWeight: 900,
    textColor: Colors.white,
    backgroundColor: Color(0xFF2F6BFF),
    borderColor: Color(0x99FFFFFF),
    borderWidth: 1.5,
    shadowEnabled: true,
    shadowColor: Color(0xAA2F6BFF),
    shadowBlur: 18,
    paddingFactor: 0.085,
  );

  static const PosterTextStylePreset outline = PosterTextStylePreset(
    frameId: 'outline',
    fontKey: 'Montserrat',
    fontWeight: 800,
    textColor: Colors.white,
    backgroundColor: Color(0x33000000),
    borderColor: Colors.white,
    borderWidth: 2,
    paddingFactor: 0.07,
  );

  static const PosterTextStylePreset neon = PosterTextStylePreset(
    frameId: 'neon',
    fontKey: 'Nunito',
    fontWeight: 900,
    textColor: Color(0xFFFFF2A1),
    backgroundColor: Color(0x22000000),
    borderColor: Color(0xFFFFF2A1),
    borderWidth: 1.5,
    shadowEnabled: true,
    shadowColor: Color(0xFFFFF2A1),
    shadowBlur: 22,
    paddingFactor: 0.07,
    letterSpacing: 0.2,
  );

  static const PosterTextStylePreset emoji = PosterTextStylePreset(
    frameId: 'emoji',
    fontKey: 'emoji',
    fontWeight: 700,
    textColor: Colors.white,
    paddingFactor: 0.02,
  );

  static const List<PosterTextStylePreset> all = [
    plain,
    capsule,
    outline,
    neon,
  ];
}

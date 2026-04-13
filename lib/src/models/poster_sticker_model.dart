import 'dart:ui';
import 'package:flutter/material.dart' show Colors, Color, Offset;

// ─────────────────────────────────────────────────────────────────────────────
// Sticker
// ─────────────────────────────────────────────────────────────────────────────

class PosterStickerModel {
  final String id;
  final String assetUrl;
  final String? text;
  final bool isLocal;
  final bool isText;
  final String? socialPlatform;

  // Text styling
  final String frameId;
  final String fontFamily;
  final double fontSize;
  final bool isBold;
  final bool isItalic;
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

  // Social icon overrides
  final double? socialIconSize;
  final Color? socialIconColor;

  // Transform
  final Offset position;
  final double scale;
  final double rotation;

  const PosterStickerModel({
    required this.id,
    this.assetUrl = '',
    this.text,
    this.isLocal = false,
    this.isText = false,
    this.socialPlatform,
    this.frameId = 'plain',
    this.fontFamily = 'Poppins',
    this.fontSize = 24.0,
    this.isBold = false,
    this.isItalic = false,
    this.fontWeight = 700,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.shadowEnabled = false,
    this.shadowColor = Colors.black,
    this.shadowBlur = 10,
    this.paddingFactor = 0.06,
    this.letterSpacing = 0,
    this.socialIconSize,
    this.socialIconColor,
    this.position = const Offset(200, 200),
    this.scale = 1.0,
    this.rotation = 0.0,
  });

  PosterStickerModel copyWith({
    String? id,
    String? assetUrl,
    String? text,
    bool? isLocal,
    bool? isText,
    String? socialPlatform,
    String? frameId,
    String? fontFamily,
    double? fontSize,
    bool? isBold,
    bool? isItalic,
    int? fontWeight,
    Color? textColor,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    bool? shadowEnabled,
    Color? shadowColor,
    double? shadowBlur,
    double? paddingFactor,
    double? letterSpacing,
    double? socialIconSize,
    Color? socialIconColor,
    Offset? position,
    double? scale,
    double? rotation,
  }) =>
      PosterStickerModel(
        id: id ?? this.id,
        assetUrl: assetUrl ?? this.assetUrl,
        text: text ?? this.text,
        isLocal: isLocal ?? this.isLocal,
        isText: isText ?? this.isText,
        socialPlatform: socialPlatform ?? this.socialPlatform,
        frameId: frameId ?? this.frameId,
        fontFamily: fontFamily ?? this.fontFamily,
        fontSize: fontSize ?? this.fontSize,
        isBold: isBold ?? this.isBold,
        isItalic: isItalic ?? this.isItalic,
        fontWeight: fontWeight ?? this.fontWeight,
        textColor: textColor ?? this.textColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        borderColor: borderColor ?? this.borderColor,
        borderWidth: borderWidth ?? this.borderWidth,
        shadowEnabled: shadowEnabled ?? this.shadowEnabled,
        shadowColor: shadowColor ?? this.shadowColor,
        shadowBlur: shadowBlur ?? this.shadowBlur,
        paddingFactor: paddingFactor ?? this.paddingFactor,
        letterSpacing: letterSpacing ?? this.letterSpacing,
        socialIconSize: socialIconSize ?? this.socialIconSize,
        socialIconColor: socialIconColor ?? this.socialIconColor,
        position: position ?? this.position,
        scale: scale ?? this.scale,
        rotation: rotation ?? this.rotation,
      );

  // ── Presets ───────────────────────────────────────────────────────────────
  factory PosterStickerModel.text({
    required String text,
    String fontFamily = 'Poppins',
    double fontSize = 24,
    Color textColor = Colors.white,
    Color? backgroundColor,
    Offset position = const Offset(200, 200),
    double scale = 1.2,
  }) =>
      PosterStickerModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        isText: true,
        text: text,
        fontFamily: fontFamily,
        fontSize: fontSize,
        textColor: textColor,
        backgroundColor: backgroundColor,
        position: position,
        scale: scale,
      );

  factory PosterStickerModel.capsule({
    required String text,
    Offset position = const Offset(200, 200),
  }) =>
      PosterStickerModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        isText: true,
        text: text,
        frameId: 'capsule',
        fontFamily: 'Poppins',
        fontWeight: 900,
        textColor: Colors.white,
        backgroundColor: const Color(0xFF2F6BFF),
        borderColor: const Color(0x99FFFFFF),
        borderWidth: 1.5,
        shadowEnabled: true,
        shadowColor: const Color(0xAA2F6BFF),
        shadowBlur: 18,
        position: position,
        scale: 1.2,
      );

  factory PosterStickerModel.social({
    required String platform,
    required String handle,
    Offset position = const Offset(200, 200),
  }) =>
      PosterStickerModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        isText: true,
        socialPlatform: platform,
        text: handle,
        frameId: 'capsule',
        fontFamily: 'Poppins',
        fontWeight: 900,
        textColor: Colors.white,
        backgroundColor: const Color(0xFF2F6BFF),
        borderColor: const Color(0x99FFFFFF),
        borderWidth: 1.5,
        shadowEnabled: true,
        shadowColor: const Color(0xAA2F6BFF),
        shadowBlur: 18,
        position: position,
        scale: 1.2,
      );

  factory PosterStickerModel.image({
    required String url,
    bool isLocal = false,
    Offset position = const Offset(200, 200),
    double scale = 1.0,
  }) =>
      PosterStickerModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        assetUrl: url,
        isLocal: isLocal,
        position: position,
        scale: scale,
      );
}

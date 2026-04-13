import 'package:flutter/material.dart';

/// All frame layout types supported by the package.
enum PosterFrameType {
  // Bottom layouts
  wavyProfile,
  modernAngled,
  sleekRibbon,
  cleanBar,
  footerStrip,
  floatingCard,
  saffronPride,
  tricolorStrip,
  rajnetaPremium,
  rajnetaModern,
  rajnetaClassic,
  wavyEdge,
  simpleFull,
  diagonalSlash,
  premiumGlassCard,
  arcReveal,
  centerStage,
  cornerBadge,
  dualTone,
  triColorModern,

  // Top layouts
  wavyProfileTop,
  cleanBarTop,
  floatingCardTop,
  footerStripTop,
  modernAngledTop,
  sleekRibbonTop,
  saffronPrideTop,
  tricolorStripTop,
  rajnetaPremiumTop,
  rajnetaClassicTop,

  // Custom
  custom,
}

/// Represents a frame overlay with all its colors.
/// Use factory constructors for quick setup with sensible defaults.
class PosterFrameModel {
  final String id;
  final String displayName;
  final PosterFrameType type;

  // Colors used by layouts
  final Color backgroundColor;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color textColor; // general text / overlay text
  final Color textColor1; // name
  final Color textColor2; // designation
  final Color canvasBackground;

  // Font sizes (responsive base, scaled by canvas width / 400)
  final double nameFontSize;
  final double designationFontSize;

  // Font families
  final String nameFontFamily;
  final String designationFontFamily;

  const PosterFrameModel({
    required this.id,
    required this.displayName,
    required this.type,
    this.backgroundColor = const Color(0xFFFF9933),
    this.color1 = Colors.white,
    this.color2 = const Color(0xFFFF9933),
    this.color3 = const Color(0xFF128807),
    this.textColor = Colors.white,
    this.textColor1 = Colors.white,
    this.textColor2 = const Color(0xFFFFFF00),
    this.canvasBackground = const Color(0xFFF8F9FA),
    this.nameFontSize = 22.0,
    this.designationFontSize = 14.0,
    this.nameFontFamily = 'Poppins',
    this.designationFontFamily = 'Poppins',
  });

  String get registryKey => type == PosterFrameType.custom ? id : type.name;

  PosterFrameModel copyWith({
    String? id,
    String? displayName,
    PosterFrameType? type,
    Color? backgroundColor,
    Color? color1,
    Color? color2,
    Color? color3,
    Color? textColor,
    Color? textColor1,
    Color? textColor2,
    Color? canvasBackground,
    double? nameFontSize,
    double? designationFontSize,
    String? nameFontFamily,
    String? designationFontFamily,
  }) {
    return PosterFrameModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      type: type ?? this.type,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      color1: color1 ?? this.color1,
      color2: color2 ?? this.color2,
      color3: color3 ?? this.color3,
      textColor: textColor ?? this.textColor,
      textColor1: textColor1 ?? this.textColor1,
      textColor2: textColor2 ?? this.textColor2,
      canvasBackground: canvasBackground ?? this.canvasBackground,
      nameFontSize: nameFontSize ?? this.nameFontSize,
      designationFontSize: designationFontSize ?? this.designationFontSize,
      nameFontFamily: nameFontFamily ?? this.nameFontFamily,
      designationFontFamily:
          designationFontFamily ?? this.designationFontFamily,
    );
  }

  // ── All built-in frames ───────────────────────────────────────────────────

  static List<PosterFrameModel> get allFrames => [
    PosterFrameModel.wavyProfile(),
    PosterFrameModel.modernAngled(),
    PosterFrameModel.sleekRibbon(),
    PosterFrameModel.cleanBar(),
    PosterFrameModel.footerStrip(),
    PosterFrameModel.floatingCard(),
    PosterFrameModel.saffronPride(),
    PosterFrameModel.tricolorStrip(),
    PosterFrameModel.rajnetaPremium(),
    PosterFrameModel.rajnetaModern(),
    PosterFrameModel.rajnetaClassic(),
    PosterFrameModel.wavyEdge(),
    PosterFrameModel.simpleFull(),
    PosterFrameModel.diagonalSlash(),
    PosterFrameModel.premiumGlassCard(),
    PosterFrameModel.arcReveal(),
    PosterFrameModel.centerStage(),
    PosterFrameModel.cornerBadge(),
    PosterFrameModel.dualTone(),
    PosterFrameModel.triColorModern(),
    PosterFrameModel.wavyProfileTop(),
    PosterFrameModel.cleanBarTop(),
    PosterFrameModel.floatingCardTop(),
    PosterFrameModel.footerStripTop(),
    PosterFrameModel.modernAngledTop(),
    PosterFrameModel.sleekRibbonTop(),
    PosterFrameModel.saffronPrideTop(),
    PosterFrameModel.tricolorStripTop(),
    PosterFrameModel.rajnetaPremiumTop(),
    PosterFrameModel.rajnetaClassicTop(),
  ];

  // ── Factory constructors ──────────────────────────────────────────────────

  factory PosterFrameModel.wavyProfile() => const PosterFrameModel(
    id: 'wavyProfile',
    displayName: 'Wavy Profile',
    type: PosterFrameType.wavyProfile,
    backgroundColor: Color(0xFFFF9933),
    textColor1: Colors.white,
    textColor2: Color(0xFFFFFF00),
    nameFontSize: 22,
    designationFontSize: 14,
  );

  factory PosterFrameModel.modernAngled() => const PosterFrameModel(
    id: 'modernAngled',
    displayName: 'Modern Angled',
    type: PosterFrameType.modernAngled,
    backgroundColor: Color(0xFFFF9933),
    color1: Color(0xFFFFFF00),
    textColor: Colors.white,
    textColor1: Colors.black,
    textColor2: Colors.white,
    nameFontSize: 20,
    designationFontSize: 14,
  );

  factory PosterFrameModel.sleekRibbon() => const PosterFrameModel(
    id: 'sleekRibbon',
    displayName: 'Sleek Ribbon',
    type: PosterFrameType.sleekRibbon,
    backgroundColor: Color(0xFFFF9933),
    color1: Color(0xFFFFFF00),
    textColor: Colors.white,
    textColor1: Colors.black,
    textColor2: Colors.white,
    nameFontSize: 20,
    designationFontSize: 14,
  );

  factory PosterFrameModel.cleanBar() => const PosterFrameModel(
    id: 'cleanBar',
    displayName: 'Clean Bar',
    type: PosterFrameType.cleanBar,
    backgroundColor: Color(0xFFFF9933),
    color1: Colors.white,
    textColor1: Color(0xFFFF9933),
    textColor2: Colors.white,
    nameFontSize: 18,
    designationFontSize: 14,
  );

  factory PosterFrameModel.footerStrip() => const PosterFrameModel(
    id: 'footerStrip',
    displayName: 'Footer Strip',
    type: PosterFrameType.footerStrip,
    color1: Colors.white,
    color2: Color(0xFFFF9933),
    textColor1: Color(0xFFFF9933),
    textColor2: Colors.black,
    nameFontSize: 20,
    designationFontSize: 12,
  );

  factory PosterFrameModel.floatingCard() => const PosterFrameModel(
    id: 'floatingCard',
    displayName: 'Floating Card',
    type: PosterFrameType.floatingCard,
    color1: Colors.white,
    textColor1: Colors.black,
    textColor2: Color(0xFF212121),
    nameFontSize: 20,
    designationFontSize: 12,
  );

  factory PosterFrameModel.saffronPride() => const PosterFrameModel(
    id: 'saffronPride',
    displayName: 'Saffron Pride',
    type: PosterFrameType.saffronPride,
    color1: Color(0xFFFFB74D),
    color2: Color(0xFFFF9933),
    textColor1: Colors.white,
    textColor2: Colors.white,
    nameFontSize: 24,
    designationFontSize: 14,
  );

  factory PosterFrameModel.tricolorStrip() => const PosterFrameModel(
    id: 'tricolorStrip',
    displayName: 'Tricolor Strip',
    type: PosterFrameType.tricolorStrip,
    color1: Color(0xFFFF9933),
    color2: Colors.white,
    color3: Color(0xFF128807),
    textColor1: Colors.black,
    nameFontSize: 16,
  );

  factory PosterFrameModel.rajnetaPremium() => const PosterFrameModel(
    id: 'rajnetaPremium',
    displayName: 'Rajneta Premium',
    type: PosterFrameType.rajnetaPremium,
    color1: Colors.white,
    color2: Color(0xFFFF9933),
    textColor1: Color(0xFFFF9933),
    textColor2: Colors.black,
    nameFontSize: 30,
    designationFontSize: 16,
  );

  factory PosterFrameModel.rajnetaModern() => const PosterFrameModel(
    id: 'rajnetaModern',
    displayName: 'Rajneta Modern',
    type: PosterFrameType.rajnetaModern,
    color1: Color(0xFFFF9933),
    textColor1: Colors.white,
    textColor2: Colors.white,
    nameFontSize: 28,
    designationFontSize: 16,
  );

  factory PosterFrameModel.rajnetaClassic() => const PosterFrameModel(
    id: 'rajnetaClassic',
    displayName: 'Rajneta Classic',
    type: PosterFrameType.rajnetaClassic,
    color1: Color(0xFFFF9933),
    textColor1: Colors.white,
    textColor2: Colors.white,
    nameFontSize: 26,
    designationFontSize: 15,
  );

  factory PosterFrameModel.wavyEdge() => const PosterFrameModel(
    id: 'wavyEdge',
    displayName: 'Wavy Edge',
    type: PosterFrameType.wavyEdge,
    color1: Color(0xFFFF9933),
    textColor1: Colors.white,
    textColor2: Color(0xFFFFFF00),
    nameFontSize: 22,
    designationFontSize: 14,
  );

  factory PosterFrameModel.simpleFull() => const PosterFrameModel(
    id: 'simpleFull',
    displayName: 'Simple Full',
    type: PosterFrameType.simpleFull,
    color1: Color(0xFFFF9933),
    color2: Color(0xFF128807),
    textColor1: Colors.white,
    textColor2: Colors.white,
    nameFontSize: 28,
    designationFontSize: 16,
  );

  factory PosterFrameModel.diagonalSlash() => const PosterFrameModel(
    id: 'diagonalSlash',
    displayName: 'Diagonal Slash',
    type: PosterFrameType.diagonalSlash,
    color1: Color(0xFFFF9933),
    color2: Color(0xFFFF6600),
    textColor1: Colors.white,
    textColor2: Color(0xFFFFE0B2),
    nameFontSize: 22,
    designationFontSize: 13,
  );

  factory PosterFrameModel.premiumGlassCard() => const PosterFrameModel(
    id: 'premiumGlassCard',
    displayName: 'Glass Card',
    type: PosterFrameType.premiumGlassCard,
    color1: Color(0xFFFF9933),
    color2: Color(0xFFFF6600),
    textColor1: Colors.white,
    textColor2: Color(0xFFFFE0B2),
    nameFontSize: 20,
    designationFontSize: 13,
  );

  factory PosterFrameModel.arcReveal() => const PosterFrameModel(
    id: 'arcReveal',
    displayName: 'Arc Reveal',
    type: PosterFrameType.arcReveal,
    color1: Color(0xFFFF9933),
    color2: Color(0xFFFFB74D),
    textColor1: Colors.white,
    textColor2: Color(0xFFFFE0B2),
    nameFontSize: 22,
    designationFontSize: 13,
  );

  factory PosterFrameModel.centerStage() => const PosterFrameModel(
    id: 'centerStage',
    displayName: 'Center Stage',
    type: PosterFrameType.centerStage,
    color1: Color(0xFF1a1a2e),
    color2: Color(0xFFFF9933),
    textColor1: Colors.white,
    textColor2: Color(0xFFFFE0B2),
    nameFontSize: 24,
    designationFontSize: 14,
  );

  factory PosterFrameModel.cornerBadge() => const PosterFrameModel(
    id: 'cornerBadge',
    displayName: 'Corner Badge',
    type: PosterFrameType.cornerBadge,
    color1: Color(0xFFFF9933),
    color2: Color(0xFF128807),
    textColor1: Colors.white,
    textColor2: Colors.white,
    nameFontSize: 20,
    designationFontSize: 12,
  );

  factory PosterFrameModel.dualTone() => const PosterFrameModel(
    id: 'dualTone',
    displayName: 'Dual Tone',
    type: PosterFrameType.dualTone,
    color1: Color(0xFFFF9933),
    color2: Color(0xFF128807),
    textColor1: Colors.white,
    textColor2: Colors.white,
    nameFontSize: 22,
    designationFontSize: 13,
  );

  factory PosterFrameModel.triColorModern() => const PosterFrameModel(
    id: 'triColorModern',
    displayName: 'Tri Color Modern',
    type: PosterFrameType.triColorModern,
    color1: Color(0xFFFF9933),
    color2: Color(0xFF128807),
    textColor1: Colors.white,
    textColor2: Colors.white,
    nameFontSize: 22,
    designationFontSize: 13,
  );

  // Top variants
  factory PosterFrameModel.wavyProfileTop() => const PosterFrameModel(
    id: 'wavyProfileTop',
    displayName: 'Wavy (Top)',
    type: PosterFrameType.wavyProfileTop,
    backgroundColor: Color(0xFFFF9933),
    textColor1: Colors.white,
    textColor2: Color(0xFFFFFF00),
    nameFontSize: 22,
    designationFontSize: 14,
  );

  factory PosterFrameModel.cleanBarTop() => const PosterFrameModel(
    id: 'cleanBarTop',
    displayName: 'Clean Bar (Top)',
    type: PosterFrameType.cleanBarTop,
    backgroundColor: Color(0xFFFF9933),
    color1: Colors.white,
    textColor1: Color(0xFFFF9933),
    textColor2: Colors.white,
    nameFontSize: 18,
    designationFontSize: 14,
  );

  factory PosterFrameModel.floatingCardTop() => const PosterFrameModel(
    id: 'floatingCardTop',
    displayName: 'Floating Card (Top)',
    type: PosterFrameType.floatingCardTop,
    color1: Colors.white,
    textColor1: Colors.black,
    textColor2: Color(0xFF212121),
    nameFontSize: 20,
    designationFontSize: 12,
  );

  factory PosterFrameModel.footerStripTop() => const PosterFrameModel(
    id: 'footerStripTop',
    displayName: 'Footer Strip (Top)',
    type: PosterFrameType.footerStripTop,
    color1: Colors.white,
    color2: Color(0xFFFF9933),
    textColor1: Color(0xFFFF9933),
    textColor2: Colors.black,
    nameFontSize: 20,
    designationFontSize: 12,
  );

  factory PosterFrameModel.modernAngledTop() => const PosterFrameModel(
    id: 'modernAngledTop',
    displayName: 'Angled (Top)',
    type: PosterFrameType.modernAngledTop,
    backgroundColor: Color(0xFFFF9933),
    color1: Color(0xFFFFFF00),
    textColor: Colors.white,
    textColor1: Colors.black,
    nameFontSize: 20,
    designationFontSize: 14,
  );

  factory PosterFrameModel.sleekRibbonTop() => const PosterFrameModel(
    id: 'sleekRibbonTop',
    displayName: 'Ribbon (Top)',
    type: PosterFrameType.sleekRibbonTop,
    backgroundColor: Color(0xFFFF9933),
    color1: Color(0xFFFFFF00),
    textColor: Colors.white,
    textColor1: Colors.black,
    nameFontSize: 20,
    designationFontSize: 14,
  );

  factory PosterFrameModel.saffronPrideTop() => const PosterFrameModel(
    id: 'saffronPrideTop',
    displayName: 'Saffron (Top)',
    type: PosterFrameType.saffronPrideTop,
    color1: Color(0xFFFFB74D),
    color2: Color(0xFFFF9933),
    textColor1: Colors.white,
    textColor2: Colors.white,
    nameFontSize: 24,
    designationFontSize: 14,
  );

  factory PosterFrameModel.tricolorStripTop() => const PosterFrameModel(
    id: 'tricolorStripTop',
    displayName: 'Tricolor (Top)',
    type: PosterFrameType.tricolorStripTop,
    color1: Color(0xFFFF9933),
    color2: Colors.white,
    color3: Color(0xFF128807),
    textColor1: Colors.black,
    nameFontSize: 16,
  );

  factory PosterFrameModel.rajnetaPremiumTop() => const PosterFrameModel(
    id: 'rajnetaPremiumTop',
    displayName: 'Premium (Top)',
    type: PosterFrameType.rajnetaPremiumTop,
    color1: Colors.white,
    color2: Color(0xFFFF9933),
    textColor1: Color(0xFFFF9933),
    textColor2: Colors.black,
    nameFontSize: 30,
    designationFontSize: 16,
  );

  factory PosterFrameModel.rajnetaClassicTop() => const PosterFrameModel(
    id: 'rajnetaClassicTop',
    displayName: 'Classic (Top)',
    type: PosterFrameType.rajnetaClassicTop,
    color1: Color(0xFFFF9933),
    textColor1: Colors.white,
    textColor2: Colors.white,
    nameFontSize: 26,
    designationFontSize: 15,
  );
}

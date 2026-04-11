import 'package:flutter/material.dart';

/// Identifies which layout algorithm renders this frame.
///
/// Custom layouts can be registered via [PosterLayoutRegistry.register].
enum PosterFrameType {
  // ── Bottom layouts ──────────────────────────────────────────────────────
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

  // ── Top layouts ─────────────────────────────────────────────────────────
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

  /// Use this when you register a completely custom layout.
  custom,
}

/// All color & styling data for a frame.
///
/// Factory constructors provide sensible defaults for every built-in style.
/// You can override any value via [copyWith].
class PosterFrame {
  final PosterFrameType type;

  /// A unique string key used when [type] == [PosterFrameType.custom].
  final String? customKey;

  // ── Colors ────────────────────────────────────────────────────────────────
  final Color backgroundColor;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color textColor1;
  final Color textColor2;

  // ── Human-readable name shown in UI pickers ─────────────────────────────
  final String displayName;

  const PosterFrame({
    required this.type,
    this.customKey,
    required this.backgroundColor,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.textColor1,
    required this.textColor2,
    required this.displayName,
  });

  // ─────────────────────────────────────────────────────────────────────────
  // Factory constructors — one per built-in frame
  // ─────────────────────────────────────────────────────────────────────────

  factory PosterFrame.wavyProfile({
    Color backgroundColor = const Color(0xFFFF9933),
    Color textColor1 = Colors.white,
    Color textColor2 = const Color(0xFFFFFF00),
  }) =>
      PosterFrame(
        type: PosterFrameType.wavyProfile,
        displayName: 'Wavy Profile',
        backgroundColor: backgroundColor,
        color1: backgroundColor,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.modernAngled({
    Color backgroundColor = const Color(0xFFFF9933),
    Color color1 = const Color(0xFFFFFF00),
    Color textColor = Colors.white,
    Color textColor1 = Colors.black,
  }) =>
      PosterFrame(
        type: PosterFrameType.modernAngled,
        displayName: 'Modern Angled',
        backgroundColor: backgroundColor,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor,
      );

  factory PosterFrame.sleekRibbon({
    Color backgroundColor = const Color(0xFFFF9933),
    Color color1 = const Color(0xFFFFFF00),
    Color textColor = Colors.white,
    Color textColor1 = Colors.black,
  }) =>
      PosterFrame(
        type: PosterFrameType.sleekRibbon,
        displayName: 'Sleek Ribbon',
        backgroundColor: backgroundColor,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor,
      );

  factory PosterFrame.cleanBar({
    Color color1 = Colors.white,
    Color backgroundColor = const Color(0xFFFF9933),
    Color textColor1 = const Color(0xFFFF9933),
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.cleanBar,
        displayName: 'Clean Bar',
        backgroundColor: backgroundColor,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.footerStrip({
    Color color1 = Colors.white,
    Color color2 = const Color(0xFFFF9933),
    Color textColor1 = const Color(0xFFFF9933),
    Color textColor2 = Colors.black,
  }) =>
      PosterFrame(
        type: PosterFrameType.footerStrip,
        displayName: 'Footer Strip',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.floatingCard({
    Color color1 = Colors.white,
    Color textColor1 = Colors.black,
    Color textColor2 = const Color(0xFF212121),
  }) =>
      PosterFrame(
        type: PosterFrameType.floatingCard,
        displayName: 'Floating Card',
        backgroundColor: color1,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.saffronPride({
    Color color1 = const Color(0xFFFFB74D),
    Color color2 = const Color(0xFFFF9933),
    Color textColor1 = Colors.white,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.saffronPride,
        displayName: 'Saffron Pride',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.tricolorStrip({
    Color color1 = const Color(0xFFFF9933),
    Color color2 = Colors.white,
    Color color3 = const Color(0xFF128807),
    Color textColor1 = Colors.black,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.tricolorStrip,
        displayName: 'Tricolor Strip',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: color3,
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.rajnetaPremium({
    Color color1 = Colors.white,
    Color color2 = const Color(0xFFFF9933),
    Color textColor1 = const Color(0xFFFF9933),
    Color textColor2 = Colors.black,
  }) =>
      PosterFrame(
        type: PosterFrameType.rajnetaPremium,
        displayName: 'Rajneta Premium',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.rajnetaModern({
    Color color1 = const Color(0xFFFF9933),
    Color textColor1 = Colors.white,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.rajnetaModern,
        displayName: 'Rajneta Modern',
        backgroundColor: color1,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.rajnetaClassic({
    Color color1 = const Color(0xFFFF9933),
    Color textColor1 = Colors.white,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.rajnetaClassic,
        displayName: 'Rajneta Classic',
        backgroundColor: color1,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.wavyEdge({
    Color color1 = const Color(0xFFFF9933),
    Color textColor1 = Colors.white,
    Color textColor2 = const Color(0xFFFFFF00),
  }) =>
      PosterFrame(
        type: PosterFrameType.wavyEdge,
        displayName: 'Wavy Edge',
        backgroundColor: color1,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.simpleFull({
    Color color1 = const Color(0xFFFF9933),
    Color color2 = const Color(0xFF128807),
    Color textColor1 = Colors.white,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.simpleFull,
        displayName: 'Simple Full',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.diagonalSlash({
    Color color1 = const Color(0xFFFF9933),
    Color color2 = const Color(0xFFFF6600),
    Color textColor1 = Colors.white,
    Color textColor2 = const Color(0xFFFFE0B2),
  }) =>
      PosterFrame(
        type: PosterFrameType.diagonalSlash,
        displayName: 'Diagonal Slash',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.premiumGlassCard({
    Color color1 = const Color(0xFFFF9933),
    Color color2 = const Color(0xFFFF6600),
    Color textColor1 = Colors.white,
    Color textColor2 = const Color(0xFFFFE0B2),
  }) =>
      PosterFrame(
        type: PosterFrameType.premiumGlassCard,
        displayName: 'Premium Glass Card',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.arcReveal({
    Color color1 = const Color(0xFFFF9933),
    Color color2 = const Color(0xFFFFB74D),
    Color textColor1 = Colors.white,
    Color textColor2 = const Color(0xFFFFE0B2),
  }) =>
      PosterFrame(
        type: PosterFrameType.arcReveal,
        displayName: 'Arc Reveal',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.centerStage({
    Color color1 = const Color(0xFF1a1a2e),
    Color color2 = const Color(0xFFFF9933),
    Color textColor1 = Colors.white,
    Color textColor2 = const Color(0xFFFFE0B2),
  }) =>
      PosterFrame(
        type: PosterFrameType.centerStage,
        displayName: 'Center Stage',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.cornerBadge({
    Color color1 = const Color(0xFFFF9933),
    Color color2 = const Color(0xFF128807),
    Color textColor1 = Colors.white,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.cornerBadge,
        displayName: 'Corner Badge',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: color2,
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.dualTone({
    Color color1 = const Color(0xFFFF9933),
    Color color2 = const Color(0xFF128807),
    Color textColor1 = Colors.white,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.dualTone,
        displayName: 'Dual Tone',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: color2,
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.triColorModern({
    Color color1 = const Color(0xFFFF9933),
    Color color2 = const Color(0xFF128807),
    Color textColor1 = Colors.white,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.triColorModern,
        displayName: 'Tri Color Modern',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: color2,
        textColor1: textColor1,
        textColor2: textColor2,
      );

  // ── Top variants ────────────────────────────────────────────────────────
  factory PosterFrame.wavyProfileTop({
    Color backgroundColor = const Color(0xFFFF9933),
    Color textColor1 = Colors.white,
    Color textColor2 = const Color(0xFFFFFF00),
  }) =>
      PosterFrame(
        type: PosterFrameType.wavyProfileTop,
        displayName: 'Wavy Profile (Top)',
        backgroundColor: backgroundColor,
        color1: backgroundColor,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.cleanBarTop({
    Color color1 = Colors.white,
    Color backgroundColor = const Color(0xFFFF9933),
    Color textColor1 = const Color(0xFFFF9933),
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.cleanBarTop,
        displayName: 'Clean Bar (Top)',
        backgroundColor: backgroundColor,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.floatingCardTop({
    Color color1 = Colors.white,
    Color textColor1 = Colors.black,
    Color textColor2 = const Color(0xFF212121),
  }) =>
      PosterFrame(
        type: PosterFrameType.floatingCardTop,
        displayName: 'Floating Card (Top)',
        backgroundColor: color1,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.footerStripTop({
    Color color1 = Colors.white,
    Color color2 = const Color(0xFFFF9933),
    Color textColor1 = const Color(0xFFFF9933),
    Color textColor2 = Colors.black,
  }) =>
      PosterFrame(
        type: PosterFrameType.footerStripTop,
        displayName: 'Footer Strip (Top)',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.rajnetaPremiumTop({
    Color color1 = Colors.white,
    Color color2 = const Color(0xFFFF9933),
    Color textColor1 = const Color(0xFFFF9933),
    Color textColor2 = Colors.black,
  }) =>
      PosterFrame(
        type: PosterFrameType.rajnetaPremiumTop,
        displayName: 'Rajneta Premium (Top)',
        backgroundColor: color1,
        color1: color1,
        color2: color2,
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  factory PosterFrame.rajnetaClassicTop({
    Color color1 = const Color(0xFFFF9933),
    Color textColor1 = Colors.white,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.rajnetaClassicTop,
        displayName: 'Rajneta Classic (Top)',
        backgroundColor: color1,
        color1: color1,
        color2: const Color(0xFFFF9933),
        color3: const Color(0xFF128807),
        textColor1: textColor1,
        textColor2: textColor2,
      );

  // ── Custom frame ─────────────────────────────────────────────────────────
  factory PosterFrame.custom({
    required String key,
    required String displayName,
    Color backgroundColor = const Color(0xFFFF9933),
    Color color1 = Colors.white,
    Color color2 = const Color(0xFFFF9933),
    Color color3 = const Color(0xFF128807),
    Color textColor1 = Colors.white,
    Color textColor2 = Colors.white,
  }) =>
      PosterFrame(
        type: PosterFrameType.custom,
        customKey: key,
        displayName: displayName,
        backgroundColor: backgroundColor,
        color1: color1,
        color2: color2,
        color3: color3,
        textColor1: textColor1,
        textColor2: textColor2,
      );

  // ─────────────────────────────────────────────────────────────────────────

  PosterFrame copyWith({
    PosterFrameType? type,
    String? customKey,
    Color? backgroundColor,
    Color? color1,
    Color? color2,
    Color? color3,
    Color? textColor1,
    Color? textColor2,
    String? displayName,
  }) {
    return PosterFrame(
      type: type ?? this.type,
      customKey: customKey ?? this.customKey,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      color1: color1 ?? this.color1,
      color2: color2 ?? this.color2,
      color3: color3 ?? this.color3,
      textColor1: textColor1 ?? this.textColor1,
      textColor2: textColor2 ?? this.textColor2,
      displayName: displayName ?? this.displayName,
    );
  }

  /// Convenience: resolve the registry key string used by [PosterLayoutRegistry].
  String get registryKey =>
      type == PosterFrameType.custom ? (customKey ?? 'custom') : type.name;

  /// All built-in frames as a list (useful for pickers).
  static List<PosterFrame> get allFrames => [
        PosterFrame.wavyProfile(),
        PosterFrame.modernAngled(),
        PosterFrame.sleekRibbon(),
        PosterFrame.cleanBar(),
        PosterFrame.footerStrip(),
        PosterFrame.floatingCard(),
        PosterFrame.saffronPride(),
        PosterFrame.tricolorStrip(),
        PosterFrame.rajnetaPremium(),
        PosterFrame.rajnetaModern(),
        PosterFrame.rajnetaClassic(),
        PosterFrame.wavyEdge(),
        PosterFrame.simpleFull(),
        PosterFrame.diagonalSlash(),
        PosterFrame.premiumGlassCard(),
        PosterFrame.arcReveal(),
        PosterFrame.centerStage(),
        PosterFrame.cornerBadge(),
        PosterFrame.dualTone(),
        PosterFrame.triColorModern(),
        PosterFrame.wavyProfileTop(),
        PosterFrame.cleanBarTop(),
        PosterFrame.floatingCardTop(),
        PosterFrame.footerStripTop(),
        PosterFrame.rajnetaPremiumTop(),
        PosterFrame.rajnetaClassicTop(),
      ];
}

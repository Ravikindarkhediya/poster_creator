import 'package:flutter/material.dart';
import '../models/poster_config.dart';
import '../models/poster_frame.dart';
import 'base_poster_layout.dart';
import '../painter/poster_clippers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// WAVY PROFILE
// ─────────────────────────────────────────────────────────────────────────────

class WavyProfileLayout extends BasePosterLayout {
  const WavyProfileLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: canvasWidth * 0.25,
          child: ClipPath(
            clipper: WavyProfileClipper(),
            child: Container(
              color: frame.backgroundColor,
              padding: EdgeInsets.only(
                left: canvasWidth * 0.28,
                right: canvasWidth * 0.05,
                top: canvasWidth * 0.04,
                bottom: canvasWidth * 0.02,
              ),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  styledText(config.userName, config, canvasWidth,
                      bold: true, color: frame.textColor1),
                  styledText(config.designation, config, canvasWidth,
                      isDesignation: true, bold: true, color: frame.textColor2),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.05,
          left: canvasWidth * 0.05,
          child: buildAvatar(config,
              radius: canvasWidth * 0.1,
              border: true,
              borderColor: Colors.white,
              shadow: true),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MODERN ANGLED
// ─────────────────────────────────────────────────────────────────────────────

class ModernAngledLayout extends BasePosterLayout {
  const ModernAngledLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Stack(
      children: [
        Positioned(
          bottom: canvasWidth * 0.12,
          left: canvasWidth * 0.15,
          right: canvasWidth * 0.05,
          height: canvasWidth * 0.1,
          child: ClipPath(
            clipper: ModernAngledBannerClipper(),
            child: Container(
              color: frame.backgroundColor,
              padding: EdgeInsets.only(
                  left: canvasWidth * 0.11, right: canvasWidth * 0.05),
              alignment: Alignment.centerLeft,
              child: styledText(config.userName, config, canvasWidth,
                  bold: true, color: frame.textColor2, shadow: true),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.05,
          left: canvasWidth * 0.20,
          height: canvasWidth * 0.07,
          child: ClipPath(
            clipper: ModernAngledTagClipper(),
            child: Container(
              color: frame.color1,
              padding:
                  EdgeInsets.symmetric(horizontal: canvasWidth * 0.06),
              alignment: Alignment.center,
              child: styledText(config.designation, config, canvasWidth,
                  isDesignation: true, bold: true, color: frame.textColor1),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.04,
          left: canvasWidth * 0.05,
          child: buildAvatar(config,
              radius: canvasWidth * 0.1,
              border: true,
              borderColor: Colors.white,
              shadow: true),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SLEEK RIBBON
// ─────────────────────────────────────────────────────────────────────────────

class SleekRibbonLayout extends BasePosterLayout {
  const SleekRibbonLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Stack(
      children: [
        Positioned(
          bottom: canvasWidth * 0.1,
          left: canvasWidth * 0.25,
          right: canvasWidth * 0.05,
          height: canvasWidth * 0.12,
          child: ClipPath(
            clipper: SleekRibbonClipper(),
            child: Container(
              color: frame.backgroundColor,
              padding: EdgeInsets.only(
                  left: canvasWidth * 0.07, right: canvasWidth * 0.1),
              alignment: Alignment.centerLeft,
              child: styledText(config.userName, config, canvasWidth,
                  bold: true, color: frame.textColor2, shadow: true),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.04,
          left: canvasWidth * 0.24,
          right: canvasWidth * 0.15,
          height: canvasWidth * 0.07,
          child: ClipPath(
            clipper: SleekRibbonClipper(),
            child: Container(
              color: frame.color1,
              padding: EdgeInsets.only(
                  left: canvasWidth * 0.08, right: canvasWidth * 0.08),
              alignment: Alignment.centerLeft,
              child: styledText(config.designation, config, canvasWidth,
                  isDesignation: true, bold: true, color: frame.textColor1),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.02,
          left: canvasWidth * 0.08,
          child: buildAvatar(config,
              radius: canvasWidth * 0.11,
              border: true,
              borderColor: Colors.white,
              shadow: true),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CLEAN BAR
// ─────────────────────────────────────────────────────────────────────────────

class CleanBarLayout extends BasePosterLayout {
  const CleanBarLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: canvasWidth * 0.22,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: frame.color1,
                  padding:
                      EdgeInsets.only(left: canvasWidth * 0.32),
                  alignment: Alignment.centerLeft,
                  child: styledText(config.userName, config, canvasWidth,
                      bold: true, color: frame.textColor1),
                ),
              ),
              Expanded(
                child: Container(
                  color: frame.backgroundColor,
                  padding:
                      EdgeInsets.only(left: canvasWidth * 0.32),
                  alignment: Alignment.centerLeft,
                  child: styledText(config.designation, config, canvasWidth,
                      isDesignation: true, bold: true, color: frame.textColor2),
                ),
              ),
            ],
          ),
          Positioned(
            left: canvasWidth * 0.05,
            bottom: canvasWidth * 0.04,
            child: buildAvatar(config,
                radius: canvasWidth * 0.11,
                border: true,
                borderColor: Colors.white,
                shadow: true),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FOOTER STRIP
// ─────────────────────────────────────────────────────────────────────────────

class FooterStripLayout extends BasePosterLayout {
  const FooterStripLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    final double avatarRadius = canvasWidth * 0.12;
    final double avatarLeft = canvasWidth * 0.06;
    final double stripHeight = canvasWidth * 0.18;
    final double avatarCenterX = avatarLeft + avatarRadius;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: stripHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: NotchClipper(
                avatarRadius: avatarRadius, centerX: avatarCenterX),
            child: Container(
              height: stripHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [frame.color1, frame.color2]),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, -3))
                ],
              ),
              padding: EdgeInsets.only(
                left:
                    avatarLeft + (avatarRadius * 2) + canvasWidth * 0.05,
                right: canvasWidth * 0.05,
                bottom: canvasWidth * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  styledText(config.userName, config, canvasWidth,
                      bold: true, color: frame.textColor1),
                  SizedBox(height: canvasWidth * 0.01),
                  styledText(config.designation, config, canvasWidth,
                      isDesignation: true, color: frame.textColor2),
                ],
              ),
            ),
          ),
          Positioned(
            left: avatarLeft,
            top: -avatarRadius * 1,
            child: buildAvatar(config,
                radius: avatarRadius,
                border: true,
                borderColor: Colors.white,
                shadow: true),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FLOATING CARD
// ─────────────────────────────────────────────────────────────────────────────

class FloatingCardLayout extends BasePosterLayout {
  const FloatingCardLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Positioned(
      bottom: canvasWidth * 0.05,
      left: canvasWidth * 0.05,
      right: canvasWidth * 0.05,
      child: Container(
        padding: EdgeInsets.all(canvasWidth * 0.03),
        decoration: BoxDecoration(
          color: frame.color1.withOpacity(0.8),
          borderRadius: BorderRadius.circular(canvasWidth * 0.05),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1), blurRadius: 15)
          ],
        ),
        child: Row(
          children: [
            buildAvatar(config,
                radius: canvasWidth * 0.08,
                border: true,
                borderColor: frame.color1),
            SizedBox(width: canvasWidth * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  styledText(config.userName, config, canvasWidth,
                      bold: true, color: frame.textColor1),
                  styledText(config.designation, config, canvasWidth,
                      isDesignation: true, color: frame.textColor2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SAFFRON PRIDE
// ─────────────────────────────────────────────────────────────────────────────

class SaffronPrideLayout extends BasePosterLayout {
  const SaffronPrideLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    final double bannerHeight = canvasWidth * 0.23;
    final double avatarRadius = canvasWidth * 0.1;
    final double avatarLeft = canvasWidth * 0.06;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: bannerHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [frame.color1, frame.color2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
          ),
          Positioned(
            left: avatarLeft + avatarRadius * 2 + canvasWidth * 0.05,
            right: canvasWidth * 0.06,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  styledText(config.userName, config, canvasWidth,
                      bold: true, color: frame.textColor1, shadow: true),
                  SizedBox(height: canvasWidth * 0.01),
                  styledText(config.designation, config, canvasWidth,
                      isDesignation: true,
                      color: frame.textColor2,
                      shadow: true),
                ],
              ),
            ),
          ),
          Positioned(
            left: avatarLeft,
            top: bannerHeight / 2 - avatarRadius,
            child: buildAvatar(config,
                radius: avatarRadius,
                border: true,
                borderColor: Colors.white,
                shadow: false),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TRICOLOR STRIP
// ─────────────────────────────────────────────────────────────────────────────

class TricolorStripLayout extends BasePosterLayout {
  const TricolorStripLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: canvasWidth * 0.2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Container(height: canvasWidth * 0.06, color: frame.color1),
              Container(
                height: canvasWidth * 0.08,
                color: frame.color2,
                alignment: Alignment.center,
                child: styledText(config.userName, config, canvasWidth,
                    bold: true, color: frame.textColor1),
              ),
              Container(height: canvasWidth * 0.06, color: frame.color3),
            ],
          ),
          Positioned(
            left: canvasWidth * 0.05,
            bottom: canvasWidth * 0.03,
            child: buildAvatar(config,
                radius: canvasWidth * 0.1,
                border: true,
                borderColor: Colors.white,
                shadow: true),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RAJNETA PREMIUM
// ─────────────────────────────────────────────────────────────────────────────

class RajnetaPremiumLayout extends BasePosterLayout {
  const RajnetaPremiumLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Stack(
      children: [
        Positioned(
          bottom: canvasWidth * 0.01,
          left: 0,
          right: 0,
          height: canvasWidth * 0.23,
          child: Container(
            decoration: BoxDecoration(
              color: frame.color1,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 25,
                    offset: const Offset(0, -5))
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 4,
                    child: Container(color: frame.color2)),
                Padding(
                  padding: EdgeInsets.only(
                      left: canvasWidth * 0.30,
                      right: canvasWidth * 0.06,
                      bottom: canvasWidth * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      styledText(config.userName, config, canvasWidth,
                          bold: true,
                          color: frame.textColor1,
                          shadow: true,
                          shadowBlur: 12),
                      SizedBox(height: canvasWidth * 0.005),
                      styledText(config.designation, config, canvasWidth,
                          isDesignation: true,
                          color: frame.textColor2,
                          letterSpacing: 0.8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.08,
          left: canvasWidth * 0.05,
          child: buildAvatar(config,
              radius: canvasWidth * 0.1,
              border: true,
              borderColor: Colors.white,
              shadow: true),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RAJNETA MODERN
// ─────────────────────────────────────────────────────────────────────────────

class RajnetaModernLayout extends BasePosterLayout {
  const RajnetaModernLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: canvasWidth * 0.5,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  frame.color1.withOpacity(0.4),
                  frame.color1.withOpacity(0.95),
                  frame.color1,
                ],
                stops: const [0, 0.3, 0.7, 1],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.1,
          left: canvasWidth * 0.075,
          right: canvasWidth * 0.075,
          child: Column(
            children: [
              buildAvatar(config,
                  radius: canvasWidth * 0.1375,
                  border: true,
                  borderColor: Colors.white,
                  shadow: true),
              SizedBox(height: canvasWidth * 0.0375),
              styledText(
                config.userName.toUpperCase(),
                config,
                canvasWidth,
                bold: true,
                color: frame.textColor1,
                letterSpacing: 3.0,
                shadow: true,
              ),
              SizedBox(height: canvasWidth * 0.01),
              styledText(config.designation, config, canvasWidth,
                  isDesignation: true,
                  color: frame.textColor2,
                  shadow: true),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RAJNETA CLASSIC
// ─────────────────────────────────────────────────────────────────────────────

class RajnetaClassicLayout extends BasePosterLayout {
  const RajnetaClassicLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: canvasWidth * 0.275,
          child: ClipPath(
            clipper: SharpAngleClipper(),
            child: Container(
              color: frame.color1,
              child: Row(
                children: [
                  SizedBox(width: canvasWidth * 0.3125),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: canvasWidth * 0.025),
                        styledText(config.userName, config, canvasWidth,
                            bold: true, color: frame.textColor1),
                        styledText(config.designation, config, canvasWidth,
                            isDesignation: true, color: frame.textColor2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.0375,
          left: canvasWidth * 0.0625,
          child: buildAvatar(config,
              radius: canvasWidth * 0.11,
              border: true,
              borderColor: Colors.white,
              shadow: true),
        ),
      ],
    );
  }
}

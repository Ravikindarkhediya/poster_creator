import 'package:flutter/material.dart';
import '../models/poster_config.dart';
import '../models/poster_frame.dart';
import 'base_poster_layout.dart';
import '../painter/poster_clippers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// WAVY EDGE
// ─────────────────────────────────────────────────────────────────────────────

class WavyEdgeLayout extends BasePosterLayout {
  const WavyEdgeLayout();

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
            clipper: WavyEdgeClipper(),
            child: Container(
              color: frame.color1,
              padding: EdgeInsets.only(
                  left: canvasWidth * 0.325,
                  right: canvasWidth * 0.05,
                  top: canvasWidth * 0.0625),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  styledText(config.userName, config, canvasWidth,
                      bold: true, color: frame.textColor1),
                  SizedBox(height: canvasWidth * 0.005),
                  styledText(config.designation, config, canvasWidth,
                      isDesignation: true, color: frame.textColor2),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.1,
          left: canvasWidth * 0.05,
          child: buildAvatar(config,
              radius: canvasWidth * 0.1125,
              border: true,
              borderColor: Colors.white,
              shadow: true),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SIMPLE FULL
// ─────────────────────────────────────────────────────────────────────────────

class SimpleFullLayout extends BasePosterLayout {
  const SimpleFullLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [frame.color1, frame.color2],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildAvatar(config,
              radius: canvasWidth * 0.16,
              border: true,
              borderColor: Colors.white,
              shadow: true),
          SizedBox(height: canvasWidth * 0.05),
          styledText(
            config.userName.toUpperCase(),
            config,
            canvasWidth,
            bold: true,
            color: frame.textColor1,
            letterSpacing: 2.5,
          ),
          SizedBox(height: canvasWidth * 0.015),
          styledText(config.designation, config, canvasWidth,
              isDesignation: true, color: frame.textColor2),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DIAGONAL SLASH
// ─────────────────────────────────────────────────────────────────────────────

class DiagonalSlashLayout extends BasePosterLayout {
  const DiagonalSlashLayout();

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
          height: canvasWidth * 0.6,
          child: ClipPath(
            clipper: DiagonalSlashClipper(),
            child: Container(color: frame.color1),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: canvasWidth * 0.6,
          child: ClipPath(
            clipper: DiagonalSlashAccentClipper(),
            child: Container(color: frame.color2.withOpacity(0.7)),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.185,
          left: canvasWidth * 0.07,
          child: Container(
            width: canvasWidth * 0.12,
            height: 3,
            decoration: BoxDecoration(
              color: frame.textColor2,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.05,
          left: canvasWidth * 0.07,
          right: canvasWidth * 0.07,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              styledText(
                config.userName.toUpperCase(),
                config,
                canvasWidth,
                bold: true,
                color: frame.textColor1,
                letterSpacing: 1.5,
              ),
              SizedBox(height: canvasWidth * 0.005),
              styledText(config.designation, config, canvasWidth,
                  isDesignation: true, color: frame.textColor2),
            ],
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.22,
          left: canvasWidth * 0.07,
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
// PREMIUM GLASS CARD
// ─────────────────────────────────────────────────────────────────────────────

class PremiumGlassCardLayout extends BasePosterLayout {
  const PremiumGlassCardLayout();

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(canvasWidth * 0.04),
        child: Container(
          padding: EdgeInsets.all(canvasWidth * 0.03),
          decoration: BoxDecoration(
            color: frame.color1.withOpacity(0.85),
            border: Border.all(
                color: Colors.white.withOpacity(0.2), width: 1.5),
          ),
          child: Row(
            children: [
              buildAvatar(config,
                  radius: canvasWidth * 0.09,
                  border: true,
                  borderColor: Colors.white),
              SizedBox(width: canvasWidth * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    styledText(config.userName, config, canvasWidth,
                        bold: true, color: frame.textColor1),
                    Container(
                      height: 1,
                      width: 40,
                      color: frame.color2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    styledText(config.designation, config, canvasWidth,
                        isDesignation: true, color: frame.textColor2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ARC REVEAL
// ─────────────────────────────────────────────────────────────────────────────

class ArcRevealLayout extends BasePosterLayout {
  const ArcRevealLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipPath(
            clipper: const ArcRevealClipper(arcHeightFraction: 0.72),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [frame.color1, frame.color2],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.06,
          left: 0,
          right: 0,
          child: Column(
            children: [
              buildAvatar(config,
                  radius: canvasWidth * 0.11,
                  border: true,
                  borderColor: Colors.white),
              SizedBox(height: canvasWidth * 0.03),
              styledText(config.userName, config, canvasWidth,
                  bold: true, color: frame.textColor1),
              styledText(config.designation, config, canvasWidth,
                  isDesignation: true, color: frame.textColor2),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CENTER STAGE
// ─────────────────────────────────────────────────────────────────────────────

class CenterStageLayout extends BasePosterLayout {
  const CenterStageLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Center(
      child: Container(
        width: canvasWidth * 0.8,
        padding: EdgeInsets.all(canvasWidth * 0.05),
        decoration: BoxDecoration(
          color: frame.color1.withOpacity(0.9),
          borderRadius: BorderRadius.circular(canvasWidth * 0.05),
          border: Border.all(color: frame.color2, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildAvatar(config,
                radius: canvasWidth * 0.12,
                border: true,
                borderColor: Colors.white),
            SizedBox(height: canvasWidth * 0.04),
            styledText(config.userName, config, canvasWidth,
                bold: true, color: frame.textColor1),
            SizedBox(height: canvasWidth * 0.01),
            styledText(config.designation, config, canvasWidth,
                isDesignation: true, color: frame.textColor2),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CORNER BADGE
// ─────────────────────────────────────────────────────────────────────────────

class CornerBadgeLayout extends BasePosterLayout {
  const CornerBadgeLayout();

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
          bottom: canvasWidth * 0.05,
          left: 0,
          child: ClipPath(
            clipper: CornerBadgeClipper(),
            child: Container(
              width: canvasWidth * 0.7,
              height: canvasWidth * 0.2,
              color: frame.color1,
              padding: EdgeInsets.only(
                  left: canvasWidth * 0.05, right: canvasWidth * 0.05),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  styledText(config.userName, config, canvasWidth,
                      bold: true, color: frame.textColor1),
                  styledText(config.designation, config, canvasWidth,
                      isDesignation: true, color: frame.textColor2),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: canvasWidth * 0.04,
          right: canvasWidth * 0.05,
          child: buildAvatar(config,
              radius: canvasWidth * 0.1,
              border: true,
              borderColor: Colors.white),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DUAL TONE
// ─────────────────────────────────────────────────────────────────────────────

class DualToneLayout extends BasePosterLayout {
  const DualToneLayout();

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
      height: canvasWidth * 0.25,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: frame.color1,
              child: Center(
                  child: buildAvatar(config,
                      radius: canvasWidth * 0.09,
                      border: true,
                      borderColor: Colors.white)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: frame.color2,
              padding:
                  EdgeInsets.symmetric(horizontal: canvasWidth * 0.04),
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
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TRI COLOR MODERN
// ─────────────────────────────────────────────────────────────────────────────

class TriColorModernLayout extends BasePosterLayout {
  const TriColorModernLayout();

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
      height: canvasWidth * 0.28,
      child: Column(
        children: [
          Container(height: canvasWidth * 0.02, color: frame.color1),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: canvasWidth * 0.05),
              child: Row(
                children: [
                  buildAvatar(config,
                      radius: canvasWidth * 0.1,
                      border: true,
                      borderColor: frame.color1),
                  SizedBox(width: canvasWidth * 0.04),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        styledText(config.userName, config, canvasWidth,
                            bold: true, color: Colors.black87),
                        styledText(config.designation, config, canvasWidth,
                            isDesignation: true, color: Colors.black54),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: canvasWidth * 0.02, color: frame.color2),
        ],
      ),
    );
  }
}

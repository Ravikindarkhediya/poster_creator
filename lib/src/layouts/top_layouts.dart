import 'package:flutter/material.dart';
import '../models/poster_config.dart';
import '../models/poster_frame.dart';
import 'base_poster_layout.dart';
import '../painter/poster_clippers.dart';

class WavyProfileTopLayout extends BasePosterLayout {
  const WavyProfileTopLayout();

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
          top: 0,
          left: 0,
          right: 0,
          height: canvasWidth * 0.25,
          child: ClipPath(
            clipper: WavyTopClipper(),
            child: Container(
              color: frame.backgroundColor,
              padding: EdgeInsets.only(
                  left: canvasWidth * 0.28,
                  right: canvasWidth * 0.05,
                  top: canvasWidth * 0.02,
                  bottom: canvasWidth * 0.04),
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
          top: canvasWidth * 0.04,
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

class CleanBarTopLayout extends BasePosterLayout {
  const CleanBarTopLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Positioned(
      top: 0,
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
                  padding: EdgeInsets.only(left: canvasWidth * 0.32),
                  alignment: Alignment.centerLeft,
                  child: styledText(config.userName, config, canvasWidth,
                      bold: true, color: frame.textColor1),
                ),
              ),
              Expanded(
                child: Container(
                  color: frame.backgroundColor,
                  padding: EdgeInsets.only(left: canvasWidth * 0.32),
                  alignment: Alignment.centerLeft,
                  child: styledText(config.designation, config, canvasWidth,
                      isDesignation: true, color: frame.textColor2),
                ),
              ),
            ],
          ),
          Positioned(
            left: canvasWidth * 0.05,
            top: canvasWidth * 0.04,
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

class FloatingCardTopLayout extends BasePosterLayout {
  const FloatingCardTopLayout();

  @override
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  }) {
    return Positioned(
      top: canvasWidth * 0.05,
      left: canvasWidth * 0.05,
      right: canvasWidth * 0.05,
      child: Container(
        padding: EdgeInsets.all(canvasWidth * 0.03),
        decoration: BoxDecoration(
          color: frame.color1.withOpacity(0.8),
          borderRadius: BorderRadius.circular(canvasWidth * 0.05),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15)
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
          ],
        ),
      ),
    );
  }
}

class FooterStripTopLayout extends BasePosterLayout {
  const FooterStripTopLayout();

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
      top: 0,
      left: 0,
      right: 0,
      height: stripHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: NotchClipperBottom(
                avatarRadius: avatarRadius, centerX: avatarCenterX),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [frame.color1, frame.color2]),
              ),
              padding: EdgeInsets.only(
                  left: avatarLeft + (avatarRadius * 2) + canvasWidth * 0.05,
                  right: canvasWidth * 0.12,
                  top: canvasWidth * 0.02),
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
          Positioned(
            left: avatarLeft,
            bottom: -avatarRadius * 0.5,
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

class RajnetaPremiumTopLayout extends BasePosterLayout {
  const RajnetaPremiumTopLayout();

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
          top: 0,
          left: 0,
          right: 0,
          height: canvasWidth * 0.23,
          child: Container(
            decoration: BoxDecoration(
              color: frame.color1,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5))
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 4,
                    child: Container(color: frame.color2)),
                Padding(
                  padding: EdgeInsets.only(
                      left: canvasWidth * 0.30,
                      right: canvasWidth * 0.06,
                      top: canvasWidth * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      styledText(config.userName, config, canvasWidth,
                          bold: true, color: frame.textColor1, shadow: true),
                      styledText(config.designation, config, canvasWidth,
                          isDesignation: true, color: frame.textColor2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: canvasWidth * 0.02,
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

class RajnetaClassicTopLayout extends BasePosterLayout {
  const RajnetaClassicTopLayout();

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
          top: 0,
          left: 0,
          right: 0,
          height: canvasWidth * 0.275,
          child: ClipPath(
            clipper: SharpAngleClipperBottom(),
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
          top: canvasWidth * 0.04,
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

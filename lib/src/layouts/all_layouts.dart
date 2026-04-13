import 'package:flutter/material.dart';
import 'base_poster_layout.dart';
import 'poster_layout_registry.dart';
import '../models/poster_customization.dart';
import '../models/poster_frame_model.dart';
import '../painter/poster_clippers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Seed all built-in layouts (called once by PosterCanvas)
// ─────────────────────────────────────────────────────────────────────────────

bool _seeded = false;
void seedBuiltInLayouts() {
  if (_seeded) return;
  _seeded = true;
  PosterLayoutRegistry.registerAll({
    PosterFrameType.wavyProfile.name:        const _WavyProfileLayout(),
    PosterFrameType.modernAngled.name:       const _ModernAngledLayout(),
    PosterFrameType.sleekRibbon.name:        const _SleekRibbonLayout(),
    PosterFrameType.cleanBar.name:           const _CleanBarLayout(),
    PosterFrameType.footerStrip.name:        const _FooterStripLayout(),
    PosterFrameType.floatingCard.name:       const _FloatingCardLayout(),
    PosterFrameType.saffronPride.name:       const _SaffronPrideLayout(),
    PosterFrameType.tricolorStrip.name:      const _TricolorStripLayout(),
    PosterFrameType.rajnetaPremium.name:     const _RajnetaPremiumLayout(),
    PosterFrameType.rajnetaModern.name:      const _RajnetaModernLayout(),
    PosterFrameType.rajnetaClassic.name:     const _RajnetaClassicLayout(),
    PosterFrameType.wavyEdge.name:           const _WavyEdgeLayout(),
    PosterFrameType.simpleFull.name:         const _SimpleFullLayout(),
    PosterFrameType.diagonalSlash.name:      const _DiagonalSlashLayout(),
    PosterFrameType.premiumGlassCard.name:   const _PremiumGlassCardLayout(),
    PosterFrameType.arcReveal.name:          const _ArcRevealLayout(),
    PosterFrameType.centerStage.name:        const _CenterStageLayout(),
    PosterFrameType.cornerBadge.name:        const _CornerBadgeLayout(),
    PosterFrameType.dualTone.name:           const _DualToneLayout(),
    PosterFrameType.triColorModern.name:     const _TriColorModernLayout(),
    PosterFrameType.wavyProfileTop.name:     const _WavyProfileTopLayout(),
    PosterFrameType.cleanBarTop.name:        const _CleanBarTopLayout(),
    PosterFrameType.floatingCardTop.name:    const _FloatingCardTopLayout(),
    PosterFrameType.footerStripTop.name:     const _FooterStripTopLayout(),
    PosterFrameType.modernAngledTop.name:    const _ModernAngledTopLayout(),
    PosterFrameType.sleekRibbonTop.name:     const _SleekRibbonTopLayout(),
    PosterFrameType.saffronPrideTop.name:    const _SaffronPrideTopLayout(),
    PosterFrameType.tricolorStripTop.name:   const _TricolorStripTopLayout(),
    PosterFrameType.rajnetaPremiumTop.name:  const _RajnetaPremiumTopLayout(),
    PosterFrameType.rajnetaClassicTop.name:  const _RajnetaClassicTopLayout(),
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM LAYOUTS
// ─────────────────────────────────────────────────────────────────────────────

class _WavyProfileLayout extends BasePosterLayout {
  const _WavyProfileLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.25,
        child: ClipPath(clipper: WavyProfileClipper(),
          child: Container(color: c.frameBackgroundColor,
            padding: EdgeInsets.only(left: canvasWidth * 0.28, right: canvasWidth * 0.05, top: canvasWidth * 0.04),
            alignment: Alignment.centerLeft,
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
              styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
              if (c.showPhoneNumber && (c.phoneNumber?.isNotEmpty == true))
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.call, size: canvasWidth * 0.02, color: c.frameTextColor2),
                  SizedBox(width: 4),
                  Text(c.phoneNumber!, style: TextStyle(color: c.frameTextColor2, fontSize: canvasWidth * 0.02, fontWeight: FontWeight.bold)),
                ]),
            ]),
          ),
        ),
      ),
      Positioned(bottom: canvasWidth * 0.05, left: canvasWidth * 0.05,
        child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _ModernAngledLayout extends BasePosterLayout {
  const _ModernAngledLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(bottom: canvasWidth * 0.12, left: canvasWidth * 0.15, right: canvasWidth * 0.05, height: canvasWidth * 0.1,
        child: ClipPath(clipper: ModernAngledBannerClipper(),
          child: Container(color: c.frameBackgroundColor,
            padding: EdgeInsets.only(left: canvasWidth * 0.11, right: canvasWidth * 0.05),
            alignment: Alignment.centerLeft,
            child: styledText(c.userName, c, canvasWidth, bold: true, color: c.textColor, shadow: true)))),
      Positioned(bottom: canvasWidth * 0.05, left: canvasWidth * 0.20, height: canvasWidth * 0.07,
        child: ClipPath(clipper: ModernAngledTagClipper(),
          child: Container(color: c.frameColor1,
            padding: EdgeInsets.symmetric(horizontal: canvasWidth * 0.06),
            alignment: Alignment.center,
            child: styledText(c.designation, c, canvasWidth, isDesignation: true, bold: true, color: c.frameTextColor1)))),
      Positioned(bottom: canvasWidth * 0.04, left: canvasWidth * 0.05,
        child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _SleekRibbonLayout extends BasePosterLayout {
  const _SleekRibbonLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(bottom: canvasWidth * 0.1, left: canvasWidth * 0.25, right: canvasWidth * 0.05, height: canvasWidth * 0.12,
        child: ClipPath(clipper: SleekRibbonClipper(),
          child: Container(color: c.frameBackgroundColor,
            padding: EdgeInsets.only(left: canvasWidth * 0.07, right: canvasWidth * 0.1),
            alignment: Alignment.centerLeft,
            child: styledText(c.userName, c, canvasWidth, bold: true, color: c.textColor, shadow: true)))),
      Positioned(bottom: canvasWidth * 0.04, left: canvasWidth * 0.24, right: canvasWidth * 0.15, height: canvasWidth * 0.07,
        child: ClipPath(clipper: SleekRibbonClipper(),
          child: Container(color: c.frameColor1,
            padding: EdgeInsets.only(left: canvasWidth * 0.08, right: canvasWidth * 0.08),
            alignment: Alignment.centerLeft,
            child: styledText(c.designation, c, canvasWidth, isDesignation: true, bold: true, color: c.frameTextColor1)))),
      Positioned(bottom: canvasWidth * 0.02, left: canvasWidth * 0.08,
        child: buildAvatar(c, radius: canvasWidth * 0.11, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _CleanBarLayout extends BasePosterLayout {
  const _CleanBarLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.22,
      child: Stack(clipBehavior: Clip.none, children: [
        Column(children: [
          Expanded(child: Container(color: c.frameColor1, padding: EdgeInsets.only(left: canvasWidth * 0.32), alignment: Alignment.centerLeft,
            child: styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1))),
          Expanded(child: Container(color: c.frameBackgroundColor, padding: EdgeInsets.only(left: canvasWidth * 0.32), alignment: Alignment.centerLeft,
            child: styledText(c.designation, c, canvasWidth, isDesignation: true, bold: true, color: c.frameTextColor2))),
        ]),
        Positioned(left: canvasWidth * 0.05, bottom: canvasWidth * 0.04,
          child: buildAvatar(c, radius: canvasWidth * 0.11, border: true, borderColor: Colors.white, shadow: true)),
      ]));
  }
}

class _FooterStripLayout extends BasePosterLayout {
  const _FooterStripLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    final ar = canvasWidth * 0.12;
    final al = canvasWidth * 0.06;
    final sh = canvasWidth * 0.18;
    final cx = al + ar;
    return Positioned(bottom: 0, left: 0, right: 0, height: sh,
      child: Stack(clipBehavior: Clip.none, children: [
        ClipPath(clipper: NotchClipper(avatarRadius: ar, centerX: cx),
          child: Container(height: sh, width: double.infinity,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [c.frameColor1, c.frameColor2]),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 12, offset: Offset(0, -3))]),
            padding: EdgeInsets.only(left: al + ar * 2 + canvasWidth * 0.05, right: canvasWidth * 0.05, bottom: canvasWidth * 0.05),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
              SizedBox(height: canvasWidth * 0.01),
              styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
            ]))),
        Positioned(left: al, top: -ar,
          child: buildAvatar(c, radius: ar, border: true, borderColor: Colors.white, shadow: true)),
      ]));
  }
}

class _FloatingCardLayout extends BasePosterLayout {
  const _FloatingCardLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Positioned(bottom: canvasWidth * 0.05, left: canvasWidth * 0.05, right: canvasWidth * 0.05,
      child: Container(padding: EdgeInsets.all(canvasWidth * 0.03),
        decoration: BoxDecoration(color: c.frameColor1.withOpacity(0.8),
          borderRadius: BorderRadius.circular(canvasWidth * 0.05),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15)]),
        child: Row(children: [
          buildAvatar(c, radius: canvasWidth * 0.08, border: true, borderColor: c.frameColor1),
          SizedBox(width: canvasWidth * 0.03),
          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
            styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
          ])),
        ])));
  }
}

class _SaffronPrideLayout extends BasePosterLayout {
  const _SaffronPrideLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    final bh = canvasWidth * 0.23;
    final ar = canvasWidth * 0.1;
    final al = canvasWidth * 0.06;
    return Positioned(bottom: 0, left: 0, right: 0, height: bh,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [c.frameColor1, c.frameColor2], begin: Alignment.topLeft, end: Alignment.bottomRight))),
        Positioned(left: al + ar * 2 + canvasWidth * 0.05, right: canvasWidth * 0.06, top: 0, bottom: 0,
          child: Align(alignment: Alignment.centerLeft, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1, shadow: true),
            SizedBox(height: canvasWidth * 0.01),
            styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2, shadow: true),
          ]))),
        Positioned(left: al, top: bh / 2 - ar,
          child: buildAvatar(c, radius: ar, border: true, borderColor: Colors.white, shadow: false)),
      ]));
  }
}

class _TricolorStripLayout extends BasePosterLayout {
  const _TricolorStripLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.2,
      child: Stack(clipBehavior: Clip.none, children: [
        Column(children: [
          Container(height: canvasWidth * 0.06, color: c.frameColor1),
          Container(height: canvasWidth * 0.08, color: c.frameColor2, alignment: Alignment.center,
            child: styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1)),
          Container(height: canvasWidth * 0.06, color: c.frameColor3),
        ]),
        Positioned(left: canvasWidth * 0.05, bottom: canvasWidth * 0.03,
          child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white, shadow: true)),
      ]));
  }
}

class _RajnetaPremiumLayout extends BasePosterLayout {
  const _RajnetaPremiumLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(bottom: canvasWidth * 0.01, left: 0, right: 0, height: canvasWidth * 0.23,
        child: Container(decoration: BoxDecoration(color: c.frameColor1,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 25, offset: Offset(0, -5))]),
          child: Stack(children: [
            Positioned(top: 0, left: 0, right: 0, height: 4, child: Container(color: c.frameColor2)),
            Padding(padding: EdgeInsets.only(left: canvasWidth * 0.30, right: canvasWidth * 0.06, bottom: canvasWidth * 0.05),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1, shadow: true, shadowBlur: 12),
                SizedBox(height: canvasWidth * 0.005),
                styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2, letterSpacing: 0.8),
              ])),
          ]))),
      Positioned(bottom: canvasWidth * 0.08, left: canvasWidth * 0.05,
        child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _RajnetaModernLayout extends BasePosterLayout {
  const _RajnetaModernLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.5,
        child: Container(decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.transparent, c.frameColor1.withOpacity(0.4), c.frameColor1.withOpacity(0.95), c.frameColor1],
          stops: [0, 0.3, 0.7, 1])))),
      Positioned(bottom: canvasWidth * 0.1, left: canvasWidth * 0.075, right: canvasWidth * 0.075,
        child: Column(children: [
          buildAvatar(c, radius: canvasWidth * 0.1375, border: true, borderColor: Colors.white, shadow: true),
          SizedBox(height: canvasWidth * 0.0375),
          styledText(c.userName.toUpperCase(), c, canvasWidth, bold: true, color: c.frameTextColor1, letterSpacing: 3.0, shadow: true),
          SizedBox(height: canvasWidth * 0.01),
          styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2, shadow: true),
        ])),
    ]);
  }
}

class _RajnetaClassicLayout extends BasePosterLayout {
  const _RajnetaClassicLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.275,
        child: ClipPath(clipper: SharpAngleClipper(),
          child: Container(color: c.frameColor1,
            child: Row(children: [
              SizedBox(width: canvasWidth * 0.3125),
              Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: canvasWidth * 0.025),
                styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
                styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
              ])),
            ])))),
      Positioned(bottom: canvasWidth * 0.0375, left: canvasWidth * 0.0625,
        child: buildAvatar(c, radius: canvasWidth * 0.11, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _WavyEdgeLayout extends BasePosterLayout {
  const _WavyEdgeLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.25,
        child: ClipPath(clipper: WavyEdgeClipper(),
          child: Container(color: c.frameColor1,
            padding: EdgeInsets.only(left: canvasWidth * 0.325, right: canvasWidth * 0.05, top: canvasWidth * 0.0625),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
              SizedBox(height: canvasWidth * 0.005),
              styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
            ])))),
      Positioned(bottom: canvasWidth * 0.1, left: canvasWidth * 0.05,
        child: buildAvatar(c, radius: canvasWidth * 0.1125, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _SimpleFullLayout extends BasePosterLayout {
  const _SimpleFullLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Container(width: double.infinity, height: double.infinity,
      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [c.frameColor1, c.frameColor2])),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildAvatar(c, radius: canvasWidth * 0.16, border: true, borderColor: Colors.white, shadow: true),
        SizedBox(height: canvasWidth * 0.05),
        styledText(c.userName.toUpperCase(), c, canvasWidth, bold: true, color: c.frameTextColor1, letterSpacing: 2.5),
        SizedBox(height: canvasWidth * 0.015),
        styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
      ]));
  }
}

class _DiagonalSlashLayout extends BasePosterLayout {
  const _DiagonalSlashLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.6,
        child: ClipPath(clipper: DiagonalSlashClipper(), child: Container(color: c.frameColor1))),
      Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.6,
        child: ClipPath(clipper: DiagonalSlashAccentClipper(), child: Container(color: c.frameColor2.withOpacity(0.7)))),
      Positioned(bottom: canvasWidth * 0.185, left: canvasWidth * 0.07,
        child: Container(width: canvasWidth * 0.12, height: 3, decoration: BoxDecoration(color: c.frameTextColor2, borderRadius: BorderRadius.circular(2)))),
      Positioned(bottom: canvasWidth * 0.05, left: canvasWidth * 0.07, right: canvasWidth * 0.07,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          styledText(c.userName.toUpperCase(), c, canvasWidth, bold: true, color: c.frameTextColor1, letterSpacing: 1.5),
          SizedBox(height: canvasWidth * 0.005),
          styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
        ])),
      Positioned(bottom: canvasWidth * 0.22, left: canvasWidth * 0.07,
        child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _PremiumGlassCardLayout extends BasePosterLayout {
  const _PremiumGlassCardLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Positioned(bottom: canvasWidth * 0.05, left: canvasWidth * 0.05, right: canvasWidth * 0.05,
      child: ClipRRect(borderRadius: BorderRadius.circular(canvasWidth * 0.04),
        child: Container(padding: EdgeInsets.all(canvasWidth * 0.03),
          decoration: BoxDecoration(color: c.frameColor1.withOpacity(0.85), border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5)),
          child: Row(children: [
            buildAvatar(c, radius: canvasWidth * 0.09, border: true, borderColor: Colors.white),
            SizedBox(width: canvasWidth * 0.04),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
              Container(height: 1, width: 40, color: c.frameColor2, margin: EdgeInsets.symmetric(vertical: 4)),
              styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
            ])),
          ]))));
  }
}

class _ArcRevealLayout extends BasePosterLayout {
  const _ArcRevealLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned.fill(child: ClipPath(clipper: ArcRevealClipper(),
        child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [c.frameColor1, c.frameColor2]))))),
      Positioned(bottom: canvasWidth * 0.06, left: 0, right: 0,
        child: Column(children: [
          buildAvatar(c, radius: canvasWidth * 0.11, border: true, borderColor: Colors.white),
          SizedBox(height: canvasWidth * 0.03),
          styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
          styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
        ])),
    ]);
  }
}

class _CenterStageLayout extends BasePosterLayout {
  const _CenterStageLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Center(child: Container(width: canvasWidth * 0.8, padding: EdgeInsets.all(canvasWidth * 0.05),
      decoration: BoxDecoration(color: c.frameColor1.withOpacity(0.9), borderRadius: BorderRadius.circular(canvasWidth * 0.05), border: Border.all(color: c.frameColor2, width: 2)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildAvatar(c, radius: canvasWidth * 0.12, border: true, borderColor: Colors.white),
        SizedBox(height: canvasWidth * 0.04),
        styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
        SizedBox(height: canvasWidth * 0.01),
        styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
      ])));
  }
}

class _CornerBadgeLayout extends BasePosterLayout {
  const _CornerBadgeLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(bottom: canvasWidth * 0.05, left: 0,
        child: ClipPath(clipper: CornerBadgeClipper(), child: Container(width: canvasWidth * 0.7, height: canvasWidth * 0.2, color: c.frameColor1,
          padding: EdgeInsets.only(left: canvasWidth * 0.05, right: canvasWidth * 0.05), alignment: Alignment.centerLeft,
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
            styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
          ])))),
      Positioned(bottom: canvasWidth * 0.04, right: canvasWidth * 0.05,
        child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white)),
    ]);
  }
}

class _DualToneLayout extends BasePosterLayout {
  const _DualToneLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.25,
      child: Row(children: [
        Expanded(flex: 2, child: Container(color: c.frameColor1, child: Center(child: buildAvatar(c, radius: canvasWidth * 0.09, border: true, borderColor: Colors.white)))),
        Expanded(flex: 3, child: Container(color: c.frameColor2, padding: EdgeInsets.symmetric(horizontal: canvasWidth * 0.04),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
            styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
          ]))),
      ]));
  }
}

class _TriColorModernLayout extends BasePosterLayout {
  const _TriColorModernLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Positioned(bottom: 0, left: 0, right: 0, height: canvasWidth * 0.28,
      child: Column(children: [
        Container(height: canvasWidth * 0.02, color: c.frameColor1),
        Expanded(child: Container(color: Colors.white, padding: EdgeInsets.symmetric(horizontal: canvasWidth * 0.05),
          child: Row(children: [
            buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: c.frameColor1),
            SizedBox(width: canvasWidth * 0.04),
            Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              styledText(c.userName, c, canvasWidth, bold: true, color: Colors.black87),
              styledText(c.designation, c, canvasWidth, isDesignation: true, color: Colors.black54),
            ])),
          ]))),
        Container(height: canvasWidth * 0.02, color: c.frameColor2),
      ]));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TOP LAYOUTS
// ─────────────────────────────────────────────────────────────────────────────

class _WavyProfileTopLayout extends BasePosterLayout {
  const _WavyProfileTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(top: 0, left: 0, right: 0, height: canvasWidth * 0.25,
        child: ClipPath(clipper: WavyTopClipper(),
          child: Container(color: c.frameBackgroundColor,
            padding: EdgeInsets.only(left: canvasWidth * 0.28, right: canvasWidth * 0.05, top: canvasWidth * 0.02, bottom: canvasWidth * 0.04),
            alignment: Alignment.centerLeft,
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
              styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
            ])))),
      Positioned(top: canvasWidth * 0.04, left: canvasWidth * 0.05,
        child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _CleanBarTopLayout extends BasePosterLayout {
  const _CleanBarTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Positioned(top: 0, left: 0, right: 0, height: canvasWidth * 0.22,
      child: Stack(clipBehavior: Clip.none, children: [
        Column(children: [
          Expanded(child: Container(color: c.frameColor1, padding: EdgeInsets.only(left: canvasWidth * 0.32), alignment: Alignment.centerLeft,
            child: styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1))),
          Expanded(child: Container(color: c.frameBackgroundColor, padding: EdgeInsets.only(left: canvasWidth * 0.32), alignment: Alignment.centerLeft,
            child: styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2))),
        ]),
        Positioned(left: canvasWidth * 0.05, top: canvasWidth * 0.04,
          child: buildAvatar(c, radius: canvasWidth * 0.11, border: true, borderColor: Colors.white, shadow: true)),
      ]));
  }
}

class _FloatingCardTopLayout extends BasePosterLayout {
  const _FloatingCardTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Positioned(top: canvasWidth * 0.05, left: canvasWidth * 0.05, right: canvasWidth * 0.05,
      child: Container(padding: EdgeInsets.all(canvasWidth * 0.03),
        decoration: BoxDecoration(color: c.frameColor1.withOpacity(0.8), borderRadius: BorderRadius.circular(canvasWidth * 0.05),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15)]),
        child: Row(children: [
          buildAvatar(c, radius: canvasWidth * 0.08, border: true, borderColor: c.frameColor1),
          SizedBox(width: canvasWidth * 0.03),
          Expanded(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
            styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
          ])),
        ])));
  }
}

class _FooterStripTopLayout extends BasePosterLayout {
  const _FooterStripTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    final ar = canvasWidth * 0.12;
    final al = canvasWidth * 0.06;
    final sh = canvasWidth * 0.18;
    final cx = al + ar;
    return Positioned(top: 0, left: 0, right: 0, height: sh,
      child: Stack(clipBehavior: Clip.none, children: [
        ClipPath(clipper: NotchClipperBottom(avatarRadius: ar, centerX: cx),
          child: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [c.frameColor1, c.frameColor2])),
            padding: EdgeInsets.only(left: al + ar * 2 + canvasWidth * 0.05, right: canvasWidth * 0.12, top: canvasWidth * 0.02),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
              styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
              styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
            ]))),
        Positioned(left: al, bottom: -ar * 0.5,
          child: buildAvatar(c, radius: ar, border: true, borderColor: Colors.white, shadow: true)),
      ]));
  }
}

class _ModernAngledTopLayout extends BasePosterLayout {
  const _ModernAngledTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(top: canvasWidth * 0.05, left: canvasWidth * 0.15, right: canvasWidth * 0.03, height: canvasWidth * 0.1,
        child: ClipPath(clipper: ModernAngledBannerClipper(),
          child: Container(color: c.frameBackgroundColor,
            padding: EdgeInsets.only(left: canvasWidth * 0.11, right: canvasWidth * 0.05), alignment: Alignment.centerLeft,
            child: styledText(c.userName, c, canvasWidth, bold: true, color: c.textColor)))),
      Positioned(top: canvasWidth * 0.12, left: canvasWidth * 0.20, height: canvasWidth * 0.07,
        child: ClipPath(clipper: ModernAngledTagClipper(),
          child: Container(color: c.frameColor1,
            padding: EdgeInsets.symmetric(horizontal: canvasWidth * 0.06), alignment: Alignment.center,
            child: styledText(c.designation, c, canvasWidth, isDesignation: true, bold: true, color: c.frameTextColor1)))),
      Positioned(top: canvasWidth * 0.04, left: canvasWidth * 0.05,
        child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _SleekRibbonTopLayout extends BasePosterLayout {
  const _SleekRibbonTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(top: canvasWidth * 0.05, left: canvasWidth * 0.25, right: canvasWidth * 0.05, height: canvasWidth * 0.12,
        child: ClipPath(clipper: SleekRibbonClipper(),
          child: Container(color: c.frameBackgroundColor,
            padding: EdgeInsets.only(left: canvasWidth * 0.07, right: canvasWidth * 0.1), alignment: Alignment.centerLeft,
            child: styledText(c.userName, c, canvasWidth, bold: true, color: c.textColor)))),
      Positioned(top: canvasWidth * 0.14, left: canvasWidth * 0.24, right: canvasWidth * 0.15, height: canvasWidth * 0.07,
        child: ClipPath(clipper: SleekRibbonClipper(),
          child: Container(color: c.frameColor1,
            padding: EdgeInsets.only(left: canvasWidth * 0.08, right: canvasWidth * 0.08), alignment: Alignment.centerLeft,
            child: styledText(c.designation, c, canvasWidth, isDesignation: true, bold: true, color: c.frameTextColor1)))),
      Positioned(top: canvasWidth * 0.02, left: canvasWidth * 0.08,
        child: buildAvatar(c, radius: canvasWidth * 0.11, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _SaffronPrideTopLayout extends BasePosterLayout {
  const _SaffronPrideTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    final bh = canvasWidth * 0.23;
    final ar = canvasWidth * 0.1;
    final al = canvasWidth * 0.06;
    return Positioned(top: 0, left: 0, right: 0, height: bh,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [c.frameColor1, c.frameColor2]))),
        Positioned(left: al + ar * 2 + canvasWidth * 0.05, right: canvasWidth * 0.06, top: 0, bottom: 0,
          child: Align(alignment: Alignment.centerLeft, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1, shadow: true),
            styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2, shadow: true),
          ]))),
        Positioned(left: al, top: bh / 2 - ar,
          child: buildAvatar(c, radius: ar, border: true, borderColor: Colors.white, shadow: true)),
      ]));
  }
}

class _TricolorStripTopLayout extends BasePosterLayout {
  const _TricolorStripTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Positioned(top: 0, left: 0, right: 0, height: canvasWidth * 0.2,
      child: Stack(clipBehavior: Clip.none, children: [
        Column(children: [
          Container(height: canvasWidth * 0.06, color: c.frameColor1),
          Container(height: canvasWidth * 0.08, color: c.frameColor2, alignment: Alignment.center,
            child: styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1)),
          Container(height: canvasWidth * 0.06, color: c.frameColor3),
        ]),
        Positioned(left: canvasWidth * 0.05, top: canvasWidth * 0.03,
          child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white, shadow: true)),
      ]));
  }
}

class _RajnetaPremiumTopLayout extends BasePosterLayout {
  const _RajnetaPremiumTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(top: 0, left: 0, right: 0, height: canvasWidth * 0.23,
        child: Container(decoration: BoxDecoration(color: c.frameColor1,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 5))]),
          child: Stack(children: [
            Positioned(bottom: 0, left: 0, right: 0, height: 4, child: Container(color: c.frameColor2)),
            Padding(padding: EdgeInsets.only(left: canvasWidth * 0.30, right: canvasWidth * 0.06, top: canvasWidth * 0.02),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1, shadow: true),
                styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
              ])),
          ]))),
      Positioned(top: canvasWidth * 0.02, left: canvasWidth * 0.05,
        child: buildAvatar(c, radius: canvasWidth * 0.1, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

class _RajnetaClassicTopLayout extends BasePosterLayout {
  const _RajnetaClassicTopLayout();
  @override Widget build({required BuildContext context, required PosterCustomization c, required double canvasWidth}) {
    return Stack(children: [
      Positioned(top: 0, left: 0, right: 0, height: canvasWidth * 0.275,
        child: ClipPath(clipper: SharpAngleClipperBottom(),
          child: Container(color: c.frameColor1,
            child: Row(children: [
              SizedBox(width: canvasWidth * 0.3125),
              Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                styledText(c.userName, c, canvasWidth, bold: true, color: c.frameTextColor1),
                styledText(c.designation, c, canvasWidth, isDesignation: true, color: c.frameTextColor2),
              ])),
            ])))),
      Positioned(top: canvasWidth * 0.04, left: canvasWidth * 0.0625,
        child: buildAvatar(c, radius: canvasWidth * 0.11, border: true, borderColor: Colors.white, shadow: true)),
    ]);
  }
}

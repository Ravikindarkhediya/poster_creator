/// Exports all built-in layout implementations and seeds the registry.
library;

export 'bottom_layouts.dart';
export 'special_layouts.dart';
export 'top_layouts.dart';

import 'poster_layout_registry.dart';
import 'bottom_layouts.dart';
import 'special_layouts.dart';
import 'top_layouts.dart';
import '../models/poster_frame.dart';

/// Seeds all built-in layouts into [PosterLayoutRegistry].
///
/// Called automatically by [PosterCanvas] on first build.
void seedBuiltInLayouts() {
  PosterLayoutRegistry.registerAll({
    // ── Bottom ──────────────────────────────────────────────────────────
    PosterFrameType.wavyProfile.name: const WavyProfileLayout(),
    PosterFrameType.modernAngled.name: const ModernAngledLayout(),
    PosterFrameType.sleekRibbon.name: const SleekRibbonLayout(),
    PosterFrameType.cleanBar.name: const CleanBarLayout(),
    PosterFrameType.footerStrip.name: const FooterStripLayout(),
    PosterFrameType.floatingCard.name: const FloatingCardLayout(),
    PosterFrameType.saffronPride.name: const SaffronPrideLayout(),
    PosterFrameType.tricolorStrip.name: const TricolorStripLayout(),
    PosterFrameType.rajnetaPremium.name: const RajnetaPremiumLayout(),
    PosterFrameType.rajnetaModern.name: const RajnetaModernLayout(),
    PosterFrameType.rajnetaClassic.name: const RajnetaClassicLayout(),
    PosterFrameType.wavyEdge.name: const WavyEdgeLayout(),
    PosterFrameType.simpleFull.name: const SimpleFullLayout(),
    PosterFrameType.diagonalSlash.name: const DiagonalSlashLayout(),
    PosterFrameType.premiumGlassCard.name: const PremiumGlassCardLayout(),
    PosterFrameType.arcReveal.name: const ArcRevealLayout(),
    PosterFrameType.centerStage.name: const CenterStageLayout(),
    PosterFrameType.cornerBadge.name: const CornerBadgeLayout(),
    PosterFrameType.dualTone.name: const DualToneLayout(),
    PosterFrameType.triColorModern.name: const TriColorModernLayout(),

    // ── Top ─────────────────────────────────────────────────────────────
    PosterFrameType.wavyProfileTop.name: const WavyProfileTopLayout(),
    PosterFrameType.cleanBarTop.name: const CleanBarTopLayout(),
    PosterFrameType.floatingCardTop.name: const FloatingCardTopLayout(),
    PosterFrameType.footerStripTop.name: const FooterStripTopLayout(),
    PosterFrameType.rajnetaPremiumTop.name: const RajnetaPremiumTopLayout(),
    PosterFrameType.rajnetaClassicTop.name: const RajnetaClassicTopLayout(),
  });
}

import 'package:flutter/material.dart';
import '../models/poster_config.dart';
import '../models/poster_frame.dart';
import 'poster_avatar_builder.dart';
import 'poster_text_builder.dart';

/// Every frame layout extends this class and implements [build].
///
/// Override [build] to return the overlay widget. The widget is stacked
/// on top of the template image at full size.
///
/// For convenience, [buildAvatar] and [styledText] are provided so layouts
/// don't duplicate avatar/text rendering logic.
abstract class BasePosterLayout {
  const BasePosterLayout();

  /// Build the frame overlay widget.
  ///
  /// [config] — full poster configuration.
  /// [frame]  — the specific frame being rendered (same as config.frame but
  ///            may be overridden by the preview mode).
  /// [canvasWidth] — rendered width of the canvas in logical pixels.
  Widget build({
    required BuildContext context,
    required PosterConfig config,
    required PosterFrame frame,
    required double canvasWidth,
  });

  // ── Shared helpers ────────────────────────────────────────────────────────

  /// Renders the user's profile avatar.
  Widget buildAvatar(
    PosterConfig config, {
    required double radius,
    bool border = false,
    Color? borderColor,
    bool shadow = false,
  }) {
    return PosterAvatarBuilder.build(
      config,
      radius: radius,
      border: border,
      borderColor: borderColor,
      shadow: shadow,
    );
  }

  /// Returns a styled [Text] widget for name or designation.
  Widget styledText(
    String text,
    PosterConfig config,
    double canvasWidth, {
    bool isDesignation = false,
    double? sizePx,
    bool bold = false,
    Color? color,
    bool shadow = false,
    double? letterSpacing,
    double shadowBlur = 8,
  }) {
    return PosterTextBuilder.build(
      text,
      config,
      canvasWidth,
      isDesignation: isDesignation,
      sizePx: sizePx,
      bold: bold,
      color: color,
      shadow: shadow,
      letterSpacing: letterSpacing,
      shadowBlur: shadowBlur,
    );
  }
}

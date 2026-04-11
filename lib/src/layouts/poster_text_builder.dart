import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/poster_config.dart';

/// Builds responsive text widgets used inside frame layouts.
class PosterTextBuilder {
  static Widget build(
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
    final styleConfig = isDesignation ? config.designationStyle : config.nameStyle;
    final double baseSize = sizePx ?? styleConfig.fontSize;
    final double responsiveSize = baseSize * (canvasWidth / 400.0);

    TextStyle style;
    try {
      style = GoogleFonts.getFont(
        styleConfig.fontFamily,
        textStyle: TextStyle(
          fontSize: responsiveSize,
          fontWeight:
              (bold || styleConfig.isBold) ? FontWeight.w900 : FontWeight.w500,
          color: color ?? styleConfig.color,
          letterSpacing: letterSpacing ?? styleConfig.letterSpacing,
          height: 1.1,
          shadows: shadow
              ? [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: shadowBlur,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
      );
    } catch (_) {
      style = TextStyle(
        fontSize: responsiveSize,
        fontWeight:
            (bold || styleConfig.isBold) ? FontWeight.w900 : FontWeight.w500,
        color: color ?? styleConfig.color,
      );
    }

    return Text(
      text,
      style: style,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

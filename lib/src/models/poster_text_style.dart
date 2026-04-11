import 'package:flutter/material.dart';

/// Text styling for name / designation fields on a frame.
class PosterTextConfig {
  final String fontFamily;
  final double fontSize;
  final Color color;
  final bool isBold;
  final double letterSpacing;

  const PosterTextConfig({
    this.fontFamily = 'Poppins',
    this.fontSize = 22,
    this.color = Colors.white,
    this.isBold = false,
    this.letterSpacing = 0,
  });

  PosterTextConfig copyWith({
    String? fontFamily,
    double? fontSize,
    Color? color,
    bool? isBold,
    double? letterSpacing,
  }) {
    return PosterTextConfig(
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      color: color ?? this.color,
      isBold: isBold ?? this.isBold,
      letterSpacing: letterSpacing ?? this.letterSpacing,
    );
  }
}

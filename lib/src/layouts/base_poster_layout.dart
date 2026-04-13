import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/poster_customization.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Base layout
// ─────────────────────────────────────────────────────────────────────────────

abstract class BasePosterLayout {
  const BasePosterLayout();

  Widget build({
    required BuildContext context,
    required PosterCustomization c,
    required double canvasWidth,
  });

  // ── Shared helpers ─────────────────────────────────────────────────────────

  Widget buildAvatar(
    PosterCustomization c, {
    required double radius,
    bool border = false,
    Color? borderColor,
    bool shadow = false,
  }) {
    if (!c.showProfileImage) return const SizedBox.shrink();

    final path = c.profileImagePath;
    if (path.isEmpty) {
      return Container(
        width: radius * 2, height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
          border: border ? Border.all(color: borderColor ?? Colors.white, width: radius * 0.07) : null,
        ),
        child: Icon(Icons.person, size: radius, color: Colors.grey.shade400),
      );
    }

    Widget img;
    if (path.startsWith('http')) {
      img = CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(color: Colors.grey.shade200),
        errorWidget: (_, __, ___) => Icon(Icons.person, size: radius, color: Colors.grey.shade400),
      );
    } else {
      final file = File(path);
      img = file.existsSync()
          ? Image.file(file, fit: BoxFit.cover)
          : Icon(Icons.person, size: radius, color: Colors.grey.shade400);
    }

    return Container(
      width: radius * 2, height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border ? Border.all(color: borderColor ?? Colors.white, width: radius * 0.07) : null,
        boxShadow: shadow
            ? [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: radius * 0.4, spreadRadius: 1)]
            : null,
      ),
      child: ClipOval(
        child: Container(
          color: c.isBackgroundRemoved ? Colors.transparent : Colors.white,
          child: img,
        ),
      ),
    );
  }

  Widget styledText(
    String text,
    PosterCustomization c,
    double canvasWidth, {
    bool isDesignation = false,
    double? sizePx,
    bool bold = false,
    Color? color,
    bool shadow = false,
    double? letterSpacing,
    double shadowBlur = 8,
  }) {
    final baseSize = sizePx ??
        (isDesignation ? c.designationFontSize : c.nameFontSize);
    final rs = baseSize * (canvasWidth / 400.0);
    final family = isDesignation ? c.designationFontFamily : c.nameFontFamily;

    TextStyle style;
    try {
      style = GoogleFonts.getFont(
        family,
        textStyle: TextStyle(
          fontSize: rs,
          fontWeight: bold ? FontWeight.w900 : FontWeight.w500,
          color: color ?? (isDesignation ? c.frameTextColor2 : c.frameTextColor1),
          letterSpacing: letterSpacing,
          height: 1.1,
          shadows: shadow
              ? [Shadow(color: Colors.black.withOpacity(0.5), blurRadius: shadowBlur, offset: const Offset(0, 2))]
              : null,
        ),
      );
    } catch (_) {
      style = TextStyle(
        fontSize: rs,
        fontWeight: bold ? FontWeight.w900 : FontWeight.w500,
        color: color ?? Colors.white,
      );
    }
    return Text(text, style: style, maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}

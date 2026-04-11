import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/poster_config.dart';

/// Builds the profile avatar widget used by every frame layout.
class PosterAvatarBuilder {
  static Widget build(
    PosterConfig config, {
    required double radius,
    bool border = false,
    Color? borderColor,
    bool shadow = false,
  }) {
    if (!config.showProfileImage) return const SizedBox.shrink();

    final path = config.profileImagePath;

    if (path.isEmpty) {
      return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
          border: border
              ? Border.all(color: borderColor ?? Colors.white, width: radius * 0.07)
              : null,
        ),
        child: Icon(Icons.person, size: radius, color: Colors.grey.shade400),
      );
    }

    Widget imageWidget;
    if (path.startsWith('http')) {
      imageWidget = CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(color: Colors.grey.shade200),
        errorWidget: (_, __, ___) =>
            Icon(Icons.person, size: radius, color: Colors.grey.shade400),
      );
    } else {
      final file = File(path);
      if (file.existsSync()) {
        imageWidget = Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Icon(Icons.person, size: radius, color: Colors.grey.shade400),
        );
      } else {
        imageWidget = Icon(Icons.person, size: radius, color: Colors.grey.shade400);
      }
    }

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border
            ? Border.all(color: borderColor ?? Colors.white, width: radius * 0.07)
            : null,
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: radius * 0.4,
                  spreadRadius: 1,
                )
              ]
            : null,
      ),
      child: ClipOval(
        child: Container(
          color: config.isBackgroundRemoved ? Colors.transparent : Colors.white,
          child: imageWidget,
        ),
      ),
    );
  }
}

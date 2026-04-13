import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

/// Utility helpers for image resolution and URL detection.
class PosterImageHelper {
  PosterImageHelper._();

  /// Resolves the natural pixel [Size] of an image at [url].
  ///
  /// Supports:
  /// - HTTP/HTTPS URLs
  /// - Local file paths
  ///
  /// Returns [Size.zero] on failure or empty URL.
  static Future<Size> resolveImageSize(String url) {
    if (url.isEmpty) return Future.value(Size.zero);

    final completer = Completer<Size>();

    ImageProvider provider;
    if (url.startsWith('http')) {
      provider = NetworkImage(url);
    } else {
      final file = File(url);
      if (!file.existsSync()) return Future.value(Size.zero);
      provider = FileImage(file);
    }

    provider.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, _) {
          if (!completer.isCompleted) {
            completer.complete(Size(
              info.image.width.toDouble(),
              info.image.height.toDouble(),
            ));
          }
        },
        onError: (_, __) {
          if (!completer.isCompleted) completer.complete(Size.zero);
        },
      ),
    );

    return completer.future;
  }

  /// Resolves the aspect ratio (width / height) of an image.
  ///
  /// Returns 1.0 on failure or zero-height images.
  static Future<double> resolveAspectRatio(String url) async {
    final size = await resolveImageSize(url);
    if (size == Size.zero || size.height == 0) return 1.0;
    return (size.width / size.height).clamp(0.25, 4.0);
  }

  /// Returns true if [url] is an HTTP or HTTPS URL.
  static bool isNetworkUrl(String url) =>
      url.startsWith('http://') || url.startsWith('https://');

  /// Returns true if [url] is a local file path (non-empty, non-HTTP).
  static bool isLocalPath(String url) => !isNetworkUrl(url) && url.isNotEmpty;

  /// Formats a raw path: returns it as-is if it's already HTTP,
  /// or prepends [baseUrl] if it starts with '/'.
  static String formatUrl(String rawPath, {String baseUrl = ''}) {
    if (rawPath.isEmpty) return rawPath;
    if (rawPath.startsWith('http')) return rawPath;
    if (File(rawPath).existsSync()) return rawPath;
    if (baseUrl.isNotEmpty) {
      final base = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      final path = rawPath.startsWith('/') ? rawPath : '/$rawPath';
      return '$base$path';
    }
    return rawPath;
  }
}

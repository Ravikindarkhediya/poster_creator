import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

/// Utility helpers for working with poster images.
class PosterImageHelper {
  PosterImageHelper._();

  /// Resolves the natural pixel size of an image at [url].
  /// Returns [Size.zero] on failure.
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

  /// Resolves aspect ratio (width / height). Returns 1.0 on failure.
  static Future<double> resolveAspectRatio(String url) async {
    final size = await resolveImageSize(url);
    if (size == Size.zero || size.height == 0) return 1.0;
    return (size.width / size.height).clamp(0.25, 4.0);
  }

  /// Returns true if [url] is an HTTP/HTTPS URL.
  static bool isNetworkUrl(String url) =>
      url.startsWith('http://') || url.startsWith('https://');

  /// Returns true if [url] is a local file path.
  static bool isLocalPath(String url) => !isNetworkUrl(url) && url.isNotEmpty;
}

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/poster_export_result.dart';

/// Captures a [RepaintBoundary] and returns PNG bytes.
///
/// ### Basic usage
/// ```dart
/// final exportKey = GlobalKey();
/// PosterCanvas(config: myConfig, exportKey: exportKey)
///
/// final result = await PosterExporter.export(exportKey);
/// if (result != null) {
///   await Gal.putImageBytes(result.bytes);
/// }
/// ```
class PosterExporter {
  PosterExporter._();

  /// Export as PNG bytes. [pixelRatio] defaults to 3.0.
  static Future<PosterExportResult?> export(
    GlobalKey key, {
    double pixelRatio = 3.0,
  }) async {
    try {
      final boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        debugPrint('[PosterExporter] RenderRepaintBoundary not found.');
        return null;
      }
      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final ByteData? data =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) return null;
      return PosterExportResult(
        bytes: data.buffer.asUint8List(),
        width: image.width,
        height: image.height,
      );
    } catch (e) {
      debugPrint('[PosterExporter] export failed: $e');
      return null;
    }
  }

  /// Export and save to [filePath] (must include filename + .png).
  ///
  /// ```dart
  /// final dir = (await getTemporaryDirectory()).path;
  /// final path = await PosterExporter.exportToFile(
  ///   exportKey,
  ///   filePath: '$dir/poster.png',
  /// );
  /// ```
  static Future<String?> exportToFile(
    GlobalKey key, {
    required String filePath,
    double pixelRatio = 3.0,
  }) async {
    final result = await export(key, pixelRatio: pixelRatio);
    if (result == null) return null;
    try {
      final file = await File(filePath).create(recursive: true);
      await file.writeAsBytes(result.bytes);
      return file.path;
    } catch (e) {
      debugPrint('[PosterExporter] exportToFile failed: $e');
      return null;
    }
  }
}

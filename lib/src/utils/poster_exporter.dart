import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/poster_export_result.dart';

/// Captures a [RepaintBoundary] identified by [exportKey] and returns PNG bytes.
///
/// ```dart
/// final exportKey = GlobalKey();
///
/// // In your widget tree:
/// PosterCanvas(controller: ctrl, exportKey: exportKey)
///
/// // To export:
/// final result = await PosterExporter.export(exportKey);
/// if (result != null) {
///   await Gal.putImageBytes(result.bytes); // save to gallery
///   // or
///   await Share.shareXFiles([XFile(filePath)]);
/// }
/// ```
class PosterExporter {
  PosterExporter._();

  /// Export the canvas as PNG bytes.
  ///
  /// [pixelRatio] controls output resolution:
  /// - 2.0 = 2× device pixels (good for sharing)
  /// - 3.0 = 3× device pixels (default, high quality)
  /// - 4.0 = 4× device pixels (print quality)
  ///
  /// Returns null if the RepaintBoundary is not found or rendering fails.
  static Future<PosterExportResult?> export(
    GlobalKey key, {
    double pixelRatio = 3.0,
  }) async {
    try {
      final boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        debugPrint('[PosterExporter] RepaintBoundary not found for key.');
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

  /// Export and save directly to [filePath] (must include .png extension).
  ///
  /// ```dart
  /// final dir = (await getTemporaryDirectory()).path;
  /// final path = await PosterExporter.exportToFile(
  ///   exportKey,
  ///   filePath: '$dir/poster_${DateTime.now().millisecondsSinceEpoch}.png',
  /// );
  /// if (path != null) {
  ///   await Share.shareXFiles([XFile(path)]);
  /// }
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

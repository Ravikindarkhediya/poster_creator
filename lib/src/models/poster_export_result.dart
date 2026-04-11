import 'dart:typed_data';

/// Result returned by [PosterExporter.export].
class PosterExportResult {
  /// Raw PNG bytes of the exported poster.
  final Uint8List bytes;

  /// Width of the exported image in pixels.
  final int width;

  /// Height of the exported image in pixels.
  final int height;

  const PosterExportResult({
    required this.bytes,
    required this.width,
    required this.height,
  });
}

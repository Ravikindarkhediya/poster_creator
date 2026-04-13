import 'dart:typed_data';

/// Result of a poster export operation.
class PosterExportResult {
  final Uint8List bytes;
  final int width;
  final int height;
  const PosterExportResult({
    required this.bytes,
    required this.width,
    required this.height,
  });
}

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../layouts/layouts.dart';
import '../layouts/poster_layout_registry.dart';
import '../models/poster_config.dart';
import '../models/poster_frame.dart';
import 'poster_sticker_item.dart';

bool _layoutsSeeded = false;

void _ensureLayouts() {
  if (!_layoutsSeeded) {
    seedBuiltInLayouts();
    _layoutsSeeded = true;
  }
}

/// The core rendering widget for [poster_creator].
///
/// Stacks layers in order:
///   0. Canvas background color
///   1. Template image (background)
///   2. Frame overlay (layout)
///   3. Leader photos strip
///   4. Party logo badge
///   5. Stickers (interactive)
///
/// Wrap in a [RepaintBoundary] with a [GlobalKey] to export as PNG via
/// [PosterExporter].
///
/// ```dart
/// final exportKey = GlobalKey();
///
/// PosterCanvas(
///   config: PosterConfig(
///     templateUrl: 'https://example.com/bg.jpg',
///     userName: 'Ravi Kumar',
///     designation: 'Ward Member',
///     frame: PosterFrame.wavyProfile(),
///   ),
///   exportKey: exportKey,
///   onStickerUpdate: (updated) => setState(() => config = config.copyWith(stickers: updated)),
/// )
/// ```
class PosterCanvas extends StatelessWidget {
  /// Full poster configuration.
  final PosterConfig config;

  /// Optional override frame — used in preview thumbnail mode so the
  /// thumbnail can show a different frame than the live canvas.
  final PosterFrame? frameOverride;

  /// When true, sticker controls (drag handles, delete button) are hidden.
  /// Use this for export and thumbnail rendering.
  final bool isPreview;

  /// Attach a [GlobalKey] to the internal [RepaintBoundary] so that
  /// [PosterExporter] can capture the canvas as PNG bytes.
  final GlobalKey? exportKey;

  /// Called whenever a sticker is moved, scaled, or rotated.
  /// Provides the updated sticker list so the parent can rebuild.
  final void Function(List<dynamic> updatedStickers)? onStickerUpdate;

  /// Called when a sticker is removed.
  final void Function(String stickerId)? onStickerRemove;

  /// Called when a sticker is tapped (selected).
  final void Function(String stickerId)? onStickerSelect;

  /// The currently selected sticker id (for highlight rendering).
  final String? selectedStickerId;

  const PosterCanvas({
    super.key,
    required this.config,
    this.frameOverride,
    this.isPreview = false,
    this.exportKey,
    this.onStickerUpdate,
    this.onStickerRemove,
    this.onStickerSelect,
    this.selectedStickerId,
  });

  // ── Aspect ratio resolution ────────────────────────────────────────────────

  Future<Size> _getImageSize(String url) {
    final completer = Completer<Size>();
    final provider = url.startsWith('http')
        ? NetworkImage(url) as ImageProvider
        : FileImage(File(url));

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
          if (!completer.isCompleted) completer.complete(const Size(1, 1));
        },
      ),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    _ensureLayouts();

    final effectiveFrame = frameOverride ?? config.frame;

    return FutureBuilder<Size>(
      future: config.aspectRatio != null
          ? Future.value(Size(config.aspectRatio!, 1))
          : _getImageSize(config.templateUrl),
      builder: (context, snapshot) {
        final double ar = config.aspectRatio ??
            (snapshot.hasData && snapshot.data != null
                ? (snapshot.data!.width / snapshot.data!.height)
                    .clamp(0.5, 2.0)
                : 1.0);

        return Center(
          child: AspectRatio(
            aspectRatio: ar,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: isPreview
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
              ),
              child: RepaintBoundary(
                key: exportKey,
                child: LayoutBuilder(
                  builder: (ctx, constraints) {
                    final double cw = constraints.maxWidth;
                    final double ch = cw / ar;
                    return SizedBox(
                      width: cw,
                      height: ch,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Layer 0: canvas background
                          Container(color: config.canvasBackgroundColor),

                          // Layer 1: template image
                          _buildTemplate(),

                          // Layer 2: frame overlay
                          if (config.showFrame && effectiveFrame != null)
                            _buildFrame(ctx, effectiveFrame, cw),

                          // Layer 3: leader photos
                          if (config.showFrame &&
                              config.leaderPhotos.isNotEmpty)
                            _buildLeaderStrip(cw),

                          // Layer 4: party logo
                          if (config.showFrame &&
                              config.partyLogoUrl != null &&
                              config.partyLogoUrl!.isNotEmpty)
                            _buildPartyLogo(cw),

                          // Layer 5: stickers
                          if (config.showStickers)
                            _buildStickerLayer(cw),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Layer builders ─────────────────────────────────────────────────────────

  Widget _buildTemplate() {
    final url = config.templateUrl;
    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(color: Colors.grey.shade100),
        errorWidget: (_, __, ___) => Container(color: Colors.grey.shade200),
      );
    } else {
      final file = File(url);
      if (file.existsSync()) {
        return Image.file(file, fit: BoxFit.cover);
      }
      return Container(color: Colors.grey.shade200);
    }
  }

  Widget _buildFrame(
      BuildContext context, PosterFrame frame, double canvasWidth) {
    final layout = PosterLayoutRegistry.resolve(frame);
    if (layout == null) return const SizedBox.shrink();
    return layout.build(
      context: context,
      config: config,
      frame: frame,
      canvasWidth: canvasWidth,
    );
  }

  Widget _buildLeaderStrip(double cw) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: cw * 0.2,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: cw * 0.04, vertical: cw * 0.02),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.98),
              Colors.white.withOpacity(0.6),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: config.leaderPhotos.map((path) {
            Widget img;
            if (path.startsWith('http')) {
              img = CachedNetworkImage(
                  imageUrl: path, fit: BoxFit.cover);
            } else {
              img = Image.file(File(path), fit: BoxFit.cover);
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: cw * 0.012),
              width: cw * 0.14,
              height: cw * 0.16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(cw * 0.015),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cw * 0.0125),
                child: img,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPartyLogo(double cw) {
    final url = config.partyLogoUrl!;
    Widget img;
    if (url.startsWith('http')) {
      img = CachedNetworkImage(imageUrl: url, fit: BoxFit.contain);
    } else {
      img = Image.file(File(url), fit: BoxFit.contain);
    }

    return Positioned(
      top: cw * 0.05,
      right: cw * 0.05,
      child: Container(
        width: cw * 0.175,
        height: cw * 0.175,
        padding: EdgeInsets.all(cw * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 15, spreadRadius: 1)
          ],
          border: Border.all(
            color: (config.frame?.backgroundColor ?? Colors.orange)
                .withOpacity(0.8),
            width: 3,
          ),
        ),
        child: ClipOval(child: img),
      ),
    );
  }

  Widget _buildStickerLayer(double canvasWidth) {
    return Stack(
      children: config.stickers.map((sticker) {
        return PosterStickerItem(
          key: ValueKey(sticker.id),
          sticker: sticker,
          canvasWidth: canvasWidth,
          isPreview: isPreview,
          isSelected: selectedStickerId == sticker.id,
          onSelect: () => onStickerSelect?.call(sticker.id),
          onDeselect: () => onStickerSelect?.call(''),
          onUpdate: (updated) {
            final list = config.stickers.map((s) {
              return s.id == updated.id ? updated : s;
            }).toList();
            onStickerUpdate?.call(list);
          },
          onRemove: () => onStickerRemove?.call(sticker.id),
        );
      }).toList(),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controllers/poster_controller.dart';
import '../layouts/all_layouts.dart';
import '../layouts/poster_layout_registry.dart';
import '../models/poster_frame_model.dart';
import 'poster_sticker_item.dart';

/// Core poster rendering widget.
///
/// Layers (bottom → top):
///   0. Canvas background color
///   1. Template image — **BoxFit.cover, fills 100% width × height**
///   2. Frame overlay
///   3. Leader photo strip
///   4. Party logo badge
///   5. Interactive stickers
///
/// Wrap in [RepaintBoundary] with [exportKey] and call
/// [PosterExporter.export(exportKey)] to get PNG bytes.
class PosterCanvas extends StatefulWidget {
  final PosterController controller;
  final PosterFrameModel? frameOverride;
  final bool isPreview;
  final GlobalKey? exportKey;

  const PosterCanvas({
    super.key,
    required this.controller,
    this.frameOverride,
    this.isPreview = false,
    this.exportKey,
  });

  @override
  State<PosterCanvas> createState() => _PosterCanvasState();
}

class _PosterCanvasState extends State<PosterCanvas> {
  double? _aspectRatio;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    seedBuiltInLayouts();
    _resolveAspectRatio();
  }

  @override
  void didUpdateWidget(PosterCanvas old) {
    super.didUpdateWidget(old);
    if (old.controller.templateUrl != widget.controller.templateUrl) {
      setState(() { _loaded = false; _aspectRatio = null; });
      _resolveAspectRatio();
    }
  }

  Future<void> _resolveAspectRatio() async {
    final url = widget.controller.templateUrl;
    if (url.isEmpty) {
      setState(() { _aspectRatio = 1.0; _loaded = true; });
      return;
    }

    final completer = Completer<Size>();
    ImageProvider provider = url.startsWith('http')
        ? NetworkImage(url)
        : FileImage(File(url)) as ImageProvider;

    provider.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, _) { if (!completer.isCompleted) completer.complete(Size(info.image.width.toDouble(), info.image.height.toDouble())); },
        onError: (_, __) { if (!completer.isCompleted) completer.complete(const Size(1, 1)); },
      ),
    );

    final size = await completer.future;
    if (mounted) {
      setState(() {
        _aspectRatio = (size.width / size.height).clamp(0.5, 2.0);
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller;
    final aspectRatio = _aspectRatio ?? 1.0;

    return Center(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: widget.isPreview ? null : [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, 10)),
            ],
          ),
          child: RepaintBoundary(
            key: widget.exportKey,
            child: ListenableBuilder(
              listenable: ctrl,
              builder: (_, __) {
                final c = ctrl.state;
                final effectiveFrame = widget.frameOverride ?? c.selectedFrame;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final double cw = constraints.maxWidth;
                    final double ch = constraints.maxHeight;

                    // Update canvas size for sticker centering
                    ctrl.updateCanvasSize(Size(cw, ch));

                    return Stack(
                      children: [
                        // Layer 0: canvas background
                        Positioned.fill(child: Container(color: c.canvasBackgroundColor)),

                        // Layer 1: template image — FULL COVER (fills entire canvas)
                        Positioned.fill(
                          child: _buildTemplateImage(ctrl.templateUrl),
                        ),

                        // Layer 2: frame overlay
                        if (c.showFrame && effectiveFrame != null)
                          Positioned.fill(child: _buildFrame(context, effectiveFrame, c, cw)),

                        // Layer 3: leader photos strip
                        if (c.showFrame && c.leaderPhotos.isNotEmpty)
                          Positioned.fill(child: _buildLeaderStrip(c, cw)),

                        // Layer 4: party logo
                        if (c.showFrame && c.partyLogoUrl != null && c.partyLogoUrl!.isNotEmpty)
                          _buildPartyLogo(c, cw),

                        // Layer 5: stickers
                        if (c.showStickers)
                          Positioned.fill(child: _buildStickerLayer(ctrl)),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ── Layer helpers ──────────────────────────────────────────────────────────

  Widget _buildTemplateImage(String url) {
    if (url.isEmpty) return Container(color: Colors.grey.shade200);

    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,     // ← FULL WIDTH & HEIGHT COVER
        width: double.infinity,
        height: double.infinity,
        placeholder: (_, __) => Container(color: Colors.grey.shade100),
        errorWidget: (_, __, ___) => Container(color: Colors.grey.shade200,
          child: const Center(child: Icon(Icons.broken_image, color: Colors.grey))),
      );
    }

    final file = File(url);
    if (file.existsSync()) {
      return Image.file(file, fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    }
    return Container(color: Colors.grey.shade200);
  }

  Widget _buildFrame(BuildContext ctx, PosterFrameModel frame, dynamic c, double cw) {
    final layout = PosterLayoutRegistry.resolve(frame);
    if (layout == null) return const SizedBox.shrink();
    return layout.build(context: ctx, c: c, canvasWidth: cw);
  }

  Widget _buildLeaderStrip(dynamic c, double cw) {
    return Positioned(
      top: 0, left: 0, right: 0, height: cw * 0.2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: cw * 0.04, vertical: cw * 0.02),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Colors.white.withOpacity(0.98), Colors.white.withOpacity(0.6)]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: c.leaderPhotos.map<Widget>((path) {
            Widget img = path.startsWith('http')
                ? CachedNetworkImage(imageUrl: path, fit: BoxFit.cover)
                : Image.file(File(path), fit: BoxFit.cover);
            return Container(
              margin: EdgeInsets.symmetric(horizontal: cw * 0.012),
              width: cw * 0.14, height: cw * 0.16,
              decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(cw * 0.015),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(cw * 0.0125), child: img),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPartyLogo(dynamic c, double cw) {
    final url = c.partyLogoUrl!;
    Widget img = url.startsWith('http')
        ? CachedNetworkImage(imageUrl: url, fit: BoxFit.contain)
        : Image.file(File(url), fit: BoxFit.contain);
    return Positioned(
      top: cw * 0.05, right: cw * 0.05,
      child: Container(
        width: cw * 0.175, height: cw * 0.175, padding: EdgeInsets.all(cw * 0.02),
        decoration: BoxDecoration(
          color: Colors.white, shape: BoxShape.circle,
          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 15, spreadRadius: 1)],
          border: Border.all(color: c.frameBackgroundColor.withOpacity(0.8), width: 3),
        ),
        child: ClipOval(child: img),
      ),
    );
  }

  Widget _buildStickerLayer(PosterController ctrl) {
    return Stack(
      children: ctrl.state.stickers.map((sticker) {
        return PosterStickerItem(
          key: ValueKey(sticker.id),
          sticker: sticker,
          canvasWidth: ctrl.canvasSize.width,
          isPreview: widget.isPreview,
          isSelected: ctrl.selectedStickerId == sticker.id,
          onSelect: () => ctrl.selectSticker(sticker.id),
          onDeselect: () => ctrl.deselectStickers(),
          onUpdate: (updated) => ctrl.updateSticker(updated),
          onRemove: () => ctrl.removeSticker(sticker.id),
        );
      }).toList(),
    );
  }
}

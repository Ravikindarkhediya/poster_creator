import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/poster_sticker.dart';

/// A single interactive sticker rendered on the canvas.
///
/// Supports:
/// - Drag to reposition
/// - Pinch to scale
/// - Rotate gesture
/// - Double-tap to edit text in-place
/// - Delete / scale handles when selected
class PosterStickerItem extends StatefulWidget {
  final PosterSticker sticker;
  final double canvasWidth;
  final bool isPreview;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onDeselect;
  final void Function(PosterSticker updated) onUpdate;
  final VoidCallback onRemove;

  const PosterStickerItem({
    super.key,
    required this.sticker,
    required this.canvasWidth,
    this.isPreview = false,
    this.isSelected = false,
    required this.onSelect,
    required this.onDeselect,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  State<PosterStickerItem> createState() => _PosterStickerItemState();
}

class _PosterStickerItemState extends State<PosterStickerItem> {
  late Offset _position;
  late double _scale;
  late double _rotation;

  double _baseScale = 1.0;
  double _baseRotation = 0.0;

  final TextEditingController _textCtrl = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _position = widget.sticker.position;
    _scale = widget.sticker.scale;
    _rotation = widget.sticker.rotation;
    if (widget.sticker.isText) {
      _textCtrl.text = widget.sticker.text ?? '';
    }
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PosterStickerItem old) {
    super.didUpdateWidget(old);
    if (old.sticker.position != widget.sticker.position) {
      _position = widget.sticker.position;
    }
    if (old.sticker.scale != widget.sticker.scale) {
      _scale = widget.sticker.scale;
    }
    if (old.sticker.rotation != widget.sticker.rotation) {
      _rotation = widget.sticker.rotation;
    }
    if (widget.sticker.isText &&
        !_isEditing &&
        widget.sticker.text != _textCtrl.text) {
      _textCtrl.text = widget.sticker.text ?? '';
    }
  }

  void _commitUpdate() {
    widget.onUpdate(widget.sticker.copyWith(
      position: _position,
      scale: _scale,
      rotation: _rotation,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final double baseW =
        widget.sticker.isText ? widget.canvasWidth * 0.6 : widget.canvasWidth * 0.3;
    final double baseH =
        widget.sticker.isText ? widget.canvasWidth * 0.25 : widget.canvasWidth * 0.3;
    const double hs = 32.0; // handle size

    final double cw = baseW * _scale;
    final double ch = baseH * _scale;

    return Positioned(
      left: _position.dx - (cw / 2) - hs,
      top: _position.dy - (ch / 2) - hs,
      child: SizedBox(
        width: cw + (hs * 2),
        height: ch + (hs * 2),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.isPreview
                  ? null
                  : () {
                      if (widget.isSelected) {
                        widget.onDeselect();
                      } else {
                        widget.onSelect();
                      }
                    },
              onDoubleTap: widget.isPreview
                  ? null
                  : () {
                      if (widget.sticker.isText) {
                        widget.onSelect();
                        setState(() => _isEditing = true);
                        _focus.requestFocus();
                      }
                    },
              onScaleStart: widget.isPreview
                  ? null
                  : (d) {
                      _baseScale = _scale;
                      _baseRotation = _rotation;
                      widget.onSelect();
                    },
              onScaleUpdate: widget.isPreview
                  ? null
                  : (d) {
                      if (_isEditing) return;
                      setState(() {
                        _position += d.focalPointDelta;
                        if (d.scale != 1.0) {
                          _scale = (_baseScale * d.scale).clamp(0.2, 5.0);
                        }
                        if (d.rotation != 0.0) {
                          _rotation = _baseRotation + d.rotation;
                        }
                      });
                      _commitUpdate();
                    },
              child: Transform.rotate(
                angle: _rotation,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // ── Sticker content ──────────────────────────────────
                    Container(
                      width: cw,
                      height: ch,
                      decoration: BoxDecoration(
                        border: (widget.isSelected && !widget.isPreview)
                            ? Border.all(
                                color: Colors.blueAccent.withOpacity(0.5),
                                width: 1.5)
                            : null,
                      ),
                      child: Center(child: _buildContent(cw)),
                    ),

                    // ── Selection handles ────────────────────────────────
                    if (widget.isSelected &&
                        !widget.isPreview &&
                        !_isEditing) ...[
                      // Delete
                      Positioned(
                        top: -hs / 4,
                        right: -hs / 4,
                        child: _Handle(
                          icon: Icons.close_rounded,
                          color: Colors.red.shade600,
                          size: hs,
                          onTap: widget.onRemove,
                        ),
                      ),
                      // Scale
                      Positioned(
                        bottom: -hs / 4,
                        right: -hs / 4,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onPanUpdate: (d) {
                            setState(() {
                              _scale =
                                  (_scale + d.delta.dx / 100).clamp(0.2, 5.0);
                            });
                            _commitUpdate();
                          },
                          child: _Handle(
                            icon: Icons.open_in_full_rounded,
                            color: Colors.blueAccent,
                            size: hs,
                          ),
                        ),
                      ),
                      // Rotate
                      Positioned(
                        top: -hs / 4,
                        left: -hs / 4,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onPanUpdate: (d) {
                            setState(() {
                              _rotation += d.delta.dx / 50;
                            });
                            _commitUpdate();
                          },
                          child: _Handle(
                            icon: Icons.rotate_right_rounded,
                            color: Colors.green,
                            size: hs,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(double cw) {
    final s = widget.sticker;

    if (s.isText) {
      if (_isEditing) {
        return TextField(
          controller: _textCtrl,
          focusNode: _focus,
          autofocus: true,
          textAlign: TextAlign.center,
          maxLines: null,
          textInputAction: TextInputAction.done,
          style: _textStyle(s, cw),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
          onChanged: (v) {
            widget.onUpdate(s.copyWith(text: v));
          },
          onSubmitted: (_) => setState(() => _isEditing = false),
          onTapOutside: (_) => setState(() => _isEditing = false),
        );
      }
      return _StickerTextFrame(sticker: s, stickerWidth: cw);
    }

    // Image sticker
    if (s.isLocal) {
      return Image.file(
        File(s.assetUrl),
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image, color: Colors.grey),
      );
    }
    return CachedNetworkImage(
      imageUrl: s.assetUrl,
      fit: BoxFit.contain,
      placeholder: (_, __) =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      errorWidget: (_, __, ___) =>
          const Icon(Icons.broken_image, color: Colors.grey),
    );
  }

  TextStyle _textStyle(PosterSticker s, double stickerWidth) {
    try {
      return GoogleFonts.getFont(
        s.fontFamily,
        color: s.textColor,
        fontWeight: s.isBold ? FontWeight.bold : _fwFromInt(s.fontWeight),
        fontStyle: s.isItalic ? FontStyle.italic : FontStyle.normal,
        fontSize: s.fontSize > 0 ? s.fontSize : stickerWidth * 0.15,
        height: 1.05,
        letterSpacing: s.letterSpacing,
      );
    } catch (_) {
      return TextStyle(
        color: s.textColor,
        fontSize: s.fontSize > 0 ? s.fontSize : stickerWidth * 0.15,
      );
    }
  }

  FontWeight _fwFromInt(int v) {
    switch (v) {
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
      default:
        return FontWeight.w700;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Text frame renderer
// ─────────────────────────────────────────────────────────────────────────────

class _StickerTextFrame extends StatelessWidget {
  final PosterSticker sticker;
  final double stickerWidth;

  const _StickerTextFrame(
      {required this.sticker, required this.stickerWidth});

  @override
  Widget build(BuildContext context) {
    final s = sticker;
    final fw = _fwFromInt(s.fontWeight);
    final hasBorder = s.borderColor != null && s.borderWidth > 0;
    final shadow = s.shadowEnabled
        ? [
            BoxShadow(
              color: s.shadowColor.withOpacity(0.55),
              blurRadius: s.shadowBlur,
              offset: const Offset(0, 3),
            )
          ]
        : null;

    TextStyle style;
    try {
      style = GoogleFonts.getFont(
        s.fontFamily,
        color: s.textColor,
        fontWeight: s.isBold ? FontWeight.bold : fw,
        fontStyle: s.isItalic ? FontStyle.italic : FontStyle.normal,
        fontSize: s.fontSize > 0 ? s.fontSize : stickerWidth * 0.15,
        letterSpacing: s.letterSpacing,
        height: 1.05,
        shadows: s.shadowEnabled
            ? [
                Shadow(
                  color: s.shadowColor.withOpacity(0.55),
                  blurRadius: s.shadowBlur,
                  offset: const Offset(0, 3),
                )
              ]
            : null,
      );
    } catch (_) {
      style = TextStyle(
        color: s.textColor,
        fontSize: s.fontSize > 0 ? s.fontSize : stickerWidth * 0.15,
      );
    }

    Widget text;
    if (s.socialPlatform != null && s.socialPlatform!.isNotEmpty) {
      text = _buildSocialRow(s, style);
    } else {
      text = Text(
        s.text ?? '',
        textAlign: TextAlign.center,
        maxLines: 4,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: style,
      );
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: s.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(stickerWidth * 0.12),
        border: hasBorder
            ? Border.all(color: s.borderColor!, width: s.borderWidth)
            : null,
        boxShadow: shadow,
      ),
      child: Center(
        child: FittedBox(fit: BoxFit.scaleDown, child: text),
      ),
    );
  }

  Widget _buildSocialRow(PosterSticker s, TextStyle style) {
    final platform = s.socialPlatform!;
    final IconData icon;
    switch (platform) {
      case 'facebook':
        icon = Icons.facebook_rounded;
        break;
      case 'instagram':
        icon = Icons.camera_alt_rounded;
        break;
      case 'whatsapp':
        icon = Icons.chat_rounded;
        break;
      default:
        icon = Icons.link_rounded;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: (style.fontSize ?? 18) * 1.3, color: style.color),
        const SizedBox(width: 6),
        Text(
          s.text ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
      ],
    );
  }

  FontWeight _fwFromInt(int v) {
    switch (v) {
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
      default:
        return FontWeight.w700;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Drag handle widget
// ─────────────────────────────────────────────────────────────────────────────

class _Handle extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback? onTap;

  const _Handle({
    required this.icon,
    required this.color,
    required this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}

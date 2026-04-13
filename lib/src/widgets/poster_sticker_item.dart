import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/poster_sticker_model.dart';

class PosterStickerItem extends StatefulWidget {
  final PosterStickerModel sticker;
  final double canvasWidth;
  final bool isPreview;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onDeselect;
  final void Function(PosterStickerModel) onUpdate;
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
  late Offset _pos;
  late double _scale, _rot;
  double _baseScale = 1.0, _baseRot = 0.0;

  final _textCtrl = TextEditingController();
  final _focus = FocusNode();
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _pos = widget.sticker.position;
    _scale = widget.sticker.scale;
    _rot = widget.sticker.rotation;
    if (widget.sticker.isText) _textCtrl.text = widget.sticker.text ?? '';
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
    if (old.sticker.position != widget.sticker.position)
      _pos = widget.sticker.position;
    if (old.sticker.scale != widget.sticker.scale)
      _scale = widget.sticker.scale;
    if (old.sticker.rotation != widget.sticker.rotation)
      _rot = widget.sticker.rotation;
    if (widget.sticker.isText &&
        !_editing &&
        widget.sticker.text != _textCtrl.text) {
      _textCtrl.text = widget.sticker.text ?? '';
    }
  }

  void _commit() => widget.onUpdate(
    widget.sticker.copyWith(position: _pos, scale: _scale, rotation: _rot),
  );

  @override
  Widget build(BuildContext context) {
    final s = widget.sticker;
    final double bw = s.isText
        ? widget.canvasWidth * 0.6
        : widget.canvasWidth * 0.3;
    final double bh = s.isText
        ? widget.canvasWidth * 0.25
        : widget.canvasWidth * 0.3;
    const hs = 32.0;
    final cw = bw * _scale;
    final ch = bh * _scale;

    return Positioned(
      left: _pos.dx - cw / 2 - hs,
      top: _pos.dy - ch / 2 - hs,
      child: SizedBox(
        width: cw + hs * 2,
        height: ch + hs * 2,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.isPreview
                  ? null
                  : () => widget.isSelected
                        ? widget.onDeselect()
                        : widget.onSelect(),
              onDoubleTap: widget.isPreview
                  ? null
                  : () {
                      if (s.isText) {
                        widget.onSelect();
                        setState(() => _editing = true);
                        _focus.requestFocus();
                      }
                    },
              onScaleStart: widget.isPreview
                  ? null
                  : (d) {
                      _baseScale = _scale;
                      _baseRot = _rot;
                      widget.onSelect();
                    },
              onScaleUpdate: widget.isPreview
                  ? null
                  : (d) {
                      if (_editing) return;
                      setState(() {
                        _pos += d.focalPointDelta;
                        if (d.scale != 1.0)
                          _scale = (_baseScale * d.scale).clamp(0.2, 5.0);
                        if (d.rotation != 0.0) _rot = _baseRot + d.rotation;
                      });
                      _commit();
                    },
              child: Transform.rotate(
                angle: _rot,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: cw,
                      height: ch,
                      decoration: BoxDecoration(
                        border: (widget.isSelected && !widget.isPreview)
                            ? Border.all(
                                color: Colors.blueAccent.withOpacity(0.5),
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Center(child: _buildContent(cw)),
                    ),
                    if (widget.isSelected &&
                        !widget.isPreview &&
                        !_editing) ...[
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
                      Positioned(
                        bottom: -hs / 4,
                        right: -hs / 4,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onPanUpdate: (d) {
                            setState(
                              () => _scale = (_scale + d.delta.dx / 100).clamp(
                                0.2,
                                5.0,
                              ),
                            );
                            _commit();
                          },
                          child: _Handle(
                            icon: Icons.open_in_full_rounded,
                            color: Colors.blueAccent,
                            size: hs,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -hs / 4,
                        left: -hs / 4,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onPanUpdate: (d) {
                            setState(() => _rot += d.delta.dx / 50);
                            _commit();
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
      if (_editing) {
        return TextField(
          controller: _textCtrl,
          focusNode: _focus,
          autofocus: true,
          textAlign: TextAlign.center,
          maxLines: null,
          textInputAction: TextInputAction.done,
          style: _buildTextStyle(s, cw),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
          onChanged: (v) => widget.onUpdate(s.copyWith(text: v)),
          onSubmitted: (_) => setState(() => _editing = false),
          onTapOutside: (_) => setState(() => _editing = false),
        );
      }
      return _StickerText(sticker: s, stickerWidth: cw);
    }
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

  TextStyle _buildTextStyle(PosterStickerModel s, double sw) {
    try {
      return GoogleFonts.getFont(
        s.fontFamily,
        color: s.textColor,
        fontWeight: s.isBold ? FontWeight.bold : _fw(s.fontWeight),
        fontStyle: s.isItalic ? FontStyle.italic : FontStyle.normal,
        fontSize: s.fontSize > 0 ? s.fontSize : sw * 0.15,
        height: 1.05,
        letterSpacing: s.letterSpacing,
      );
    } catch (_) {
      return TextStyle(
        color: s.textColor,
        fontSize: s.fontSize > 0 ? s.fontSize : sw * 0.15,
      );
    }
  }

  FontWeight _fw(int v) {
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

class _StickerText extends StatelessWidget {
  final PosterStickerModel sticker;
  final double stickerWidth;
  const _StickerText({required this.sticker, required this.stickerWidth});

  @override
  Widget build(BuildContext context) {
    final s = sticker;
    final hasBorder = s.borderColor != null && s.borderWidth > 0;
    final shadow = s.shadowEnabled
        ? [
            BoxShadow(
              color: s.shadowColor.withOpacity(0.55),
              blurRadius: s.shadowBlur,
              offset: const Offset(0, 3),
            ),
          ]
        : null;

    TextStyle style;
    try {
      style = GoogleFonts.getFont(
        s.fontFamily,
        color: s.textColor,
        fontWeight: s.isBold ? FontWeight.bold : _fw(s.fontWeight),
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
                ),
              ]
            : null,
      );
    } catch (_) {
      style = TextStyle(
        color: s.textColor,
        fontSize: s.fontSize > 0 ? s.fontSize : stickerWidth * 0.15,
      );
    }

    Widget content = s.socialPlatform != null && s.socialPlatform!.isNotEmpty
        ? _socialRow(s, style)
        : Text(
            s.text ?? '',
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: style,
          );

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
        child: FittedBox(fit: BoxFit.scaleDown, child: content),
      ),
    );
  }

  Widget _socialRow(PosterStickerModel s, TextStyle style) {
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

  FontWeight _fw(int v) {
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
  Widget build(BuildContext context) => GestureDetector(
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

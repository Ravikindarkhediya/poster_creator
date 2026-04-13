import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/poster_controller.dart';
import '../models/poster_sticker_model.dart';
import '../models/poster_text_style_preset.dart';

// ─────────────────────────────────────────────────────────────────────────────
// TEXT TAB
// ─────────────────────────────────────────────────────────────────────────────

class PosterTextTab extends StatelessWidget {
  final PosterController controller;
  final ScrollController? scrollController;
  const PosterTextTab({super.key, required this.controller, this.scrollController});

  static final _paletteColors = <Color>[Colors.white, Colors.black, Colors.blueAccent, const Color(0xFF6D28D9), const Color(0xFFDC2626), const Color(0xFF16A34A), const Color(0xFFFF9933)];
  static final _bgColors = <Color>[const Color(0xFF000000), const Color(0xFFFFFFFF), const Color(0xFF2196F3), const Color(0xFF4CAF50), const Color(0xFFFF9800), const Color(0xFFF44336), const Color(0xFF9C27B0)];
  static const _fonts = ['Poppins','Roboto','Noto Sans','Baloo 2','Hind','Mukta','Rajdhani','Tiro Devanagari Hindi','Martel','Kalam','Amita','Yatra One'];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        final selId = controller.selectedStickerId;
        final sel = controller.selectedSticker;
        final editing = sel != null && sel.isText && (sel.socialPlatform == null || sel.socialPlatform!.isEmpty);

        return SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: editing ? _editPanel(context, sel!) : _emptyState(context),
          ),
        );
      },
    );
  }

  Widget _emptyState(BuildContext ctx) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('SELECT STYLE TO ADD TEXT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueAccent, letterSpacing: 1.2)),
    const SizedBox(height: 12),
    SizedBox(height: 34, child: ListView.separated(
      scrollDirection: Axis.horizontal, itemCount: PosterTextStylePreset.all.length,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (_, i) {
        final p = PosterTextStylePreset.all[i];
        return GestureDetector(onTap: () => controller.addTextSticker('Double-tap to edit', style: p),
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
            child: Center(child: Text(p.frameId.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.black87)))));
      })),
  ]);

  Widget _editPanel(BuildContext ctx, PosterStickerModel s) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('TEXT PRESETS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueAccent)),
    const SizedBox(height: 8),
    SizedBox(height: 34, child: ListView.separated(
      scrollDirection: Axis.horizontal, itemCount: PosterTextStylePreset.all.length,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (_, i) {
        final p = PosterTextStylePreset.all[i];
        final active = p.frameId == s.frameId;
        return GestureDetector(onTap: () => controller.updateSelectedStickerStyle(p),
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: active ? Colors.blueAccent : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: active ? Colors.blueAccent : Colors.grey.shade300)),
            child: Center(child: Text(p.frameId.toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: active ? Colors.white : Colors.black87)))));
      })),
    const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
    const Text('CHOOSE FONT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueAccent, letterSpacing: 1.0)),
    const SizedBox(height: 10),
    SizedBox(height: 52, child: ListView.builder(
      scrollDirection: Axis.horizontal, itemCount: _fonts.length,
      itemBuilder: (_, i) {
        final font = _fonts[i]; final isSel = s.fontFamily == font;
        return GestureDetector(
          onTap: () => controller.updateSticker(s.copyWith(fontFamily: font)),
          child: AnimatedContainer(duration: const Duration(milliseconds: 200), width: 50, margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: isSel ? Colors.blueAccent : Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: isSel ? Colors.blueAccent : Colors.grey.shade300, width: 1)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Aa', style: GoogleFonts.getFont(font, textStyle: TextStyle(fontSize: 16, color: isSel ? Colors.white : Colors.black87, fontWeight: FontWeight.bold))),
              Text(font, style: TextStyle(fontSize: 6.5, color: isSel ? Colors.white.withOpacity(0.9) : Colors.grey.shade600), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
            ])));
      })),
    const SizedBox(height: 12),
    Row(children: [
      const Text('SIZE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
      Expanded(child: SliderTheme(data: SliderTheme.of(ctx).copyWith(trackHeight: 2, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6)),
        child: Slider(value: s.fontSize.clamp(8, 100), min: 8, max: 100, onChanged: (v) => controller.updateSelectedStickerFontSize(v)))),
      Text('${s.fontSize.toInt()}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    ]),
    const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
    const Text('TEXT COLOR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueAccent)),
    const SizedBox(height: 8),
    _colorRow(ctx, _paletteColors, s.textColor, true, (c) => controller.updateSticker(s.copyWith(textColor: c))),
    const SizedBox(height: 12),
    const Text('BACKGROUND COLOR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueAccent)),
    const SizedBox(height: 8),
    _colorRow(ctx, _bgColors, s.backgroundColor ?? Colors.transparent, true,
      (c) => controller.updateSticker(s.copyWith(backgroundColor: c == Colors.transparent ? null : c))),
  ]);

  Widget _colorRow(BuildContext ctx, List<Color> colors, Color active, bool showClear, void Function(Color) onTap) {
    return SizedBox(height: 32, child: ListView.builder(
      scrollDirection: Axis.horizontal, itemCount: colors.length + 1 + (showClear ? 1 : 0),
      itemBuilder: (_, i) {
        if (showClear && i == 0) {
          final none = active == Colors.transparent;
          return GestureDetector(onTap: () => onTap(Colors.transparent),
            child: Container(width: 32, margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: none ? Colors.blueAccent : Colors.grey.shade300, width: none ? 2 : 1)),
              child: Icon(Icons.format_color_reset_outlined, size: 18, color: none ? Colors.blueAccent : Colors.grey.shade400)));
        }
        final ci = showClear ? i - 1 : i;
        if (ci == colors.length) {
          return GestureDetector(onTap: () => _pickCustomColor(ctx, active, onTap),
            child: Container(width: 32, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const SweepGradient(colors: [Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.red]), border: Border.all(color: Colors.grey.shade300)),
              child: const Icon(Icons.colorize_rounded, size: 16, color: Colors.white)));
        }
        final c = colors[ci]; final isSel = c.value == active.value;
        return GestureDetector(onTap: () => onTap(c),
          child: Container(width: 32, margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: c, shape: BoxShape.circle, border: Border.all(color: isSel ? Colors.blueAccent : Colors.grey.shade300, width: isSel ? 2 : 1)),
            child: isSel ? const Icon(Icons.check, size: 16, color: Colors.white) : null));
      }));
  }

  void _pickCustomColor(BuildContext ctx, Color init, void Function(Color) cb) {
    showDialog(context: ctx, builder: (_) => AlertDialog(
      content: SingleChildScrollView(child: ColorPicker(pickerColor: init == Colors.transparent ? Colors.white : init, onColorChanged: cb)),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('DONE'))],
    ));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STICKER TAB
// ─────────────────────────────────────────────────────────────────────────────

class PosterStickerTab extends StatelessWidget {
  final PosterController controller;
  final ScrollController? scrollController;

  /// Optional: list of sticker URLs to show in the grid.
  final List<String> stickerUrls;

  const PosterStickerTab({
    super.key,
    required this.controller,
    this.scrollController,
    this.stickerUrls = const [],
  });

  Future<void> _pickCustom() async {
    final f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f != null) controller.addSticker(f.path, isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        final stickers = controller.state.stickers;
        return CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(children: [
                Text('${stickers.length} sticker(s)', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                const Spacer(),
                if (stickers.isNotEmpty)
                  TextButton.icon(
                    onPressed: () => _confirmClear(context),
                    icon: const Icon(Icons.clear_all_rounded, size: 14, color: Colors.red),
                    label: const Text('CLEAR', style: TextStyle(fontSize: 9, color: Colors.red, fontWeight: FontWeight.bold)),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero)),
              ]),
            )),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1),
                delegate: SliverChildBuilderDelegate((_, i) {
                  if (i == 0) return _addBtn();
                  final url = stickerUrls[i - 1];
                  return _stickerCell(url, () => controller.addSticker(url));
                }, childCount: stickerUrls.length + 1),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        );
      },
    );
  }

  Widget _addBtn() => InkWell(onTap: _pickCustom, borderRadius: BorderRadius.circular(15),
    child: Container(decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.blue.shade100, width: 2)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.add_photo_alternate_rounded, color: Colors.blue.shade700, size: 28),
        const SizedBox(height: 4),
        Text('ADD', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.blue.shade700)),
      ])));

  Widget _stickerCell(String url, VoidCallback onTap) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12),
    child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade100, width: 1.5)),
      child: url.startsWith('http')
          ? CachedNetworkImage(imageUrl: url, fit: BoxFit.contain,
              placeholder: (_, __) => const Center(child: CircularProgressIndicator(strokeWidth: 1)),
              errorWidget: (_, __, ___) => const Icon(Icons.broken_image, size: 18))
          : Image.file(File(url), fit: BoxFit.contain)));

  void _confirmClear(BuildContext ctx) {
    showDialog(context: ctx, builder: (_) => AlertDialog(
      title: const Text('Clear All Stickers', style: TextStyle(fontWeight: FontWeight.bold)),
      content: const Text('Remove all stickers from the poster?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL')),
        TextButton(onPressed: () { controller.clearAllStickers(); Navigator.pop(ctx); },
          child: const Text('CLEAR', style: TextStyle(color: Colors.red))),
      ],
    ));
  }
}

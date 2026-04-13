// poster_color_tab.dart — exported from poster_creator.dart
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../controllers/poster_controller.dart';
import '../models/poster_frame_model.dart';

class PosterColorTab extends StatelessWidget {
  final PosterController controller;
  final ScrollController? scrollController;

  const PosterColorTab({super.key, required this.controller, this.scrollController});

  static final _palette = <Color>[
    Colors.white, Colors.black, Colors.blueAccent,
    const Color(0xFF6D28D9), const Color(0xFFDC2626), const Color(0xFF16A34A),
    const Color(0xFFFF9933), const Color(0xFFFACC15), const Color(0xFF0EA5E9), const Color(0xFFD946EF),
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        final c = controller.state;
        final frameId = c.selectedFrame?.type.name ?? 'default';
        final rows = _rowsForFrame(frameId);
        return SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows.map((row) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(row['label']!),
                  const SizedBox(height: 6),
                  _colorRow(context, type: row['type']!),
                  const SizedBox(height: 15),
                ],
              )).toList(),
            ),
          ),
        );
      },
    );
  }

  List<Map<String, String>> _rowsForFrame(String fid) {
    switch (fid) {
      case 'wavyProfile': case 'wavyProfileTop':
        return [{'type': 'frame_bg', 'label': 'FRAME BACKGROUND'}, {'type': 'text_color_1', 'label': 'NAME COLOR'}, {'type': 'text_color_2', 'label': 'DESIGNATION COLOR'}];
      case 'modernAngled': case 'modernAngledTop': case 'sleekRibbon': case 'sleekRibbonTop':
        return [{'type': 'frame_bg', 'label': 'MAIN RIBBON COLOR'}, {'type': 'text', 'label': 'MAIN TEXT COLOR'}, {'type': 'color_1', 'label': 'SECONDARY COLOR'}, {'type': 'text_color_1', 'label': 'SECONDARY TEXT COLOR'}];
      case 'cleanBar': case 'cleanBarTop':
        return [{'type': 'color_1', 'label': 'TOP STRIP'}, {'type': 'text_color_1', 'label': 'NAME COLOR'}, {'type': 'frame_bg', 'label': 'BOTTOM STRIP'}, {'type': 'text_color_2', 'label': 'DESIGNATION COLOR'}];
      case 'footerStrip': case 'footerStripTop':
        return [{'type': 'color_1', 'label': 'STRIP COLOR 1'}, {'type': 'color_2', 'label': 'STRIP COLOR 2'}, {'type': 'text_color_1', 'label': 'NAME COLOR'}, {'type': 'text_color_2', 'label': 'DESIGNATION COLOR'}];
      case 'floatingCard': case 'floatingCardTop':
        return [{'type': 'color_1', 'label': 'CARD BACKGROUND'}, {'type': 'text_color_1', 'label': 'NAME COLOR'}, {'type': 'text_color_2', 'label': 'DESIGNATION COLOR'}];
      case 'saffronPride': case 'saffronPrideTop': case 'simpleFull': case 'arcReveal':
        return [{'type': 'color_1', 'label': 'GRADIENT START'}, {'type': 'color_2', 'label': 'GRADIENT END'}, {'type': 'text_color_1', 'label': 'NAME COLOR'}, {'type': 'text_color_2', 'label': 'DESIGNATION COLOR'}];
      case 'tricolorStrip': case 'tricolorStripTop':
        return [{'type': 'color_1', 'label': 'TOP STRIP (SAFFRON)'}, {'type': 'color_2', 'label': 'MIDDLE STRIP'}, {'type': 'text_color_1', 'label': 'NAME COLOR'}, {'type': 'color_3', 'label': 'BOTTOM STRIP (GREEN)'}];
      case 'rajnetaPremium': case 'rajnetaPremiumTop':
        return [{'type': 'color_1', 'label': 'FOOTER BACKGROUND'}, {'type': 'color_2', 'label': 'ACCENT LINE'}, {'type': 'text_color_1', 'label': 'NAME COLOR'}, {'type': 'text_color_2', 'label': 'DESIGNATION COLOR'}];
      case 'rajnetaModern': case 'rajnetaClassic': case 'rajnetaClassicTop': case 'wavyEdge':
        return [{'type': 'color_1', 'label': 'COLOR'}, {'type': 'text_color_1', 'label': 'NAME COLOR'}, {'type': 'text_color_2', 'label': 'DESIGNATION COLOR'}];
      case 'diagonalSlash': case 'premiumGlassCard': case 'centerStage': case 'cornerBadge': case 'dualTone': case 'triColorModern':
        return [{'type': 'color_1', 'label': 'COLOR 1'}, {'type': 'color_2', 'label': 'COLOR 2'}, {'type': 'text_color_1', 'label': 'NAME COLOR'}, {'type': 'text_color_2', 'label': 'DESIGNATION COLOR'}];
      default:
        return [{'type': 'frame_bg', 'label': 'FRAME BACKGROUND'}, {'type': 'canvas_bg', 'label': 'CANVAS BACKGROUND'}, {'type': 'text', 'label': 'TEXT COLOR'}];
    }
  }

  Widget _header(String t) => Text(t, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.blue.shade800, letterSpacing: 1.2));

  Widget _colorRow(BuildContext ctx, {required String type}) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        final c = controller.state;
        Color active;
        void Function(Color) onTap;
        switch (type) {
          case 'frame_bg': active = c.frameBackgroundColor; onTap = controller.updateFrameBackgroundColor; break;
          case 'canvas_bg': active = c.canvasBackgroundColor; onTap = controller.updateCanvasBackgroundColor; break;
          case 'text': active = c.textColor; onTap = controller.updateTextColor; break;
          case 'color_1': active = c.frameColor1; onTap = controller.updateFrameColor1; break;
          case 'color_2': active = c.frameColor2; onTap = controller.updateFrameColor2; break;
          case 'color_3': active = c.frameColor3; onTap = controller.updateFrameColor3; break;
          case 'text_color_1': active = c.frameTextColor1; onTap = controller.updateFrameTextColor1; break;
          case 'text_color_2': active = c.frameTextColor2; onTap = controller.updateFrameTextColor2; break;
          default: active = Colors.white; onTap = (_) {};
        }
        return _palette2(ctx, active: active, onTap: onTap);
      },
    );
  }

  Widget _palette2(BuildContext ctx, {required Color active, required void Function(Color) onTap}) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _palette.length + 2,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          if (i == 0) {
            final isNone = active == Colors.transparent;
            return GestureDetector(onTap: () => onTap(Colors.transparent),
              child: Container(width: 36,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white,
                  border: Border.all(color: isNone ? Colors.blueAccent : Colors.grey.shade300, width: isNone ? 2 : 1)),
                child: Icon(Icons.format_color_reset_outlined, size: 18, color: isNone ? Colors.blueAccent : Colors.grey.shade400)));
          }
          if (i == _palette.length + 1) {
            return GestureDetector(onTap: () => _pickCustom(ctx, active, onTap),
              child: Container(width: 36, decoration: BoxDecoration(shape: BoxShape.circle,
                gradient: const SweepGradient(colors: [Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.red]),
                border: Border.all(color: Colors.grey.shade300)),
                child: const Icon(Icons.colorize_rounded, size: 18, color: Colors.white)));
          }
          final col = _palette[i - 1];
          final isSel = col.value == active.value;
          return GestureDetector(onTap: () => onTap(col),
            child: Container(width: 36,
              decoration: BoxDecoration(color: col, shape: BoxShape.circle,
                border: Border.all(color: isSel ? Colors.blueAccent : Colors.grey.shade300, width: isSel ? 2 : 1)),
              child: isSel ? const Icon(Icons.check, size: 18, color: Colors.white) : null));
        },
      ),
    );
  }

  void _pickCustom(BuildContext ctx, Color init, void Function(Color) cb) {
    showDialog(context: ctx, builder: (_) => AlertDialog(
      content: SingleChildScrollView(child: ColorPicker(pickerColor: init == Colors.transparent ? Colors.white : init, onColorChanged: cb)),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('DONE'))],
    ));
  }
}

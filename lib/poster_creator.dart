/// poster_creator — Production-ready poster creation package.
///
/// ## Minimal usage (all-in-one screen)
/// ```dart
/// import 'package:poster_creator/poster_creator.dart';
///
/// PosterEditorScreen(
///   templateUrl: 'https://example.com/bg.jpg',
///   userName: 'Ramesh Patel',
///   designation: 'Ward Member',
///   onExport: (result) async {
///     await Gal.putImageBytes(result.bytes);
///   },
/// )
/// ```
///
/// ## Manual usage with controller
/// ```dart
/// final ctrl = PosterController(templateUrl: 'https://example.com/bg.jpg');
/// PosterCanvas(controller: ctrl, exportKey: myKey)
/// final result = await PosterExporter.export(myKey);
/// ```
library poster_creator;

// ── Models ──────────────────────────────────────────────────────────────────
export 'src/models/poster_frame_model.dart';
export 'src/models/poster_sticker_model.dart';
export 'src/models/poster_customization.dart';
// export 'src/models/poster_text_style_preset.dart';
export 'src/models/poster_export_result.dart';

// ── Controller ───────────────────────────────────────────────────────────────
export 'src/controllers/poster_controller.dart';

// ── Core Widgets ─────────────────────────────────────────────────────────────
export 'src/widgets/poster_canvas.dart';
export 'src/widgets/poster_sticker_item.dart';
export 'src/widgets/poster_editor_screen.dart';

// ── Frame picker (standalone horizontal list) ────────────────────────────────
export 'src/widgets/poster_tabs_bundle.dart' show PosterFramePicker;

// ── Editor Tabs (use individually if building custom UI) ──────────────────────
export 'src/tabs/poster_color_tab.dart';
export 'src/widgets/poster_tabs_bundle.dart'
    show PosterFontTab, PosterPhotoTab, PosterFrameTab, PosterProfileTab;
export 'src/tabs/poster_text_sticker_tabs.dart';

// ── Layouts (for custom frame registration) ───────────────────────────────────
export 'src/layouts/base_poster_layout.dart';
export 'src/layouts/poster_layout_registry.dart';
export 'src/layouts/all_layouts.dart' show seedBuiltInLayouts;

// ── Utils ────────────────────────────────────────────────────────────────────
export 'src/utils/poster_exporter.dart';
export 'src/utils/poster_image_helper.dart';

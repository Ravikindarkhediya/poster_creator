/// poster_creator — A fully customizable poster-creation package for Flutter.
///
/// ## Quick start
/// ```dart
/// PosterCanvas(
///   config: PosterConfig(
///     templateUrl: 'https://example.com/template.jpg',
///     userName: 'Ramesh Patel',
///     designation: 'Gram Panchayat Member',
///     profileImagePath: '/path/to/photo.jpg',
///     frame: PosterFrame.wavyProfile(),
///   ),
/// )
/// ```
library poster_creator;

// ── Models ──────────────────────────────────────────────────────────────────
export 'src/models/poster_config.dart';
export 'src/models/poster_frame.dart';
export 'src/models/poster_sticker.dart';
export 'src/models/poster_text_style.dart';
export 'src/models/poster_social_handle.dart';
export 'src/models/poster_export_result.dart';

// ── Core Widget ─────────────────────────────────────────────────────────────
export 'src/widgets/poster_canvas.dart';
export 'src/widgets/poster_sticker_item.dart';

// ── Layouts (frame renderers) ────────────────────────────────────────────────
export 'src/layouts/poster_layout_registry.dart';
export 'src/layouts/base_poster_layout.dart';

// ── Built-in Layouts ─────────────────────────────────────────────────────────
export 'src/layouts/layouts.dart';

// ── Utilities ────────────────────────────────────────────────────────────────
export 'src/utils/poster_exporter.dart';
export 'src/utils/poster_image_helper.dart';

import 'base_poster_layout.dart';
import '../models/poster_frame_model.dart';

/// Registry mapping frame ids to layout builders.
/// Built-in layouts are seeded automatically by [PosterCanvas].
/// Register custom layouts before using them.
class PosterLayoutRegistry {
  PosterLayoutRegistry._();
  static final Map<String, BasePosterLayout> _r = {};

  static void register(String key, BasePosterLayout layout) => _r[key] = layout;
  static void registerAll(Map<String, BasePosterLayout> m) => _r.addAll(m);
  static BasePosterLayout? resolve(PosterFrameModel frame) =>
      _r[frame.registryKey];
}

import 'base_poster_layout.dart';
import '../models/poster_frame.dart';

/// Maintains a mapping from frame registry keys to layout builders.
///
/// All built-in layouts are registered automatically when the package is used.
/// You can register custom layouts:
///
/// ```dart
/// PosterLayoutRegistry.register(
///   'my_custom_layout',
///   MyCustomLayout(),
/// );
/// ```
class PosterLayoutRegistry {
  PosterLayoutRegistry._();

  static final Map<String, BasePosterLayout> _registry = {};

  /// Register a custom layout under [key].
  /// Overwrites any previously registered layout for that key.
  static void register(String key, BasePosterLayout layout) {
    _registry[key] = layout;
  }

  /// Look up the layout for [frame]. Returns null if unregistered.
  static BasePosterLayout? resolve(PosterFrame frame) {
    return _registry[frame.registryKey];
  }

  /// Register multiple layouts at once.
  static void registerAll(Map<String, BasePosterLayout> layouts) {
    _registry.addAll(layouts);
  }

  /// Internal: called once by [PosterCanvas] to seed built-in layouts.
  static void _seedBuiltIns(Map<String, BasePosterLayout> builtIns) {
    for (final entry in builtIns.entries) {
      _registry.putIfAbsent(entry.key, () => entry.value);
    }
  }
}

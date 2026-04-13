import 'dart:io';
import 'package:flutter/material.dart';
import '../models/poster_customization.dart' hide PosterTextStylePreset;
import '../models/poster_frame_model.dart';
import '../models/poster_sticker_model.dart';
import '../models/poster_text_style_preset.dart';

/// Main controller for all poster state.
///
/// Use with [ListenableBuilder] or [AnimatedBuilder] to rebuild UI on changes.
/// No GetX required — works with vanilla Flutter.
///
/// ```dart
/// final ctrl = PosterController(templateUrl: 'https://...');
/// ListenableBuilder(listenable: ctrl, builder: (_, __) => PosterCanvas(controller: ctrl))
/// ```
class PosterController extends ChangeNotifier {
  // ── Template ───────────────────────────────────────────────────────────────
  final String templateUrl;

  PosterController({
    required this.templateUrl,
    PosterCustomization? initial,
  }) : _state = initial ?? const PosterCustomization();

  // ── State ──────────────────────────────────────────────────────────────────
  PosterCustomization _state;
  PosterCustomization get state => _state;

  PosterCustomization? _backup;

  /// Backup state (for revert on cancel).
  void backupState() => _backup = _state;

  /// Revert to last backup.
  void revertState() {
    if (_backup != null) {
      _state = _backup!;
      notifyListeners();
    }
  }

  // ── Selected sticker ────────────────────────────────────────────────────────
  String _selectedStickerId = '';
  String get selectedStickerId => _selectedStickerId;

  void selectSticker(String id) {
    _selectedStickerId = id;
    notifyListeners();
  }

  void deselectStickers() {
    _selectedStickerId = '';
    notifyListeners();
  }

  // ── Active font field ──────────────────────────────────────────────────────
  String _activeFontField = 'name'; // 'name' | 'designation'
  String get activeFontField => _activeFontField;
  set activeFontField(String v) {
    _activeFontField = v;
    notifyListeners();
  }

  // ── Canvas size (updated by PosterCanvas) ──────────────────────────────────
  Size _canvasSize = const Size(400, 400);
  Size get canvasSize => _canvasSize;
  void updateCanvasSize(Size s) {
    if (s != _canvasSize) {
      _canvasSize = s;
      // Don't notify — internal only, avoids rebuild loop
    }
  }

  // ── Private update helper ──────────────────────────────────────────────────
  void _update(PosterCustomization Function(PosterCustomization c) fn) {
    _state = fn(_state);
    notifyListeners();
  }

  // ── Profile ────────────────────────────────────────────────────────────────
  void updatePhoto(String path) => _update((c) => c.copyWith(
        profileImagePath: path,
        originalProfileImagePath: path,
        isBackgroundRemoved: false,
      ));

  void toggleProfileImage(bool v) => _update((c) => c.copyWith(showProfileImage: v));

  void setBackgroundRemoved(bool v, {String? processedPath}) => _update((c) => c.copyWith(
        isBackgroundRemoved: v,
        profileImagePath: v && processedPath != null
            ? processedPath
            : (!v ? c.originalProfileImagePath : c.profileImagePath),
      ));

  // ── Text ───────────────────────────────────────────────────────────────────
  void updateUserName(String v) => _update((c) => c.copyWith(userName: v));
  void updateDesignation(String v) => _update((c) => c.copyWith(designation: v));
  void updatePartyName(String v) => _update((c) => c.copyWith(partyName: v));
  void updateNameFont(String family) => _update((c) => c.copyWith(nameFontFamily: family));
  void updateDesignationFont(String family) => _update((c) => c.copyWith(designationFontFamily: family));

  void updateNameFontSize(double size) {
    final max = getMaxFontSize('name');
    _update((c) => c.copyWith(nameFontSize: size.clamp(8.0, max)));
  }

  void updateDesignationFontSize(double size) {
    final max = getMaxFontSize('designation');
    _update((c) => c.copyWith(designationFontSize: size.clamp(8.0, max)));
  }

  double getMaxFontSize(String field) {
    final id = _state.selectedFrame?.id ?? '';
    final isName = field == 'name';
    switch (id) {
      case 'rajnetaPremium': case 'rajnetaPremiumTop': return isName ? 60.0 : 30.0;
      case 'rajnetaModern': return isName ? 55.0 : 30.0;
      case 'rajnetaClassic': case 'rajnetaClassicTop': return isName ? 50.0 : 28.0;
      case 'wavyProfile': case 'wavyProfileTop':
      case 'saffronPride': case 'saffronPrideTop':
      case 'wavyEdge': case 'diagonalSlash': case 'arcReveal': return isName ? 45.0 : 25.0;
      case 'centerStage': return isName ? 50.0 : 28.0;
      case 'tricolorStrip': case 'tricolorStripTop': return isName ? 30.0 : 20.0;
      case 'footerStrip': case 'footerStripTop':
      case 'floatingCard': case 'floatingCardTop': return isName ? 35.0 : 20.0;
      default: return isName ? 40.0 : 25.0;
    }
  }

  // ── Colors ─────────────────────────────────────────────────────────────────
  void updateTextColor(Color c) => _update((s) => s.copyWith(textColor: c));
  void updateFrameBackgroundColor(Color c) => _update((s) => s.copyWith(frameBackgroundColor: c));
  void updateFrameColor1(Color c) => _update((s) => s.copyWith(frameColor1: c));
  void updateFrameColor2(Color c) => _update((s) => s.copyWith(frameColor2: c));
  void updateFrameColor3(Color c) => _update((s) => s.copyWith(frameColor3: c));
  void updateFrameTextColor1(Color c) => _update((s) => s.copyWith(frameTextColor1: c));
  void updateFrameTextColor2(Color c) => _update((s) => s.copyWith(frameTextColor2: c));
  void updateCanvasBackgroundColor(Color c) => _update((s) => s.copyWith(canvasBackgroundColor: c));

  void updateTheme(Color color) {
    final brightness = ThemeData.estimateBrightnessForColor(color);
    final isDark = brightness == Brightness.dark;
    _update((s) => s.copyWith(
      themeColor: color,
      frameBackgroundColor: color,
      canvasBackgroundColor: color.withOpacity(0.05),
      frameColor1: color,
      frameColor2: color,
      frameTextColor1: isDark ? Colors.white : Colors.black87,
      frameTextColor2: isDark ? Colors.white.withOpacity(0.9) : Colors.black54,
      textColor: isDark ? Colors.white : Colors.black,
    ));
  }

  // ── Frame ──────────────────────────────────────────────────────────────────
  void updateFrame(PosterFrameModel? frame) {
    if (frame == null) {
      _update((s) => s.copyWith(selectedFrame: frame));
      return;
    }
    // Apply frame-specific color defaults
    _update((s) => s.copyWith(
      selectedFrame: frame,
      frameBackgroundColor: frame.backgroundColor,
      frameColor1: frame.color1,
      frameColor2: frame.color2,
      frameColor3: frame.color3,
      frameTextColor1: frame.textColor1,
      frameTextColor2: frame.textColor2,
      nameFontSize: frame.nameFontSize,
      designationFontSize: frame.designationFontSize,
    ));
  }

  void toggleFrame(bool v) => _update((s) => s.copyWith(showFrame: v));

  // ── Social ─────────────────────────────────────────────────────────────────
  void updateFacebook(String? v) {
    _update((s) => s.copyWith(facebookHandle: v));
    _syncSocialStickerText('facebook', v);
  }

  void updateInstagram(String? v) {
    _update((s) => s.copyWith(instagramHandle: v));
    _syncSocialStickerText('instagram', v);
  }

  void updateWhatsapp(String? v) {
    _update((s) => s.copyWith(whatsappNumber: v));
    _syncSocialStickerText('whatsapp', v);
  }

  void updatePhoneNumber(String? v) => _update((s) => s.copyWith(phoneNumber: v));

  void toggleFacebook(bool v) => _toggleSocial('facebook', v);
  void toggleInstagram(bool v) => _toggleSocial('instagram', v);
  void toggleWhatsapp(bool v) {
    if (v) _update((s) => s.copyWith(showPhoneNumber: false));
    _toggleSocial('whatsapp', v);
  }
  void togglePhoneNumber(bool v) {
    _update((s) => s.copyWith(showPhoneNumber: v, showWhatsapp: v ? false : s.showWhatsapp));
  }
  void toggleStickers(bool v) => _update((s) => s.copyWith(showStickers: v));

  void _syncSocialStickerText(String platform, String? value) {
    final fallback = platform == 'facebook'
        ? (state.facebookHandle?.isNotEmpty == true ? state.facebookHandle! : 'facebook.com/yourpage')
        : platform == 'instagram'
            ? (state.instagramHandle?.isNotEmpty == true ? state.instagramHandle! : '@yourhandle')
            : (state.whatsappNumber?.isNotEmpty == true ? state.whatsappNumber! : '9XXXXXXXXX');
    final text = (value?.trim().isNotEmpty == true) ? value!.trim() : fallback;
    final updated = _state.stickers.map((s) {
      if (s.socialPlatform == platform) return s.copyWith(text: text);
      return s;
    }).toList();
    _update((s) => s.copyWith(stickers: updated));
  }

  void _toggleSocial(String platform, bool enabled) {
    _update((s) {
      switch (platform) {
        case 'facebook': return s.copyWith(showFacebook: enabled);
        case 'instagram': return s.copyWith(showInstagram: enabled);
        case 'whatsapp': return s.copyWith(showWhatsapp: enabled);
        default: return s;
      }
    });

    if (!enabled) {
      final updated = _state.stickers.where((s) => s.socialPlatform != platform).toList();
      _update((s) {
        switch (platform) {
          case 'facebook': return s.copyWith(stickers: updated, facebookStickerId: null);
          case 'instagram': return s.copyWith(stickers: updated, instagramStickerId: null);
          case 'whatsapp': return s.copyWith(stickers: updated, whatsappStickerId: null);
          default: return s;
        }
      });
      return;
    }

    // Add new sticker
    final text = platform == 'whatsapp'
        ? (_state.whatsappNumber?.trim().isNotEmpty == true ? _state.whatsappNumber!.trim() : '9XXXXXXXXX')
        : platform == 'facebook'
            ? (_state.facebookHandle?.trim().isNotEmpty == true ? _state.facebookHandle!.trim() : 'facebook.com/yourpage')
            : (_state.instagramHandle?.trim().isNotEmpty == true ? _state.instagramHandle!.trim() : '@yourhandle');

    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final sticker = PosterStickerModel(
      id: newId,
      isText: true,
      socialPlatform: platform,
      text: text,
      frameId: 'capsule',
      fontFamily: 'Poppins',
      fontWeight: 900,
      textColor: Colors.white,
      backgroundColor: const Color(0xFF2F6BFF),
      borderColor: const Color(0x99FFFFFF),
      borderWidth: 1.5,
      shadowEnabled: true,
      shadowColor: const Color(0xAA2F6BFF),
      shadowBlur: 18,
      position: Offset(_canvasSize.width / 2,
          (_canvasSize.height / 2) + (_state.stickers.length * 10.0)),
      scale: 1.2,
    );

    _update((s) {
      final list = [...s.stickers, sticker];
      switch (platform) {
        case 'facebook': return s.copyWith(stickers: list, facebookStickerId: newId);
        case 'instagram': return s.copyWith(stickers: list, instagramStickerId: newId);
        case 'whatsapp': return s.copyWith(stickers: list, whatsappStickerId: newId);
        default: return s;
      }
    });
    _selectedStickerId = newId;
  }

  // ── Stickers ───────────────────────────────────────────────────────────────
  void addSticker(String assetUrl, {bool isLocal = false}) {
    final sticker = PosterStickerModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      assetUrl: assetUrl,
      isLocal: isLocal,
      position: Offset(_canvasSize.width / 2, _canvasSize.height / 2),
      scale: 1.0,
    );
    _update((s) => s.copyWith(stickers: [...s.stickers, sticker]));
  }

  void addTextSticker(String text, {PosterTextStylePreset style = PosterTextStylePreset.plain}) {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final sticker = PosterStickerModel(
      id: newId,
      isText: true,
      text: text,
      frameId: style.frameId,
      fontFamily: style.fontKey,
      fontWeight: style.fontWeight,
      textColor: style.textColor,
      backgroundColor: style.backgroundColor,
      borderColor: style.borderColor,
      borderWidth: style.borderWidth,
      shadowEnabled: style.shadowEnabled,
      shadowColor: style.shadowColor,
      shadowBlur: style.shadowBlur,
      paddingFactor: style.paddingFactor,
      letterSpacing: style.letterSpacing,
      position: Offset(_canvasSize.width / 2, _canvasSize.height / 2),
      scale: 1.2,
    );
    _update((s) => s.copyWith(stickers: [...s.stickers, sticker]));
    _selectedStickerId = newId;
  }

  void updateSticker(PosterStickerModel updated) {
    final list = _state.stickers.map((s) => s.id == updated.id ? updated : s).toList();
    _update((s) => s.copyWith(stickers: list));
  }

  void removeSticker(String id) {
    final sticker = _state.stickers.firstWhere((s) => s.id == id, orElse: () => PosterStickerModel(id: ''));
    final platform = sticker.socialPlatform;
    var updated = _state.stickers.where((s) => s.id != id).toList();
    _update((s) {
      var next = s.copyWith(stickers: updated);
      if (platform != null && !updated.any((x) => x.socialPlatform == platform)) {
        switch (platform) {
          case 'facebook': next = next.copyWith(showFacebook: false, facebookStickerId: null); break;
          case 'instagram': next = next.copyWith(showInstagram: false, instagramStickerId: null); break;
          case 'whatsapp': next = next.copyWith(showWhatsapp: false, whatsappStickerId: null); break;
        }
      }
      return next;
    });
    if (_selectedStickerId == id) _selectedStickerId = '';
  }

  void clearAllStickers() {
    _selectedStickerId = '';
    _update((s) => s.copyWith(
      stickers: [],
      showFacebook: false, showInstagram: false, showWhatsapp: false,
      facebookStickerId: null, instagramStickerId: null, whatsappStickerId: null,
    ));
  }

  // Sticker text editing helpers
  void updateSelectedStickerText(String text) {
    final s = _getStickerById(_selectedStickerId);
    if (s != null) updateSticker(s.copyWith(text: text));
  }

  void updateSelectedStickerFontSize(double size) {
    final s = _getStickerById(_selectedStickerId);
    if (s != null) updateSticker(s.copyWith(fontSize: size));
  }

  void updateSelectedStickerStyle(PosterTextStylePreset preset) {
    final s = _getStickerById(_selectedStickerId);
    if (s == null) return;
    updateSticker(s.copyWith(
      frameId: preset.frameId,
      fontFamily: preset.fontKey,
      fontWeight: preset.fontWeight,
      textColor: preset.textColor,
      backgroundColor: preset.backgroundColor,
      borderColor: preset.borderColor,
      borderWidth: preset.borderWidth,
      shadowEnabled: preset.shadowEnabled,
      shadowColor: preset.shadowColor,
      shadowBlur: preset.shadowBlur,
      paddingFactor: preset.paddingFactor,
      letterSpacing: preset.letterSpacing,
    ));
  }

  PosterStickerModel? _getStickerById(String id) {
    if (id.isEmpty) return null;
    try {
      return _state.stickers.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  PosterStickerModel? get selectedSticker => _getStickerById(_selectedStickerId);

  // ── Extras ─────────────────────────────────────────────────────────────────
  void updateLeaderPhotos(List<String> photos) => _update((s) => s.copyWith(leaderPhotos: photos));
  void updatePartyLogo(String? url) => _update((s) => s.copyWith(partyLogoUrl: url));
}

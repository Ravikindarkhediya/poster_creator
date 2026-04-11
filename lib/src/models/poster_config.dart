import 'dart:ui' show Color;
import 'package:flutter/material.dart' show Colors;
import 'poster_frame.dart';
import 'poster_sticker.dart';
import 'poster_social_handle.dart';
import 'poster_text_style.dart';

/// The single configuration object that drives the entire poster.
///
/// Pass this to [PosterCanvas] and it will render everything accordingly.
/// All fields are optional except [templateUrl].
///
/// ```dart
/// PosterConfig(
///   templateUrl: 'https://example.com/bg.jpg',
///   userName: 'Ravi Kumar',
///   designation: 'Ward Member',
///   frame: PosterFrame.wavyProfile(
///     backgroundColor: Colors.orange,
///     textColor1: Colors.white,
///   ),
/// )
/// ```
class PosterConfig {
  // ── Template ───────────────────────────────────────────────────────────────
  /// URL or local path of the background template image.
  final String templateUrl;

  /// Aspect ratio of the canvas (width / height). Defaults to 1.0 (square).
  /// The canvas auto-detects it from [templateUrl] if not provided.
  final double? aspectRatio;

  // ── Profile ────────────────────────────────────────────────────────────────
  /// Local file path or HTTP URL to the user's profile image.
  final String profileImagePath;

  /// If true, renders the profile image with a transparent background (assumes
  /// background has already been removed externally).
  final bool isBackgroundRemoved;

  /// Whether the profile image is visible on the canvas.
  final bool showProfileImage;

  // ── Text ───────────────────────────────────────────────────────────────────
  final String userName;
  final String designation;
  final String partyName;

  final PosterTextConfig nameStyle;
  final PosterTextConfig designationStyle;

  // ── Frame ──────────────────────────────────────────────────────────────────
  /// The overlay frame/layout to render on top of the template.
  /// Set to `null` to render no frame.
  final PosterFrame? frame;

  /// Whether the frame is visible.
  final bool showFrame;

  // ── Social handles ─────────────────────────────────────────────────────────
  final List<PosterSocialHandle> socialHandles;

  // ── Stickers ───────────────────────────────────────────────────────────────
  final List<PosterSticker> stickers;

  /// Whether all stickers are visible.
  final bool showStickers;

  // ── Canvas ─────────────────────────────────────────────────────────────────
  /// Background tint color shown behind the template image.
  final Color canvasBackgroundColor;

  // ── Optional extras ────────────────────────────────────────────────────────
  /// Up to 8 leader photo URLs/paths shown in a strip.
  final List<String> leaderPhotos;

  /// URL/path to the party logo shown as a floating circular badge.
  final String? partyLogoUrl;

  const PosterConfig({
    required this.templateUrl,
    this.aspectRatio,
    this.profileImagePath = '',
    this.isBackgroundRemoved = false,
    this.showProfileImage = true,
    this.userName = 'Your Name',
    this.designation = 'Your Designation',
    this.partyName = 'Your Organization',
    this.nameStyle = const PosterTextConfig(
      fontFamily: 'Poppins',
      fontSize: 22,
      color: Colors.white,
      isBold: true,
    ),
    this.designationStyle = const PosterTextConfig(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.white,
    ),
    this.frame,
    this.showFrame = true,
    this.socialHandles = const [],
    this.stickers = const [],
    this.showStickers = true,
    this.canvasBackgroundColor = const Color(0xFFF8F9FA),
    this.leaderPhotos = const [],
    this.partyLogoUrl,
  });

  PosterConfig copyWith({
    String? templateUrl,
    double? aspectRatio,
    String? profileImagePath,
    bool? isBackgroundRemoved,
    bool? showProfileImage,
    String? userName,
    String? designation,
    String? partyName,
    PosterTextConfig? nameStyle,
    PosterTextConfig? designationStyle,
    PosterFrame? frame,
    bool? showFrame,
    List<PosterSocialHandle>? socialHandles,
    List<PosterSticker>? stickers,
    bool? showStickers,
    Color? canvasBackgroundColor,
    List<String>? leaderPhotos,
    String? partyLogoUrl,
  }) {
    return PosterConfig(
      templateUrl: templateUrl ?? this.templateUrl,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      isBackgroundRemoved: isBackgroundRemoved ?? this.isBackgroundRemoved,
      showProfileImage: showProfileImage ?? this.showProfileImage,
      userName: userName ?? this.userName,
      designation: designation ?? this.designation,
      partyName: partyName ?? this.partyName,
      nameStyle: nameStyle ?? this.nameStyle,
      designationStyle: designationStyle ?? this.designationStyle,
      frame: frame ?? this.frame,
      showFrame: showFrame ?? this.showFrame,
      socialHandles: socialHandles ?? this.socialHandles,
      stickers: stickers ?? this.stickers,
      showStickers: showStickers ?? this.showStickers,
      canvasBackgroundColor: canvasBackgroundColor ?? this.canvasBackgroundColor,
      leaderPhotos: leaderPhotos ?? this.leaderPhotos,
      partyLogoUrl: partyLogoUrl ?? this.partyLogoUrl,
    );
  }
}

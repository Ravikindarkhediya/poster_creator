import 'package:flutter/material.dart';
import 'poster_frame_model.dart';
import 'poster_sticker_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Customization (full poster state)
// ─────────────────────────────────────────────────────────────────────────────

class PosterCustomization {
  // Profile
  final String profileImagePath;
  final String originalProfileImagePath;
  final bool isBackgroundRemoved;
  final bool showProfileImage;

  // Text
  final String userName;
  final String designation;
  final String partyName;
  final String nameFontFamily;
  final String designationFontFamily;
  final double nameFontSize;
  final double designationFontSize;

  // Colors
  final Color textColor;
  final Color frameBackgroundColor;
  final Color frameColor1;
  final Color frameColor2;
  final Color frameColor3;
  final Color frameTextColor1;
  final Color frameTextColor2;
  final Color canvasBackgroundColor;
  final Color? themeColor;

  // Social
  final String? facebookHandle;
  final String? instagramHandle;
  final String? twitterHandle;
  final String? whatsappNumber;
  final String? phoneNumber;
  final bool showFacebook;
  final bool showInstagram;
  final bool showTwitter;
  final bool showWhatsapp;
  final bool showPhoneNumber;
  final String? facebookStickerId;
  final String? instagramStickerId;
  final String? whatsappStickerId;

  // Frame
  final PosterFrameModel? selectedFrame;
  final bool showFrame;
  final bool showStickers;

  // Advanced
  final List<PosterStickerModel> stickers;
  final List<String> leaderPhotos;
  final String? partyLogoUrl;

  const PosterCustomization({
    this.profileImagePath = '',
    this.originalProfileImagePath = '',
    this.isBackgroundRemoved = false,
    this.showProfileImage = true,
    this.userName = 'Your Name',
    this.designation = 'Your Designation',
    this.partyName = 'Your Organization',
    this.nameFontFamily = 'Poppins',
    this.designationFontFamily = 'Poppins',
    this.nameFontSize = 22.0,
    this.designationFontSize = 14.0,
    this.textColor = Colors.white,
    this.frameBackgroundColor = const Color(0xFFFF9933),
    this.frameColor1 = Colors.white,
    this.frameColor2 = const Color(0xFFFF9933),
    this.frameColor3 = const Color(0xFF128807),
    this.frameTextColor1 = const Color(0xFFFF9933),
    this.frameTextColor2 = Colors.white,
    this.canvasBackgroundColor = const Color(0xFFF8F9FA),
    this.themeColor,
    this.facebookHandle,
    this.instagramHandle,
    this.twitterHandle,
    this.whatsappNumber,
    this.phoneNumber,
    this.showFacebook = false,
    this.showInstagram = false,
    this.showTwitter = false,
    this.showWhatsapp = false,
    this.showPhoneNumber = false,
    this.facebookStickerId,
    this.instagramStickerId,
    this.whatsappStickerId,
    this.selectedFrame,
    this.showFrame = true,
    this.showStickers = true,
    this.stickers = const [],
    this.leaderPhotos = const [],
    this.partyLogoUrl,
  });

  PosterCustomization copyWith({
    String? profileImagePath,
    String? originalProfileImagePath,
    bool? isBackgroundRemoved,
    bool? showProfileImage,
    String? userName,
    String? designation,
    String? partyName,
    String? nameFontFamily,
    String? designationFontFamily,
    double? nameFontSize,
    double? designationFontSize,
    Color? textColor,
    Color? frameBackgroundColor,
    Color? frameColor1,
    Color? frameColor2,
    Color? frameColor3,
    Color? frameTextColor1,
    Color? frameTextColor2,
    Color? canvasBackgroundColor,
    Color? themeColor,
    String? facebookHandle,
    String? instagramHandle,
    String? twitterHandle,
    String? whatsappNumber,
    String? phoneNumber,
    bool? showFacebook,
    bool? showInstagram,
    bool? showTwitter,
    bool? showWhatsapp,
    bool? showPhoneNumber,
    String? facebookStickerId,
    String? instagramStickerId,
    String? whatsappStickerId,
    PosterFrameModel? selectedFrame,
    bool? showFrame,
    bool? showStickers,
    List<PosterStickerModel>? stickers,
    List<String>? leaderPhotos,
    String? partyLogoUrl,
  }) {
    return PosterCustomization(
      profileImagePath: profileImagePath ?? this.profileImagePath,
      originalProfileImagePath:
          originalProfileImagePath ?? this.originalProfileImagePath,
      isBackgroundRemoved: isBackgroundRemoved ?? this.isBackgroundRemoved,
      showProfileImage: showProfileImage ?? this.showProfileImage,
      userName: userName ?? this.userName,
      designation: designation ?? this.designation,
      partyName: partyName ?? this.partyName,
      nameFontFamily: nameFontFamily ?? this.nameFontFamily,
      designationFontFamily:
          designationFontFamily ?? this.designationFontFamily,
      nameFontSize: nameFontSize ?? this.nameFontSize,
      designationFontSize: designationFontSize ?? this.designationFontSize,
      textColor: textColor ?? this.textColor,
      frameBackgroundColor: frameBackgroundColor ?? this.frameBackgroundColor,
      frameColor1: frameColor1 ?? this.frameColor1,
      frameColor2: frameColor2 ?? this.frameColor2,
      frameColor3: frameColor3 ?? this.frameColor3,
      frameTextColor1: frameTextColor1 ?? this.frameTextColor1,
      frameTextColor2: frameTextColor2 ?? this.frameTextColor2,
      canvasBackgroundColor:
          canvasBackgroundColor ?? this.canvasBackgroundColor,
      themeColor: themeColor ?? this.themeColor,
      facebookHandle: facebookHandle ?? this.facebookHandle,
      instagramHandle: instagramHandle ?? this.instagramHandle,
      twitterHandle: twitterHandle ?? this.twitterHandle,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      showFacebook: showFacebook ?? this.showFacebook,
      showInstagram: showInstagram ?? this.showInstagram,
      showTwitter: showTwitter ?? this.showTwitter,
      showWhatsapp: showWhatsapp ?? this.showWhatsapp,
      showPhoneNumber: showPhoneNumber ?? this.showPhoneNumber,
      facebookStickerId: facebookStickerId ?? this.facebookStickerId,
      instagramStickerId: instagramStickerId ?? this.instagramStickerId,
      whatsappStickerId: whatsappStickerId ?? this.whatsappStickerId,
      selectedFrame: selectedFrame ?? this.selectedFrame,
      showFrame: showFrame ?? this.showFrame,
      showStickers: showStickers ?? this.showStickers,
      stickers: stickers ?? List.from(this.stickers),
      leaderPhotos: leaderPhotos ?? List.from(this.leaderPhotos),
      partyLogoUrl: partyLogoUrl ?? this.partyLogoUrl,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Text sticker style preset
// ─────────────────────────────────────────────────────────────────────────────

class PosterTextStylePreset {
  final String frameId;
  final String fontKey;
  final int fontWeight;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final bool shadowEnabled;
  final Color shadowColor;
  final double shadowBlur;
  final double paddingFactor;
  final double letterSpacing;

  const PosterTextStylePreset({
    required this.frameId,
    required this.fontKey,
    required this.fontWeight,
    required this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.shadowEnabled = false,
    this.shadowColor = Colors.black,
    this.shadowBlur = 10,
    this.paddingFactor = 0.06,
    this.letterSpacing = 0,
  });

  static const plain = PosterTextStylePreset(
    frameId: 'plain',
    fontKey: 'Poppins',
    fontWeight: 400,
    textColor: Colors.white,
    paddingFactor: 0.035,
  );

  static const capsule = PosterTextStylePreset(
    frameId: 'capsule',
    fontKey: 'Poppins',
    fontWeight: 900,
    textColor: Colors.white,
    backgroundColor: Color(0xFF2F6BFF),
    borderColor: Color(0x99FFFFFF),
    borderWidth: 1.5,
    shadowEnabled: true,
    shadowColor: Color(0xAA2F6BFF),
    shadowBlur: 18,
    paddingFactor: 0.085,
  );

  static const outline = PosterTextStylePreset(
    frameId: 'outline',
    fontKey: 'Montserrat',
    fontWeight: 800,
    textColor: Colors.white,
    backgroundColor: Color(0x33000000),
    borderColor: Colors.white,
    borderWidth: 2,
    paddingFactor: 0.07,
  );

  static const neon = PosterTextStylePreset(
    frameId: 'neon',
    fontKey: 'Nunito',
    fontWeight: 900,
    textColor: Color(0xFFFFF2A1),
    backgroundColor: Color(0x22000000),
    borderColor: Color(0xFFFFF2A1),
    borderWidth: 1.5,
    shadowEnabled: true,
    shadowColor: Color(0xFFFFF2A1),
    shadowBlur: 22,
    paddingFactor: 0.07,
    letterSpacing: 0.2,
  );

  static const emoji = PosterTextStylePreset(
    frameId: 'emoji',
    fontKey: 'emoji',
    fontWeight: 700,
    textColor: Colors.white,
    paddingFactor: 0.02,
  );

  static const List<PosterTextStylePreset> all = [
    plain,
    capsule,
    outline,
    neon,
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
// Export result
// ─────────────────────────────────────────────────────────────────────────────

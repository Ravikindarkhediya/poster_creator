// All editor tab widgets

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/poster_controller.dart';
import '../models/poster_frame_model.dart';
import 'poster_canvas.dart';

// ─────────────────────────────────────────────────────────────────────────────
// FONT TAB
// ─────────────────────────────────────────────────────────────────────────────

class PosterFontTab extends StatelessWidget {
  final PosterController controller;
  final ScrollController? scrollController;
  const PosterFontTab({
    super.key,
    required this.controller,
    this.scrollController,
  });

  static const _fonts = [
    'Poppins',
    'Roboto',
    'Noto Sans',
    'Baloo 2',
    'Hind',
    'Mukta',
    'Rajdhani',
    'Tiro Devanagari Hindi',
    'Martel',
    'Kalam',
    'Amita',
    'Yatra One',
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        final c = controller.state;
        final isName = controller.activeFontField == 'name';
        final selFont = isName ? c.nameFontFamily : c.designationFontFamily;
        final curSize = isName ? c.nameFontSize : c.designationFontSize;
        final maxSize = controller.getMaxFontSize(controller.activeFontField);

        return SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Field toggle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _toggle('name', 'NAME'),
                      const SizedBox(width: 8),
                      _toggle('designation', 'DESIGNATION'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Size slider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'FONT SIZE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Text(
                            '${curSize.toInt()}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 2,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6,
                          ),
                          activeTrackColor: Colors.blueAccent,
                          thumbColor: Colors.blueAccent,
                        ),
                        child: Slider(
                          value: curSize.clamp(8.0, maxSize),
                          min: 8.0,
                          max: maxSize,
                          onChanged: (v) => isName
                              ? controller.updateNameFontSize(v)
                              : controller.updateDesignationFontSize(v),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Font grid
                SizedBox(
                  height: 110,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: _fonts.length,
                    itemBuilder: (_, i) {
                      final font = _fonts[i];
                      final isSel = selFont == font;
                      return GestureDetector(
                        onTap: () => isName
                            ? controller.updateNameFont(font)
                            : controller.updateDesignationFont(font),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSel ? Colors.blueAccent : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSel
                                  ? Colors.blueAccent
                                  : Colors.grey.shade200,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSel
                                    ? Colors.blueAccent.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.05),
                                blurRadius: isSel ? 8 : 4,
                                offset: Offset(0, isSel ? 4 : 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Aa',
                                style: GoogleFonts.getFont(
                                  font,
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    color: isSel
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: Text(
                                  font,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: isSel
                                        ? Colors.white.withOpacity(0.9)
                                        : Colors.grey.shade600,
                                    fontWeight: isSel
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _toggle(String field, String label) {
    final isActive = controller.activeFontField == field;
    return GestureDetector(
      onTap: () => controller.activeFontField = field,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.blue.shade200 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: isActive ? Colors.blue.shade800 : Colors.grey.shade600,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PHOTO TAB
// ─────────────────────────────────────────────────────────────────────────────

class PosterPhotoTab extends StatelessWidget {
  final PosterController controller;
  final ScrollController? scrollController;

  /// Optional callback to handle background removal — receives source image path,
  /// should return processed path or null on failure.
  final Future<String?> Function(String sourcePath)? onRemoveBackground;

  const PosterPhotoTab({
    super.key,
    required this.controller,
    this.scrollController,
    this.onRemoveBackground,
  });

  Future<void> _pick(ImageSource src) async {
    final f = await ImagePicker().pickImage(source: src);
    if (f != null) controller.updatePhoto(f.path);
  }

  Future<void> _toggleBgRemoval(bool v) async {
    if (!v) {
      controller.setBackgroundRemoved(false);
      return;
    }
    if (controller.state.profileImagePath.isEmpty) return;
    if (onRemoveBackground != null) {
      final processed = await onRemoveBackground!(
        controller.state.originalProfileImagePath.isNotEmpty
            ? controller.state.originalProfileImagePath
            : controller.state.profileImagePath,
      );
      controller.setBackgroundRemoved(
        processed != null,
        processedPath: processed,
      );
    } else {
      controller.setBackgroundRemoved(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        final c = controller.state;
        return SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey.shade50,
                        backgroundImage: c.profileImagePath.isEmpty
                            ? null
                            : (c.profileImagePath.startsWith('http')
                                  ? CachedNetworkImageProvider(
                                      c.profileImagePath,
                                    )
                                  : FileImage(File(c.profileImagePath))
                                        as ImageProvider),
                        child: c.profileImagePath.isEmpty
                            ? Icon(
                                Icons.person_add_alt_1_outlined,
                                size: 25,
                                color: Colors.blue.shade200,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          _actionBtn(
                            () => _pick(ImageSource.gallery),
                            Icons.photo_library_rounded,
                            'Gallery',
                            Colors.blue,
                          ),
                          const SizedBox(height: 8),
                          _actionBtn(
                            () => _pick(ImageSource.camera),
                            Icons.camera_alt_rounded,
                            'Camera',
                            Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _toggleRow(
                  Icons.visibility_rounded,
                  'Show Photo',
                  c.showProfileImage,
                  controller.toggleProfileImage,
                  Colors.green,
                ),
                if (c.profileImagePath.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _toggleRow(
                    Icons.auto_fix_high_rounded,
                    'Remove Background',
                    c.isBackgroundRemoved,
                    _toggleBgRemoval,
                    Colors.blue,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionBtn(VoidCallback fn, IconData icon, String label, Color color) {
    return InkWell(
      onTap: fn,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleRow(
    IconData icon,
    String label,
    bool val,
    ValueChanged<bool> cb,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: color,
              ),
            ),
          ),
          SizedBox(
            height: 24,
            child: Switch.adaptive(
              value: val,
              onChanged: cb,
              activeColor: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FRAME TAB
// ─────────────────────────────────────────────────────────────────────────────

class PosterFrameTab extends StatelessWidget {
  final PosterController controller;
  final ScrollController? scrollController;
  const PosterFrameTab({
    super.key,
    required this.controller,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'AVAILABLE FRAMES',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    letterSpacing: 1.0,
                    color: Colors.blueGrey,
                  ),
                ),
                ListenableBuilder(
                  listenable: controller,
                  builder: (_, __) {
                    final show = controller.state.showProfileImage;
                    return Row(
                      children: [
                        Text(
                          show ? 'HIDE PHOTO' : 'SHOW PHOTO',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            color: show ? Colors.red : Colors.green,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Transform.scale(
                          scale: 0.6,
                          child: Switch(
                            value: show,
                            onChanged: controller.toggleProfileImage,
                            activeColor: Colors.blueAccent,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: ListenableBuilder(
            listenable: controller,
            builder: (_, __) {
              final selId = controller.state.selectedFrame?.id;
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate((ctx, i) {
                  final frame = PosterFrameModel.allFrames[i];
                  final isSel = selId == frame.id;
                  return GestureDetector(
                    onTap: () => controller.updateFrame(frame),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSel ? Colors.blue.shade50 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSel
                              ? Colors.blueAccent
                              : Colors.grey.shade200,
                          width: isSel ? 2 : 1,
                        ),
                        boxShadow: [
                          isSel
                              ? BoxShadow(
                                  color: Colors.blue.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              : BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: PosterCanvas(
                                controller: controller,
                                frameOverride: frame,
                                isPreview: true,
                              ),
                            ),
                            if (isSel) ...[
                              Container(
                                color: Colors.blueAccent.withOpacity(0.05),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.blueAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }, childCount: PosterFrameModel.allFrames.length),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PROFILE TAB
// ─────────────────────────────────────────────────────────────────────────────

class PosterProfileTab extends StatelessWidget {
  final PosterController controller;
  final ScrollController? scrollController;
  const PosterProfileTab({
    super.key,
    required this.controller,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        final c = controller.state;
        return SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _section('PERSONAL DETAILS'),
                const SizedBox(height: 12),
                _field(
                  'Full Name',
                  c.userName,
                  controller.updateUserName,
                  Icons.person_outline,
                ),
                const SizedBox(height: 12),
                _field(
                  'Designation',
                  c.designation,
                  controller.updateDesignation,
                  Icons.work_outline,
                ),
                const SizedBox(height: 12),
                _field(
                  'Party / Organization',
                  c.partyName,
                  controller.updatePartyName,
                  Icons.business_outlined,
                ),
                const SizedBox(height: 20),
                _section('SOCIAL & CONTACTS'),
                const SizedBox(height: 12),
                _socialField(
                  'Facebook',
                  c.facebookHandle ?? '',
                  controller.updateFacebook,
                  Icons.facebook,
                  c.showFacebook,
                  controller.toggleFacebook,
                ),
                const SizedBox(height: 12),
                _socialField(
                  'Instagram',
                  c.instagramHandle ?? '',
                  controller.updateInstagram,
                  Icons.camera_alt_outlined,
                  c.showInstagram,
                  controller.toggleInstagram,
                ),
                const SizedBox(height: 12),
                _socialField(
                  'WhatsApp',
                  c.whatsappNumber ?? '',
                  controller.updateWhatsapp,
                  Icons.chat_rounded,
                  c.showWhatsapp,
                  controller.toggleWhatsapp,
                ),
                const SizedBox(height: 12),
                _socialField(
                  'Phone',
                  c.phoneNumber ?? '',
                  controller.updatePhoneNumber,
                  Icons.call,
                  c.showPhoneNumber,
                  controller.togglePhoneNumber,
                  isPhone: true,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _section(String t) => Text(
    t,
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w900,
      color: Colors.blue.shade800,
      letterSpacing: 1.2,
    ),
  );

  Widget _field(
    String label,
    String val,
    void Function(String) onChanged,
    IconData icon,
  ) {
    return TextFormField(
      initialValue: val,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        prefixIcon: Icon(icon, size: 18, color: Colors.blue.shade400),
        isDense: true,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _socialField(
    String label,
    String val,
    void Function(String?) onChanged,
    IconData icon,
    bool isVisible,
    void Function(bool) onToggle, {
    bool isPhone = false,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Show',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                SizedBox(
                  height: 30,
                  child: Switch.adaptive(
                    value: isVisible,
                    onChanged: onToggle,
                    activeColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
        TextFormField(
          initialValue: val,
          onChanged: onChanged,
          keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: Colors.blue.shade400),
            isDense: true,
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FRAME PICKER (standalone list widget)
// ─────────────────────────────────────────────────────────────────────────────

class PosterFramePicker extends StatelessWidget {
  final PosterController controller;
  const PosterFramePicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        return SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: PosterFrameModel.allFrames.length,
            itemBuilder: (_, i) {
              final frame = PosterFrameModel.allFrames[i];
              final isSel = controller.state.selectedFrame?.id == frame.id;
              return GestureDetector(
                onTap: () => controller.updateFrame(frame),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 15),
                  width: 80,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSel ? Colors.blueAccent : Colors.grey.shade200,
                      width: 2,
                    ),
                    boxShadow: isSel
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.2),
                              blurRadius: 10,
                            ),
                          ]
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        PosterCanvas(
                          controller: controller,
                          frameOverride: frame,
                          isPreview: true,
                        ),
                        if (isSel)
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

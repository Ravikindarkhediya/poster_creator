import 'package:flutter/material.dart';
import 'package:poster_creator/poster_creator.dart';

class PosterDemoPage extends StatefulWidget {
  const PosterDemoPage({super.key});

  @override
  State<PosterDemoPage> createState() => _PosterDemoPageState();
}

class _PosterDemoPageState extends State<PosterDemoPage> {
  // ── State ────────────────────────────────────────────────────────────────
  final GlobalKey _exportKey = GlobalKey();

  late PosterConfig _config;
  PosterFrame _selectedFrame = PosterFrame.wavyProfile();
  String? _selectedStickerId;

  // Text controllers
  final _nameCtrl = TextEditingController(text: 'Ramesh Patel');
  final _designationCtrl =
      TextEditingController(text: 'Gram Panchayat Member');
  final _partyCtrl = TextEditingController(text: 'Jan Seva Party');

  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    _buildConfig();
  }

  void _buildConfig() {
    _config = PosterConfig(
      // Use any public image as the template background
      templateUrl:
          'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800&q=80',
      userName: _nameCtrl.text,
      designation: _designationCtrl.text,
      partyName: _partyCtrl.text,
      frame: _selectedFrame,
      nameStyle: const PosterTextConfig(
        fontFamily: 'Poppins',
        fontSize: 22,
        color: Colors.white,
        isBold: true,
      ),
      designationStyle: const PosterTextConfig(
        fontFamily: 'Poppins',
        fontSize: 14,
        color: Colors.white,
      ),
      stickers: _config.stickers,
      showStickers: true,
      showFrame: true,
      showProfileImage: true,
    );
  }

  void _onFrameSelected(PosterFrame frame) {
    setState(() {
      _selectedFrame = frame;
      _buildConfig();
    });
  }

  void _addTextSticker() {
    final sticker = PosterSticker.capsule(
      text: '#JanSeva',
      position: Offset(
        200,
        MediaQuery.of(context).size.height * 0.3,
      ),
    );
    setState(() {
      _config = _config.copyWith(
        stickers: [..._config.stickers, sticker],
      );
    });
  }

  void _addSocialSticker(String platform, String handle) {
    final sticker = PosterSticker.social(
      platform: platform,
      handle: handle,
      position: const Offset(200, 300),
    );
    setState(() {
      _config = _config.copyWith(
        stickers: [..._config.stickers, sticker],
      );
    });
  }

  void _clearStickers() {
    setState(() {
      _config = _config.copyWith(stickers: []);
      _selectedStickerId = null;
    });
  }

  Future<void> _export() async {
    setState(() => _isExporting = true);
    // Deselect stickers so handles are hidden
    setState(() => _selectedStickerId = null);

    // Brief delay to let the UI rebuild before capturing
    await Future.delayed(const Duration(milliseconds: 100));

    final result = await PosterExporter.export(_exportKey, pixelRatio: 3.0);
    setState(() => _isExporting = false);

    if (!mounted) return;
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Exported ${result.width}×${result.height}px (${(result.bytes.lengthInBytes / 1024).toStringAsFixed(0)} KB)',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Export failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _designationCtrl.dispose();
    _partyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Poster Creator Demo',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: _isExporting ? null : _export,
              icon: _isExporting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.download_rounded),
              label: const Text('Export'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Canvas preview ─────────────────────────────────────────────
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: RepaintBoundary(
                // Note: We use PosterCanvas's own exportKey internally.
                // This outer RepaintBoundary is just for layout.
                child: PosterCanvas(
                  config: _config,
                  exportKey: _exportKey,
                  selectedStickerId: _selectedStickerId,
                  onStickerSelect: (id) =>
                      setState(() => _selectedStickerId = id),
                  onStickerUpdate: (updated) => setState(() {
                    _config = _config.copyWith(stickers: updated.cast());
                  }),
                  onStickerRemove: (id) => setState(() {
                    _config = _config.copyWith(
                      stickers:
                          _config.stickers.where((s) => s.id != id).toList(),
                    );
                    if (_selectedStickerId == id) _selectedStickerId = null;
                  }),
                ),
              ),
            ),
          ),

          // ── Controls panel ─────────────────────────────────────────────
          Expanded(
            flex: 4,
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.blueAccent,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blueAccent,
                    tabs: [
                      Tab(text: 'Profile'),
                      Tab(text: 'Frames'),
                      Tab(text: 'Stickers'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _ProfileTab(
                          nameCtrl: _nameCtrl,
                          designationCtrl: _designationCtrl,
                          partyCtrl: _partyCtrl,
                          onChanged: () => setState(_buildConfig),
                          currentFrame: _selectedFrame,
                          onColorChange: (bg, tc1, tc2) {
                            _onFrameSelected(_selectedFrame.copyWith(
                              backgroundColor: bg,
                              textColor1: tc1,
                              textColor2: tc2,
                            ));
                          },
                        ),
                        _FramePickerTab(
                          selected: _selectedFrame,
                          config: _config,
                          onSelect: _onFrameSelected,
                        ),
                        _StickerTab(
                          stickers: _config.stickers,
                          onAddText: _addTextSticker,
                          onAddFacebook: () =>
                              _addSocialSticker('facebook', 'fb.com/yourpage'),
                          onAddWhatsapp: () =>
                              _addSocialSticker('whatsapp', '9XXXXXXXXX'),
                          onClear: _clearStickers,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile Tab
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileTab extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController designationCtrl;
  final TextEditingController partyCtrl;
  final VoidCallback onChanged;
  final PosterFrame currentFrame;
  final void Function(Color bg, Color tc1, Color tc2) onColorChange;

  const _ProfileTab({
    required this.nameCtrl,
    required this.designationCtrl,
    required this.partyCtrl,
    required this.onChanged,
    required this.currentFrame,
    required this.onColorChange,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _field('Name', nameCtrl, onChanged),
          const SizedBox(height: 12),
          _field('Designation', designationCtrl, onChanged),
          const SizedBox(height: 12),
          _field('Party / Organization', partyCtrl, onChanged),
          const SizedBox(height: 16),
          const Text('Frame Colors',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _ColorDot(
                color: const Color(0xFFFF9933),
                label: 'Saffron',
                onTap: () => onColorChange(const Color(0xFFFF9933),
                    Colors.white, const Color(0xFFFFFF00)),
              ),
              _ColorDot(
                color: const Color(0xFF1565C0),
                label: 'Blue',
                onTap: () => onColorChange(
                    const Color(0xFF1565C0), Colors.white, Colors.white),
              ),
              _ColorDot(
                color: const Color(0xFF2E7D32),
                label: 'Green',
                onTap: () => onColorChange(
                    const Color(0xFF2E7D32), Colors.white, Colors.white),
              ),
              _ColorDot(
                color: const Color(0xFF6A1B9A),
                label: 'Purple',
                onTap: () => onColorChange(
                    const Color(0xFF6A1B9A), Colors.white, Colors.white),
              ),
              _ColorDot(
                color: Colors.black87,
                label: 'Black',
                onTap: () => onColorChange(
                    Colors.black87, Colors.white, Colors.amber),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _field(
      String label, TextEditingController ctrl, VoidCallback onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey)),
        const SizedBox(height: 4),
        TextField(
          controller: ctrl,
          onChanged: (_) => onChange(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ColorDot(
      {required this.color, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(fontSize: 9, color: Colors.grey)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Frame Picker Tab
// ─────────────────────────────────────────────────────────────────────────────

class _FramePickerTab extends StatelessWidget {
  final PosterFrame selected;
  final PosterConfig config;
  final void Function(PosterFrame) onSelect;

  const _FramePickerTab({
    required this.selected,
    required this.config,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final frames = PosterFrame.allFrames;
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: frames.length,
      itemBuilder: (_, i) {
        final frame = frames[i];
        final isSelected = selected.type == frame.type;
        return GestureDetector(
          onTap: () => onSelect(frame),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? Colors.blueAccent : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Stack(
                children: [
                  // Thumbnail using the package's own canvas
                  PosterCanvas(
                    config: config.copyWith(frame: frame),
                    frameOverride: frame,
                    isPreview: true,
                  ),
                  if (isSelected)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 10),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sticker Tab
// ─────────────────────────────────────────────────────────────────────────────

class _StickerTab extends StatelessWidget {
  final List<PosterSticker> stickers;
  final VoidCallback onAddText;
  final VoidCallback onAddFacebook;
  final VoidCallback onAddWhatsapp;
  final VoidCallback onClear;

  const _StickerTab({
    required this.stickers,
    required this.onAddText,
    required this.onAddFacebook,
    required this.onAddWhatsapp,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${stickers.length} sticker(s) on canvas',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _StickerBtn(
                icon: Icons.text_fields_rounded,
                label: 'Add Text',
                color: Colors.blueAccent,
                onTap: onAddText,
              ),
              _StickerBtn(
                icon: Icons.facebook_rounded,
                label: 'Facebook',
                color: const Color(0xFF1877F2),
                onTap: onAddFacebook,
              ),
              _StickerBtn(
                icon: Icons.chat_rounded,
                label: 'WhatsApp',
                color: const Color(0xFF25D366),
                onTap: onAddWhatsapp,
              ),
              _StickerBtn(
                icon: Icons.delete_sweep_rounded,
                label: 'Clear All',
                color: Colors.red,
                onTap: onClear,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Tip: Double-tap text stickers to edit them directly on the canvas.',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _StickerBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _StickerBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

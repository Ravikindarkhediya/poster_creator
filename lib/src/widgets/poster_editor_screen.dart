import 'package:flutter/material.dart';
import '../controllers/poster_controller.dart';
import '../models/poster_frame_model.dart';
import '../tabs/poster_color_tab.dart';
import 'poster_tabs_bundle.dart';
import '../tabs/poster_text_sticker_tabs.dart';
import '../utils/poster_exporter.dart';
import 'poster_canvas.dart';

/// All-in-one poster editor screen.
///
/// Drop this directly into your route — no setup needed.
///
/// ```dart
/// // Minimal
/// PosterEditorScreen(
///   templateUrl: 'https://example.com/bg.jpg',
/// )
///
/// // With pre-filled data
/// PosterEditorScreen(
///   templateUrl: 'https://example.com/bg.jpg',
///   userName: 'Ramesh Patel',
///   designation: 'Ward Member',
///   partyName: 'Jan Seva Party',
///   frame: PosterFrameModel.rajnetaPremium(),
///   onExport: (result) async {
///     await Gal.putImageBytes(result.bytes);
///   },
/// )
/// ```
class PosterEditorScreen extends StatefulWidget {
  // ── Quick-setup params (no need to create a controller manually) ──────────
  final String templateUrl;
  final String? userName;
  final String? designation;
  final String? partyName;
  final String? profileImagePath;
  final PosterFrameModel? frame;
  final List<String> stickerUrls;

  // ── Callbacks ─────────────────────────────────────────────────────────────
  /// Called when the user taps the export/download button.
  final Future<void> Function(dynamic result)? onExport;

  /// Called when the user taps Share.
  final Future<void> Function(dynamic result)? onShare;

  /// Optional background-removal handler.
  final Future<String?> Function(String sourcePath)? onRemoveBackground;

  // ── Advanced: bring your own controller ───────────────────────────────────
  final PosterController? controller;

  const PosterEditorScreen({
    super.key,
    required this.templateUrl,
    this.userName,
    this.designation,
    this.partyName,
    this.profileImagePath,
    this.frame,
    this.stickerUrls = const [],
    this.onExport,
    this.onShare,
    this.onRemoveBackground,
    this.controller,
  });

  @override
  State<PosterEditorScreen> createState() => _PosterEditorScreenState();
}

class _PosterEditorScreenState extends State<PosterEditorScreen> {
  late final PosterController _ctrl;
  bool _ownsCtrl = false;

  final GlobalKey _exportKey = GlobalKey();
  final DraggableScrollableController _sheetCtrl =
      DraggableScrollableController();
  bool _sheetOpen = false;
  int _activeTab = 0;
  bool _exporting = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _ctrl = widget.controller!;
    } else {
      _ownsCtrl = true;
      _ctrl = PosterController(templateUrl: widget.templateUrl);
      // Pre-fill data
      if (widget.userName != null) _ctrl.updateUserName(widget.userName!);
      if (widget.designation != null) {
        _ctrl.updateDesignation(widget.designation!);
      }
      if (widget.partyName != null) _ctrl.updatePartyName(widget.partyName!);
      if (widget.profileImagePath != null) {
        _ctrl.updatePhoto(widget.profileImagePath!);
      }
      if (widget.frame != null) _ctrl.updateFrame(widget.frame!);
    }

    _sheetCtrl.addListener(() {
      final open = _sheetCtrl.isAttached && _sheetCtrl.size > 0.01;
      if (open != _sheetOpen) setState(() => _sheetOpen = open);
    });

    // Backup on enter
    WidgetsBinding.instance.addPostFrameCallback((_) => _ctrl.backupState());
  }

  @override
  void dispose() {
    _sheetCtrl.dispose();
    if (_ownsCtrl) _ctrl.dispose();
    super.dispose();
  }

  Future<void> _export() async {
    setState(() => _exporting = true);
    _ctrl.deselectStickers();
    await Future.delayed(const Duration(milliseconds: 80));

    final result = await PosterExporter.export(_exportKey, pixelRatio: 3.0);
    setState(() => _exporting = false);

    if (!mounted) return;
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Export failed. Please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (widget.onExport != null) {
      await widget.onExport!(result);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Exported ${result.width}×${result.height}px '
            '(${(result.bytes.lengthInBytes / 1024).toStringAsFixed(0)} KB)',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }


  void _openTab(int index) {
    setState(() => _activeTab = index);
    if (!_sheetOpen) {
      setState(() => _sheetOpen = true);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_sheetCtrl.isAttached) {
        _sheetCtrl.animateTo(
          _defaultSheetSize(),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  double _defaultSheetSize() {
    if (_activeTab == 3) return 0.25; // text tab smaller
    return 0.45;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _ctrl.revertState();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : const Color(0xFFF8F9FA),
        appBar: _buildAppBar(),
        body: LayoutBuilder(
          builder: (ctx, constraints) {
            final bodyH = constraints.maxHeight;
            return Stack(
              children: [
                // Canvas area
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: _sheetOpen ? bodyH * _defaultSheetSize() : 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Center(
                      child: PosterCanvas(
                        controller: _ctrl,
                        exportKey: _exportKey,
                      ),
                    ),
                  ),
                ),

                // Draggable bottom sheet
                if (_sheetOpen)
                  DraggableScrollableSheet(
                    controller: _sheetCtrl,
                    initialChildSize: _defaultSheetSize(),
                    minChildSize: 0.12,
                    maxChildSize: 1.0,
                    snap: false,
                    builder: (_, scrollCtrl) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 15,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Drag handle
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onVerticalDragUpdate: (_) {},
                              child: SingleChildScrollView(
                                controller: scrollCtrl,
                                physics: const ClampingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 32,
                                        height: 3.5,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    _buildSheetHeader(),
                                  ],
                                ),
                              ),
                            ),
                            // Tab content
                            Expanded(child: _buildTabContent(scrollCtrl)),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'PRO STUDIO',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 16,
          letterSpacing: 1.5,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.maybePop(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: ElevatedButton(
            onPressed: _exporting ? null : _export,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              elevation: 0,
            ),
            child: _exporting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'PREVIEW',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 1.2,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSheetHeader() {
    const titles = [
      'IMAGE',
      'COLORS',
      'FONTS',
      'TEXT',
      'STICKERS',
      'FRAMES',
      'PROFILE',
    ];
    final title = _activeTab < titles.length ? titles[_activeTab] : 'TOOLS';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 1.2,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(
            height: 32,
            width: 32,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () {
                _sheetCtrl
                    .animateTo(
                      0.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    )
                    .then((_) => setState(() => _sheetOpen = false));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(ScrollController scrollCtrl) {
    switch (_activeTab) {
      case 0:
        return PosterPhotoTab(
          controller: _ctrl,
          scrollController: scrollCtrl,
          onRemoveBackground: widget.onRemoveBackground,
        );
      case 1:
        return PosterColorTab(controller: _ctrl, scrollController: scrollCtrl);
      case 2:
        return PosterFontTab(controller: _ctrl, scrollController: scrollCtrl);
      case 3:
        return PosterTextTab(controller: _ctrl, scrollController: scrollCtrl);
      case 4:
        return PosterStickerTab(
          controller: _ctrl,
          scrollController: scrollCtrl,
          stickerUrls: widget.stickerUrls,
        );
      case 5:
        return PosterFrameTab(controller: _ctrl, scrollController: scrollCtrl);
      case 6:
        return PosterProfileTab(
          controller: _ctrl,
          scrollController: scrollCtrl,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: LayoutBuilder(
        builder: (_, box) {
          final iw = box.maxWidth / 7.5;
          return ListenableBuilder(
            listenable: _ctrl,
            builder: (_, __) => ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              children: [
                _tabItem(0, Icons.image_rounded, 'Image', iw),
                _tabItem(1, Icons.palette_rounded, 'Colors', iw),
                _tabItem(2, Icons.font_download_rounded, 'Fonts', iw),
                _tabItem(3, Icons.text_fields_rounded, 'Text', iw),
                _tabItem(4, Icons.emoji_emotions_rounded, 'Stickers', iw),
                _tabItem(5, Icons.grid_view_rounded, 'Frames', iw),
                _tabItem(6, Icons.person_rounded, 'Profile', iw),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _tabItem(int index, IconData icon, String label, double width) {
    final isSel = _activeTab == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openTab(index),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSel ? Colors.blueAccent : Colors.grey.shade500,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: isSel ? FontWeight.w900 : FontWeight.w600,
                color: isSel ? Colors.blueAccent : Colors.grey.shade500,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

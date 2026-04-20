# poster_creator

A Flutter package to create beautiful, customizable posters using built-in templates.
Users can easily generate posters for events like birthdays, political campaigns, festivals, anniversaries, and more by adding their own photos, text, and styling.

---

## features

* multiple ready-made poster templates
* customizable text (name, designation, etc.)
* change colors, fonts, and styles
* add frames, stickers, and photos
* real-time poster preview
* export poster as image

---

## installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  poster_creator: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## getting started

Import the package:

```dart
import 'package:poster_creator/poster_creator.dart';
```

Initialize the controller with your template and initial data.

---

## usage

```dart
import 'package:flutter/material.dart';
import 'package:poster_creator/poster_creator.dart';

class PosterTestScreen extends StatefulWidget {
  const PosterTestScreen({super.key});

  @override
  State<PosterTestScreen> createState() => _PosterTestScreenState();
}

class _PosterTestScreenState extends State<PosterTestScreen> {
  final GlobalKey _exportKey = GlobalKey();

  late final PosterController ctrl;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    ctrl = PosterController(
      templateUrl: 'https://your-template.jpg',
      initial: PosterCustomization(
        userName: 'Ramesh Patel',
        designation: 'Ward Member',
      ),
    );
  }

  List<Widget> get _tabs => [
    PosterColorTab(controller: ctrl),
    PosterFontTab(controller: ctrl),
    PosterFrameTab(controller: ctrl),
    PosterProfileTab(controller: ctrl),
    PosterTextTab(controller: ctrl),
    PosterStickerTab(controller: ctrl),
    PosterPhotoTab(controller: ctrl),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Poster Editor"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              await PosterExporter.export(_exportKey);
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: PosterCanvas(
              controller: ctrl,
              exportKey: _exportKey,
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _tabs,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.palette), label: "Color"),
          BottomNavigationBarItem(icon: Icon(Icons.font_download), label: "Font"),
          BottomNavigationBarItem(icon: Icon(Icons.crop), label: "Frame"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: "Text"),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: "Sticker"),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: "Photo"),
        ],
      ),
    );
  }
}
```

---

## example use cases

* birthday posters
* political campaign posters
* festival greetings
* anniversary designs
* event promotions

---

## additional information

* contributions are welcome
* feel free to open issues or feature requests
* make sure to follow proper versioning when updating the package

---

## license

MIT License

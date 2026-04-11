import 'package:flutter/material.dart';
import 'poster_demo_page.dart';

void main() {
  runApp(const PosterCreatorExampleApp());
}

class PosterCreatorExampleApp extends StatelessWidget {
  const PosterCreatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poster Creator Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const PosterDemoPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:poster_creator/poster_creator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PosterEditorScreen(
        templateUrl: 'https://via.placeholder.com/400',
        userName: 'Demo User',
        designation: 'Tester',
      ),
    );
  }
}
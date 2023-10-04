// ignore_for_file: unused_import, prefer_const_constructors
import 'package:flutter/material.dart';
import 'views/eg1.dart';
import 'views/eg2.dart';
import 'views/eg3.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: App3(),
    );
  }
}

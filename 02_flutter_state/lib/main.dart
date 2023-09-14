/* Topics to demonstrate:
 * - Stateful widgets
 * - ChangeNotifier
 * - ListenableBuilder / AnimatedBuilder
 * - provider package
 */

// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'views/eg1.dart';
import 'views/eg2.dart';
import 'views/eg3.dart';
import 'views/eg4.dart';
import 'views/eg5.dart';
import 'views/eg6.dart';


void main() {
  runApp(MaterialApp(
    title: 'Flutter State',
    home: Scaffold(
      appBar: AppBar(
        title: const Text('State Management Demo'),
      ),
      body: const Center(
        child: App6()
      )
    )
  ));
}

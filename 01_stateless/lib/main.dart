/* Topics demonstrated:
 * - Running/Debugging a Flutter app
 * - Viewing Flutter framework source code
 * - Widget Inspector
 * - Hot reload & limitations
 * - Material Design
 * - Some basic widgets: 
 *    - AppBar
 *    - Center
 *    - Column
 *    - ElevatedButton
 *    - GestureDetector
 *    - Icon
 *    - ListView and ListTile
 *    - MaterialApp
 *    - Placeholder
 *    - Row
 *    - SizedBox
 *    - Scaffold
 *    - Text
 * - Inherited widgets
 * - Stateless widgets
 */

// ignore_for_file: unused_import
import 'package:flutter/Material.dart';
import 'views/eg1.dart';
import 'views/eg2.dart';
import 'views/eg3.dart';
import 'views/eg4.dart';
import 'views/eg5.dart';
import 'views/eg6.dart';

void main() {
  runApp(const Placeholder());
  // eg1();
}

void eg1() {
  runApp(const App1());
}

void eg2() {
  runApp(const App2());
}

void eg3() {
  runApp(const MaterialApp(
    title: 'App3',
    home: App3(),
  ));
}

void eg4() {
  runApp(const MaterialApp(
    title: 'App4',
    home: App4(),
  ));
}

void eg5() {
  runApp(const MaterialApp(
    title: 'App5',
    home: App5(),
  ));
}

void eg6() {
  runApp(const MaterialApp(
    title: 'App6',
    home: App6(),
    debugShowCheckedModeBanner: false,
  ));
}

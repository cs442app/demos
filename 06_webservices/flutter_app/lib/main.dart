// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/eg1.dart';
import 'views/eg2.dart';
import 'views/eg3.dart';
import 'views/eg4.dart';
import 'views/eg5.dart';
import 'views/eg6.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase just once
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  
  runApp(const App1());
}

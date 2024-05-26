import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:savetify/app.dart';
import 'src/core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


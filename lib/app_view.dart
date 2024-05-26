import 'package:flutter/material.dart';
import 'package:savetify/src/features/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Investment Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade100,
          onBackground: Colors.black,
          primary: const Color(0xFF00B2E7),
          secondary: const Color(0XFFE064F7),
          tertiary: const Color(0xFFFF8D6C),
          outline: Colors.grey,
        )
      ),
      home: const HomeScreen()
    );
  }
}
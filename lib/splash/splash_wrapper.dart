// splash/splash_wrapper.dart
import 'package:flutter/material.dart';
import '../splash/splash_screen.dart';
import '../main.dart'; // Import HomePage

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  bool _started = false;

  @override
  Widget build(BuildContext context) {
    return _started
        ? const HomePage()
        : SplashScreen(
            onStart: () {
              setState(() {
                _started = true;
              });
            },
          );
  }
}

// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});


  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Road Signs TZ App', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('This app helps Tanzanian drivers learn road signs and traffic rules. Works offline.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _launchURL('https://play.google.com/store/apps/details?id=com.example.roadsigns'),
              child: const Text('More Apps'),
            ),
          ],
        ),
      ),
    );
  }
}
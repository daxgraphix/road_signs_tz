// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'services/favorites_service.dart';
import 'services/theme_service.dart';
import 'screens/about_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/qa_screen.dart';
import 'splash/splash_wrapper.dart'; // ✅ Use wrapper instead of direct SplashScreen
import 'tabs/road_signs_tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = ThemeService();
  await themeService.loadTheme();
  final favoritesService = FavoritesService();
  await favoritesService.loadFavorites();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeService),
        ChangeNotifierProvider(create: (_) => favoritesService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return MaterialApp(
      title: 'Road Signs TZ',
      debugShowCheckedModeBanner: false,
      themeMode: themeService.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const SplashWrapper(), // ✅ Use SplashWrapper here
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const SettingsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Road Signs TZ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _openSettings(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/car_logo.png', width: 120),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RoadSignsTabsScreen()));
              },
              child: const Text('Road Signs'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const QAScreen()));
              },
              child: const Text('Driving Q & A'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          leading: const Icon(Icons.brightness_6),
          title: const Text('Theme'),
          trailing: DropdownButton<ThemeMode>(
            value: themeService.themeMode,
            items: const [
              DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
              DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
              DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
            ],
            onChanged: (mode) => themeService.updateTheme(mode!),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.share),
          title: const Text('Share App'),
          onTap: () => Share.share('Check out this Road Signs app: https://play.google.com/store/apps/details?id=com.example.roadsigns'),
        ),
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('Favorites'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen())),
        ),
        ListTile(
          leading: const Icon(Icons.system_update),
          title: const Text('Check for Updates'),
          onTap: () => Share.share('Latest version available on Play Store.'),
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())),
        ),
      ],
    );
  }
}

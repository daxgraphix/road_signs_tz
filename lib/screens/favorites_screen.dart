// lib/screens/favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/favorites_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Favorite Road Signs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...favorites.favoriteSigns.map((title) => ListTile(title: Text(title))),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Favorite Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...favorites.favoriteQuestions.map((q) => ListTile(title: Text(q))),
        ],
      ),
    );
  }
}
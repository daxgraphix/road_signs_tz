import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesService extends ChangeNotifier {
  List<String> _favoriteSigns = [];
  List<String> _favoriteQuestions = [];

  List<String> get favoriteSigns => _favoriteSigns;
  List<String> get favoriteQuestions => _favoriteQuestions;

  FavoritesService();

  // Public method to be called in main()
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteSigns = List<String>.from(json.decode(prefs.getString('favoriteSigns') ?? '[]'));
    _favoriteQuestions = List<String>.from(json.decode(prefs.getString('favoriteQuestions') ?? '[]'));
    notifyListeners();
  }

  void toggleSignFavorite(String title) {
    if (_favoriteSigns.contains(title)) {
      _favoriteSigns.remove(title);
    } else {
      _favoriteSigns.add(title);
    }
    _saveFavorites();
    notifyListeners();
  }

  void toggleQAFavorite(String question) {
    if (_favoriteQuestions.contains(question)) {
      _favoriteQuestions.remove(question);
    } else {
      _favoriteQuestions.add(question);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isSignFavorite(String title) => _favoriteSigns.contains(title);
  bool isQAFavorite(String question) => _favoriteQuestions.contains(question);

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favoriteSigns', json.encode(_favoriteSigns));
    await prefs.setString('favoriteQuestions', json.encode(_favoriteQuestions));
  }
}

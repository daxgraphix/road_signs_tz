// lib/tabs/road_signs_tabs_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/road_signs_data.dart';
import '../services/favorites_service.dart';

class RoadSignsTabsScreen extends StatefulWidget {
  const RoadSignsTabsScreen({super.key});

  @override
  State<RoadSignsTabsScreen> createState() => _RoadSignsTabsScreenState();
}

class _RoadSignsTabsScreenState extends State<RoadSignsTabsScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesService>(context);
    return DefaultTabController(
      length: roadSignsData.keys.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Road Signs'),
          bottom: TabBar(
            isScrollable: true,
            tabs: roadSignsData.keys.map((key) => Tab(text: key)).toList(),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(hintText: 'Search road signs...'),
                onChanged: (val) => setState(() => query = val),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: roadSignsData.keys.map((key) {
                  final signs = roadSignsData[key]!
                      .where((sign) =>
                          sign['title']!.toLowerCase().contains(query.toLowerCase()) ||
                          sign['description']!.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                  return ListView.builder(
                    itemCount: signs.length,
                    itemBuilder: (context, index) {
                      final sign = signs[index];
                      final isFav = favorites.isSignFavorite(sign['title']!);
                      return ListTile(
                        title: Text(sign['title']!),
                        subtitle: Text(sign['description']!),
                        trailing: IconButton(
                          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                          onPressed: () => favorites.toggleSignFavorite(sign['title']!),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
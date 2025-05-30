// lib/screens/qa_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/qa_data.dart';
import '../services/favorites_service.dart';

class QAScreen extends StatefulWidget {
  const QAScreen({super.key});


  @override
  State<QAScreen> createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesService>(context);
    final filteredQA = qaData.where((qa) =>
      qa['q']!.toLowerCase().contains(query.toLowerCase()) ||
      qa['a']!.toLowerCase().contains(query.toLowerCase())
    ).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Q & A')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Search questions...'),
              onChanged: (val) => setState(() => query = val),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredQA.length,
              itemBuilder: (context, index) {
                final item = filteredQA[index];
                final isFav = favorites.isQAFavorite(item['q']!);
                return ListTile(
                  title: Text(item['q']!),
                  subtitle: Text(item['a']!),
                  trailing: IconButton(
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                    onPressed: () => favorites.toggleQAFavorite(item['q']!),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutNFeel Store',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<AppStoreItem> items = const [
    AppStoreItem(
      title: 'Notes Pro',
      category: 'Productivity',
      imageUrl: 'https://picsum.photos/600/300?1',
    ),
    AppStoreItem(
      title: 'Fitness Plus',
      category: 'Health & Fitness',
      imageUrl: 'https://picsum.photos/600/300?2',
    ),
    AppStoreItem(
      title: 'Travel Buddy',
      category: 'Travel',
      imageUrl: 'https://picsum.photos/600/300?3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Today')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 600;
          if (isWide) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 0.75,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return AppStoreCard(item: item);
              },
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: AppStoreCard(item: item),
              );
            },
          );
        },
      ),
    );
  }
}

class AppStoreItem {
  final String title;
  final String category;
  final String imageUrl;

  const AppStoreItem({
    required this.title,
    required this.category,
    required this.imageUrl,
  });
}

class AppStoreCard extends StatelessWidget {
  final AppStoreItem item;

  const AppStoreCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            item.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.category.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Text(
          item.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      Category(name: 'Fridge', color: Colors.lightGreen, icon: Icons.kitchen),
      Category(name: 'Freezer', color: Colors.lightBlue, icon: Icons.ac_unit),
      Category(name: 'Cupboard', color: Colors.orangeAccent, icon: Icons.storage),
      // Add more categories if needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Your Kitchen'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: categories[index],
            onTap: () {
              if (categories[index].name == 'Cupboard') {
                Navigator.pushNamed(context, '/home');
              }
              // Implement navigation for other categories if needed
            },
          );
        },
      ),
    );
  }
}

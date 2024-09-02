import 'package:flutter/material.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';
import 'models/grocery_item.dart';
import 'screens/home_screen.dart';
import 'screens/add_edit_screen.dart';
import 'screens/details_screen.dart';
import 'screens/welcome_page.dart'; 

void main() {
  runApp(const CupboardInventoryApp());
}

class CupboardInventoryApp extends StatelessWidget {
  const CupboardInventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupboard Inventory',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomePage(), // Set the initial screen to WelcomePage
      routes: {
        '/home': (context) => const HomeScreen(), // Add a route to HomeScreen
        '/add': (context) => const AddEditScreen(),
        '/details': (context) => DetailsScreen(
          item: ModalRoute.of(context)!.settings.arguments as GroceryItem,
        ),
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import 'add_edit_screen.dart';
import '../widgets/grocery_item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GroceryItem> items = [];

  void _addItem(GroceryItem item) {
    setState(() {
      items.add(item);
    });
  }

  void _editItem(GroceryItem item) {
    setState(() {
      final index = items.indexWhere((element) => element.id == item.id);
      if (index != -1) {
        items[index] = item;
      }
    });
  }

  void _deleteItem(String id) {
    setState(() {
      items.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupboard Inventory'),
      ),
      body: items.isEmpty
          ? const Center(child: Text('No items in cupboard'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GroceryItemCard(
                  item: items[index],
                  onEdit: _editItem,
                  onDelete: _deleteItem,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditScreen(),
            ),
          );

          if (newItem != null) {
            _addItem(newItem);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

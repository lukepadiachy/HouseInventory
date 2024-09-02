import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import '../screens/details_screen.dart';

class GroceryItemCard extends StatelessWidget {
  final GroceryItem item;
  final Function(GroceryItem) onEdit;
  final Function(String) onDelete;

  const GroceryItemCard({
    Key? key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getCategoryIcon(item.category),
            size: 30,
          ),
        ),
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity: ${item.quantity}'),
            Text(
              'Added On: ${_formatDateTime(item.timestamp)}', // Format timestamp
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            onDelete(item.id);
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(item: item),
            ),
          );
        },
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Dairy':
        return Icons.local_drink;
      case 'Produce':
        return Icons.local_florist;
      case 'Frozen':
        return Icons.ac_unit;
      case 'Bakery':
        return Icons.bakery_dining;
      case 'Beverages':
        return Icons.local_bar;
      default:
        return Icons.fastfood;
    }
  }
}

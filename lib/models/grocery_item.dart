
class GroceryItem {
  String id;
  String name;
  String quantity;
  String category;
  DateTime timestamp;  // Add this line

  GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    required this.timestamp,  // Update constructor
  });
}

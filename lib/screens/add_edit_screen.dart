import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/grocery_item.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({super.key});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  int _currentStep = 0;
  String _itemName = '';
  String _selectedCategory = 'Dairy';
  int _quantity = 1;
  String _quantityType = 'Single Item';

  final List<String> _categories = ['Dairy', 'Produce', 'Frozen', 'Bakery', 'Beverages'];
  final List<String> _quantityTypes = ['Single Item', 'Box'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Grocery Item')),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          } else {
            _saveItem(); // Save the item when the user reaches the last step
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          }
        },
        steps: [
          Step(
            title: const Text('Item Name'),
            content: TextFormField(
              initialValue: _itemName,
              decoration: const InputDecoration(
                labelText: 'Enter Item Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _itemName = value;
                });
              },
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Category'),
            content: DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Select Category',
                border: OutlineInputBorder(),
              ),
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Quantity'),
            content: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _quantity.toString(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _quantity = int.tryParse(value) ?? 1;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _quantityType,
                        onChanged: (newValue) {
                          setState(() {
                            _quantityType = newValue!;
                          });
                        },
                        items: _quantityTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Quantity Type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
          Step(
            title: const Text('Review & Save'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: $_itemName'),
                Text('Category: $_selectedCategory'),
                Text('Quantity: $_quantity $_quantityType'),
              ],
            ),
            isActive: _currentStep >= 3,
          ),
        ],
      ),
    );
  }

  void _saveItem() {
  if (_itemName.isEmpty) {
    // Show an error if the item name is empty
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter an item name')),
    );
    return;
  }

  final newItem = GroceryItem(
    id: DateTime.now().toString(),
    name: _itemName,
    quantity: '$_quantity $_quantityType',
    category: _selectedCategory,
    timestamp: DateTime.now(),  // Add timestamp here
  );

  Navigator.pop(context, newItem);
}}
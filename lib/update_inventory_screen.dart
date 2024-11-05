import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateInventoryScreen extends StatelessWidget {
  final String documentId;
  final String currentName;
  final String currentQuantity;

  final TextEditingController nameController;
  final TextEditingController quantityController;

  UpdateInventoryScreen({
    required this.documentId,
    required this.currentName,
    required this.currentQuantity,
  })  : nameController = TextEditingController(text: currentName),
        quantityController = TextEditingController(text: currentQuantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Item')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number, // Optional: keeps it numeric
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedName = nameController.text;
                final updatedQuantity = quantityController.text;

                if (updatedName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid item name')),
                  );
                  return;
                }

                if (updatedQuantity.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid quantity')),
                  );
                  return;
                }

                // Update Firestore with the name and quantity as strings
                await FirebaseFirestore.instance
                    .collection('inventory')
                    .doc(documentId)
                    .update({
                  'name': updatedName,
                  'quantity': updatedQuantity,
                });

                Navigator.pop(context); // Return to InventoryScreen
              },
              child: Text('Update Item'),
            ),
          ],
        ),
      ),
    );
  }
}

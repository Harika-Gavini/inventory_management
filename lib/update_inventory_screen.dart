import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateInventoryScreen extends StatelessWidget {
  final String id;
  final TextEditingController nameController;
  final TextEditingController quantityController;

  UpdateInventoryScreen(
      {required this.id, required String name, required int quantity})
      : nameController = TextEditingController(text: name),
        quantityController = TextEditingController(text: quantity.toString());

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
                decoration: InputDecoration(labelText: 'Item Name')),
            TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity')),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('inventory')
                    .doc(id)
                    .update({
                  'name': nameController.text,
                  'quantity': int.parse(quantityController.text),
                });
                Navigator.pop(context);
              },
              child: Text('Update Item'),
            ),
          ],
        ),
      ),
    );
  }
}

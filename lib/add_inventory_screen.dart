import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddInventoryScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Item')),
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
                FirebaseFirestore.instance.collection('inventory').add({
                  'name': nameController.text,
                  'quantity': int.parse(quantityController.text),
                });
                Navigator.pop(context);
              },
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}

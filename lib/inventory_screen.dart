import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'update_inventory_screen.dart'; // Import the update screen

class InventoryScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _firestore.collection('inventory').get(), // Fetching documents
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final documents =
                snapshot.data!.docs; // Use null check to access docs
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                // Access document data safely
                final doc = documents[index]; // Get the document
                final data = doc.data(); // Retrieve data from the document

                return ListTile(
                  title:
                      Text(data['name'] ?? 'Unnamed Item'), // Display item name
                  subtitle: Text(
                      'Quantity: ${data['quantity'] ?? 0}'), // Display item quantity
                  onTap: () {
                    // Navigate to UpdateInventoryScreen with document data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateInventoryScreen(
                                id: doc.id,
                                name: data['name'],
                                quantity: data['quantity'],
                              )),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete the document from Firestore
                      FirebaseFirestore.instance
                          .collection('inventory')
                          .doc(doc.id)
                          .delete();
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No items found.'));
          }
        },
      ),
    );
  }
}

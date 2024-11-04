import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _firestore.collection('inventory').get(),  // Fetching documents
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final documents = snapshot.data!.docs; // Use null check to access docs
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                // Access document data safely
                final data = documents[index].data(); 
                return ListTile(
                  title: Text(data['name'] ?? 'Unnamed Item'), // Example field
                  subtitle: Text('Quantity: ${data['quantity'] ?? 0}'), // Example field
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

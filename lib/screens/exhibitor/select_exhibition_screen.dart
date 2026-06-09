import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'booth_grid_screen.dart';

class SelectExhibitionScreen extends StatelessWidget {
  const SelectExhibitionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Exhibition',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('exhibitions').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No exhibitions found',
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var exhibition = snapshot.data!.docs[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    exhibition['title'],
                  ),
                  subtitle: Text(
                    exhibition['location'],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BoothGridScreen(
                            exhibitionId: exhibition.id,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View Booths',
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageExhibitionsScreen extends StatelessWidget {
  const ManageExhibitionsScreen({
    super.key,
  });

  Future<void> deleteExhibition(String id) async {
    await FirebaseFirestore.instance.collection('exhibitions').doc(id).delete();
  }

  Future<void> togglePublish({
    required String id,
    required bool currentValue,
  }) async {
    await FirebaseFirestore.instance.collection('exhibitions').doc(id).update({
      'isPublished': !currentValue,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Exhibitions',
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
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exhibition['location'],
                      ),
                      Text(
                        exhibition['isPublished'] ? 'Published' : 'Unpublished',
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await togglePublish(
                            id: exhibition.id,
                            currentValue: exhibition['isPublished'],
                          );
                        },
                        icon: const Icon(
                          Icons.visibility,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await deleteExhibition(
                            exhibition.id,
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageBoothsScreen extends StatelessWidget {
  const ManageBoothsScreen({
    super.key,
  });

  Future<void> deleteBooth(String id) async {
    await FirebaseFirestore.instance.collection('booths').doc(id).delete();
  }

  Future<void> toggleAvailability({
    required String id,
    required bool currentValue,
  }) async {
    await FirebaseFirestore.instance.collection('booths').doc(id).update({
      'isBooked': !currentValue,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Booths',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('booths').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No booths found',
              ),
            );
          }

          Map<String, List<QueryDocumentSnapshot>> groupedBooths = {};

          for (var booth in snapshot.data!.docs) {
            String exhibitionId = booth['exhibitionId'];

            if (!groupedBooths.containsKey(exhibitionId)) {
              groupedBooths[exhibitionId] = [];
            }

            groupedBooths[exhibitionId]!.add(booth);
          }

          return ListView(
            children: groupedBooths.entries.map((entry) {
              List<QueryDocumentSnapshot> booths = entry.value;

              String exhibitionTitle = booths.first.data().toString().contains(
                        'exhibitionTitle',
                      )
                  ? booths.first['exhibitionTitle']
                  : 'Unknown Exhibition';

              return Card(
                margin: const EdgeInsets.all(
                  12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exhibitionTitle,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ...booths.map(
                        (booth) {
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            padding: const EdgeInsets.all(
                              12,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Booth ${booth['boothNumber']}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Type: ${booth['boothType']}',
                                      ),
                                      Text(
                                        'Price: \$${booth['price']}',
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        booth['isBooked']
                                            ? 'Booked'
                                            : 'Available',
                                        style: TextStyle(
                                          color: booth['isBooked']
                                              ? Colors.red
                                              : Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await toggleAvailability(
                                          id: booth.id,
                                          currentValue: booth['isBooked'],
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.swap_horiz,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await deleteBooth(
                                          booth.id,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

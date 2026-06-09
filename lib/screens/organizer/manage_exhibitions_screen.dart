import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit_exhibition_screen.dart';
import 'manage_booth_screen.dart';

class ManageOrganizerExhibitionsScreen
    extends StatelessWidget {
  const ManageOrganizerExhibitionsScreen({
    super.key,
  });

  Future<void> deleteExhibition(
      String id) async {
    await FirebaseFirestore.instance
        .collection('exhibitions')
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Exhibitions',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('exhibitions')
            .where(
          'organizerId',
          isEqualTo: FirebaseAuth
              .instance
              .currentUser!
              .uid,
        )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No exhibitions found',
              ),
            );
          }

          return ListView.builder(
            itemCount:
            snapshot.data!.docs.length,
            itemBuilder:
                (context, index) {
              var exhibition =
              snapshot.data!.docs[index];

              return Card(
                margin:
                const EdgeInsets.all(
                  10,
                ),
                elevation: 3,
                child: Padding(
                  padding:
                  const EdgeInsets.all(
                    10,
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Text(
                        exhibition['title'],
                        style:
                        const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 8),

                      Text(
                        exhibition[
                        'location'],
                      ),

                      const SizedBox(
                          height: 5),

                      Text(
                        exhibition[
                        'description'],
                      ),

                      const SizedBox(
                          height: 8),

                      Text(
                        ' Start Date: ${exhibition['startDate']}',
                        style:
                        const TextStyle(
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),

                      Text(
                        ' End Date: ${exhibition['endDate']}',
                        style:
                        const TextStyle(
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),

                      const SizedBox(
                          height: 10),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .end,
                        children: [
                          IconButton(
                            onPressed:
                                () {
                              Navigator
                                  .push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          EditExhibitionScreen(
                                            exhibitionId: exhibition.id,
                                            title: exhibition['title'],
                                            description: exhibition['description'],
                                            location: exhibition['location'],
                                            startDate: exhibition['startDate'],
                                            endDate: exhibition['endDate'],
                                          ),
                                ),
                              );
                            },
                            icon:
                            const Icon(
                              Icons.edit,
                            ),
                          ),

                          IconButton(
                            onPressed:
                                () {
                              Navigator
                                  .push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                      ManageBoothScreen(
                                        exhibitionId:
                                        exhibition
                                            .id,
                                        exhibitionName:
                                        exhibition[
                                        'title'],
                                      ),
                                ),
                              );
                            },
                            icon:
                            const Icon(
                              Icons.store,
                            ),
                          ),

                          IconButton(
                            onPressed:
                                () async {
                              await deleteExhibition(
                                exhibition.id,
                              );
                            },
                            icon:
                            const Icon(
                              Icons.delete,
                              color:
                              Colors.red,
                            ),
                          ),
                        ],
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
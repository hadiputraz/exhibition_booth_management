import 'package:flutter/material.dart';

import '../../models/exhibition_model.dart';
import '../../services/exhibition_service.dart';

class GuestExhibitionScreen extends StatefulWidget {
  const GuestExhibitionScreen({
    super.key,
  });

  @override
  State<GuestExhibitionScreen> createState() => _GuestExhibitionScreenState();
}

class _GuestExhibitionScreenState extends State<GuestExhibitionScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exhibitions',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search Exhibition...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ExhibitionModel>>(
              stream: ExhibitionService().getPublishedExhibitions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No exhibitions available',
                    ),
                  );
                }

                List<ExhibitionModel> exhibitions = snapshot.data!;

                List<ExhibitionModel> filteredExhibitions =
                    exhibitions.where((exhibition) {
                  return exhibition.title.toLowerCase().contains(searchText) ||
                      exhibition.location.toLowerCase().contains(searchText);
                }).toList();

                if (filteredExhibitions.isEmpty) {
                  return const Center(
                    child: Text(
                      'No matching exhibitions',
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredExhibitions.length,
                  itemBuilder: (context, index) {
                    ExhibitionModel exhibition = filteredExhibitions[index];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(exhibition.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exhibition.description,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Location: ${exhibition.location}',
                            ),
                            Text(
                              'Start: ${exhibition.startDate}',
                            ),
                            Text(
                              'End: ${exhibition.endDate}',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

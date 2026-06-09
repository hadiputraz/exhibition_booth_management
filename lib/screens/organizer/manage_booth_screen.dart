import 'package:flutter/material.dart';

import '../../models/booth_model.dart';
import '../../services/booth_service.dart';

import 'add_booth_screen.dart';

class ManageBoothScreen extends StatelessWidget {
  final String exhibitionId;

  final String exhibitionName;

  const ManageBoothScreen({
    super.key,
    required this.exhibitionId,
    required this.exhibitionName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Booths',
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBoothScreen(
                exhibitionId: exhibitionId,
                exhibitionName: exhibitionName,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder<List<BoothModel>>(
        stream: BoothService().getBooths(
          exhibitionId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No booths found',
              ),
            );
          }

          List<BoothModel> booths = snapshot.data!;

          return ListView.builder(
            itemCount: booths.length,
            itemBuilder: (context, index) {
              BoothModel booth = booths[index];

              return Card(
                margin: const EdgeInsets.all(
                  10,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exhibition: ${booth.exhibitionTitle}',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Booth: ${booth.boothNumber}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Type: ${booth.boothType}',
                      ),
                      Text(
                        'Price: \$${booth.price}',
                      ),
                      const SizedBox(height: 5),
                      Text(
                        booth.isBooked ? 'Booked' : 'Available',
                        style: TextStyle(
                          color: booth.isBooked ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
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

import 'package:flutter/material.dart';

import '../../models/booth_model.dart';
import '../../services/booth_service.dart';

import 'application_screen.dart';

class BoothGridScreen extends StatefulWidget {
  final String exhibitionId;

  const BoothGridScreen({
    super.key,
    required this.exhibitionId,
  });

  @override
  State<BoothGridScreen> createState() => _BoothGridScreenState();
}

class _BoothGridScreenState extends State<BoothGridScreen> {
  BoothModel? selectedBooth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booth Selection',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<BoothModel>>(
        stream: BoothService().getBooths(
          widget.exhibitionId,
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
                'No booths available',
              ),
            );
          }

          List<BoothModel> booths = snapshot.data!;

          return Column(
            children: [
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.square,
                          color: Colors.green,
                        ),
                        SizedBox(width: 5),
                        Text('Available'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.square,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Text('Booked'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.square,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 5),
                        Text('Selected'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: booths.length,
                  itemBuilder: (context, index) {
                    BoothModel booth = booths[index];

                    Color boothColor;

                    if (selectedBooth?.id == booth.id) {
                      boothColor = Colors.blue;
                    } else if (booth.isBooked) {
                      boothColor = Colors.red;
                    } else {
                      boothColor = Colors.green;
                    }

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                booth.boothNumber,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Type: ${booth.boothType}',
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Price: \$${booth.price}',
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Amenities:',
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    '• Power Supply',
                                  ),
                                  const Text(
                                    '• WiFi Access',
                                  ),
                                  const Text(
                                    '• Lighting',
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    booth.isBooked
                                        ? 'Status: Booked'
                                        : 'Status: Available',
                                    style: TextStyle(
                                      color: booth.isBooked
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  child: const Text(
                                    'Close',
                                  ),
                                ),
                                if (!booth.isBooked)
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          selectedBooth = booth;
                                        },
                                      );

                                      Navigator.pop(
                                        context,
                                      );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ApplicationScreen(
                                            booth: booth,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Select Booth',
                                    ),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: boothColor,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              booth.boothNumber,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              booth.boothType,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

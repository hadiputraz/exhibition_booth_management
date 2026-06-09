import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FloorPlanScreen extends StatefulWidget {
  const FloorPlanScreen({
    super.key,
  });

  @override
  State<FloorPlanScreen> createState() => _FloorPlanScreenState();
}

class _FloorPlanScreenState extends State<FloorPlanScreen> {
  File? selectedImage;

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(
          pickedImage.path,
        );
      });
    }
  }

  Widget buildBooth(
    String boothName,
    Color color,
  ) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Center(
        child: Text(
          boothName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Floor Plan Management',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: pickImage,
                child: const Text(
                  'Upload Floor Plan',
                ),
              ),
            ),
            const SizedBox(height: 20),
            selectedImage == null
                ? const Text(
                    'No floor plan selected',
                  )
                : Container(
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.contain,
                    ),
                  ),
            const SizedBox(height: 30),
            const Text(
              'Example Exhibition Floor Plan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                buildBooth(
                  'A1',
                  Colors.green,
                ),
                buildBooth(
                  'A2',
                  Colors.red,
                ),
                buildBooth(
                  'A3',
                  Colors.green,
                ),
                buildBooth(
                  'B1',
                  Colors.blue,
                ),
                buildBooth(
                  'B2',
                  Colors.green,
                ),
                buildBooth(
                  'B3',
                  Colors.red,
                ),
                buildBooth(
                  'C1',
                  Colors.green,
                ),
                buildBooth(
                  'C2',
                  Colors.green,
                ),
                buildBooth(
                  'VIP',
                  Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Colors.green,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Available',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Booked',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.square,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'VIP',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

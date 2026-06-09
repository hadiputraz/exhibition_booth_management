import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditExhibitionScreen extends StatefulWidget {
  final String exhibitionId;

  final String title;

  final String description;

  final String location;

  final String startDate;

  final String endDate;

  const EditExhibitionScreen({
    super.key,
    required this.exhibitionId,
    required this.title,
    required this.description,
    required this.location,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<EditExhibitionScreen> createState() =>
      _EditExhibitionScreenState();
}

class _EditExhibitionScreenState
    extends State<EditExhibitionScreen> {
  late TextEditingController titleController;

  late TextEditingController descriptionController;

  late TextEditingController locationController;

  late TextEditingController startDateController;

  late TextEditingController endDateController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.title,
    );

    descriptionController = TextEditingController(
      text: widget.description,
    );

    locationController = TextEditingController(
      text: widget.location,
    );

    startDateController = TextEditingController(
      text: widget.startDate,
    );

    endDateController = TextEditingController(
      text: widget.endDate,
    );
  }

  Future<void> updateExhibition() async {
    await FirebaseFirestore.instance
        .collection('exhibitions')
        .doc(widget.exhibitionId)
        .update({
      'title': titleController.text.trim(),
      'description':
      descriptionController.text.trim(),
      'location': locationController.text.trim(),
      'startDate':
      startDateController.text.trim(),
      'endDate':
      endDateController.text.trim(),
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Exhibition Updated Successfully',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Exhibition',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
              descriptionController,
              decoration:
              const InputDecoration(
                labelText: 'Description',
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
              locationController,
              decoration:
              const InputDecoration(
                labelText: 'Location',
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
              startDateController,
              decoration:
              const InputDecoration(
                labelText: 'Start Date',
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
              endDateController,
              decoration:
              const InputDecoration(
                labelText: 'End Date',
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                updateExhibition,
                child: const Text(
                  'Update Exhibition',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../models/exhibition_model.dart';

import '../../services/exhibition_service.dart';

class AddExhibitionScreen
    extends StatefulWidget {

  const AddExhibitionScreen({
    super.key,
  });

  @override
  State<AddExhibitionScreen>
  createState() =>
      _AddExhibitionScreenState();
}

class _AddExhibitionScreenState
    extends State<AddExhibitionScreen> {

  final TextEditingController
  titleController =
  TextEditingController();

  final TextEditingController
  descriptionController =
  TextEditingController();

  final TextEditingController
  locationController =
  TextEditingController();

  final TextEditingController
  startDateController =
  TextEditingController();

  final TextEditingController
  endDateController =
  TextEditingController();

  bool isPublished = true;

  bool isLoading = false;

  Future<void> addExhibition() async {

    setState(() {

      isLoading = true;
    });

    ExhibitionModel exhibition =
    ExhibitionModel(

      id: '',

      organizerId:
      FirebaseAuth
          .instance
          .currentUser!
          .uid,

      title:
      titleController.text
          .trim(),

      description:
      descriptionController
          .text
          .trim(),

      location:
      locationController.text
          .trim(),

      startDate:
      startDateController.text
          .trim(),

      endDate:
      endDateController.text
          .trim(),

      isPublished:
      isPublished,
    );

    await ExhibitionService()
        .addExhibition(
      exhibition,
    );

    setState(() {

      isLoading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          'Exhibition Added Successfully',
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
          'Add Exhibition',
        ),

        centerTitle: true,
      ),

      body:
      SingleChildScrollView(

        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(

          children: [

            TextField(

              controller:
              titleController,

              decoration:
              const InputDecoration(

                labelText:
                'Exhibition Title',

                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              descriptionController,

              maxLines: 3,

              decoration:
              const InputDecoration(

                labelText:
                'Description',

                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              locationController,

              decoration:
              const InputDecoration(

                labelText:
                'Location',

                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              startDateController,

              decoration:
              const InputDecoration(

                labelText:
                'Start Date',

                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              endDateController,

              decoration:
              const InputDecoration(

                labelText:
                'End Date',

                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 20),

            SwitchListTile(

              title: const Text(
                'Publish Exhibition',
              ),

              value:
              isPublished,

              onChanged: (value) {

                setState(() {

                  isPublished =
                      value;
                });
              },
            ),

            const SizedBox(
                height: 30),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton(

                onPressed:
                isLoading
                    ? null
                    : addExhibition,

                child: isLoading

                    ? const CircularProgressIndicator()

                    : const Text(
                  'Add Exhibition',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
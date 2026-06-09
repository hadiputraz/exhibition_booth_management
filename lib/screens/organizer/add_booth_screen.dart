import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../models/booth_model.dart';

import '../../services/booth_service.dart';

class AddBoothScreen
    extends StatefulWidget {

  final String exhibitionId;

  final String exhibitionName;

  const AddBoothScreen({

    super.key,

    required this.exhibitionId,

    required this.exhibitionName,
  });

  @override
  State<AddBoothScreen>
  createState() =>
      _AddBoothScreenState();
}

class _AddBoothScreenState
    extends State<AddBoothScreen> {

  final TextEditingController
  boothNumberController =
  TextEditingController();

  final TextEditingController
  boothTypeController =
  TextEditingController();

  final TextEditingController
  priceController =
  TextEditingController();

  bool isLoading = false;

  Future<void> addBooth() async {

    setState(() {

      isLoading = true;
    });

    BoothModel booth =
    BoothModel(

      id: '',

      organizerId:
      FirebaseAuth
          .instance
          .currentUser!
          .uid,

      exhibitionId:
      widget.exhibitionId,

      exhibitionTitle:
      widget.exhibitionName,

      boothNumber:
      boothNumberController
          .text
          .trim(),

      boothType:
      boothTypeController
          .text
          .trim(),

      price:
      double.parse(

        priceController.text,
      ),

      isBooked: false,
    );

    await BoothService()
        .addBooth(booth);

    setState(() {

      isLoading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          'Booth Added Successfully',
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
          'Add Booth',
        ),

        centerTitle: true,
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(

          children: [

            TextField(

              controller:
              boothNumberController,

              decoration:
              const InputDecoration(

                labelText:
                'Booth Number',

                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              boothTypeController,

              decoration:
              const InputDecoration(

                labelText:
                'Booth Type',

                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              priceController,

              keyboardType:
              TextInputType.number,

              decoration:
              const InputDecoration(

                labelText:
                'Price',

                border:
                OutlineInputBorder(),
              ),
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
                    : addBooth,

                child: isLoading

                    ? const CircularProgressIndicator()

                    : const Text(
                  'Add Booth',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
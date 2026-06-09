import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/booth_model.dart';
import '../../models/application_model.dart';

import '../../services/application_service.dart';

class ApplicationScreen
    extends StatefulWidget {

  final BoothModel booth;

  const ApplicationScreen({

    super.key,

    required this.booth,
  });

  @override
  State<ApplicationScreen>
  createState() =>
      _ApplicationScreenState();
}

class _ApplicationScreenState
    extends State<ApplicationScreen> {

  final TextEditingController
  companyNameController =
  TextEditingController();

  final TextEditingController
  companyDescriptionController =
  TextEditingController();

  final TextEditingController
  exhibitDescriptionController =
  TextEditingController();

  final TextEditingController
  startDateController =
  TextEditingController();

  final TextEditingController
  endDateController =
  TextEditingController();

  List<String> selectedAddOns =
  [];

  Future<void>
  submitApplication() async {

    String userId =
        FirebaseAuth
            .instance
            .currentUser!
            .uid;

    ApplicationModel application =
    ApplicationModel(

      id: '',

      userId: userId,

      organizerId:
      widget
          .booth
          .organizerId,

      exhibitionId:
      widget
          .booth
          .exhibitionId,

      boothIds: [
        widget.booth.id,
      ],

      companyName:
      companyNameController
          .text
          .trim(),

      companyDescription:
      companyDescriptionController
          .text
          .trim(),

      exhibitDescription:
      exhibitDescriptionController
          .text
          .trim(),

      startDate:
      startDateController
          .text
          .trim(),

      endDate:
      endDateController
          .text
          .trim(),

      addOns:
      selectedAddOns,

      status: 'Pending',

      reason: null,
    );

    await ApplicationService()
        .submitApplication(
      application,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          'Application Submitted',
        ),
      ),
    );

    Navigator.pop(context);
  }

  Widget buildAddOnCheckbox(
      String addOn) {

    return CheckboxListTile(

      title: Text(addOn),

      value:
      selectedAddOns
          .contains(addOn),

      onChanged: (value) {

        setState(() {

          if (value == true) {

            selectedAddOns
                .add(addOn);

          } else {

            selectedAddOns
                .remove(addOn);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Booth Application',
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
              companyNameController,

              decoration:
              const InputDecoration(

                labelText:
                'Company Name',
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              companyDescriptionController,

              decoration:
              const InputDecoration(

                labelText:
                'Company Description',
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              exhibitDescriptionController,

              decoration:
              const InputDecoration(

                labelText:
                'Exhibit Description',
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
                'Event Start Date',
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
                'Event End Date',
              ),
            ),

            const SizedBox(
                height: 30),

            const Align(

              alignment:
              Alignment.centerLeft,

              child: Text(

                'Additional Items',

                style: TextStyle(

                  fontSize: 18,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            buildAddOnCheckbox(
              'Additional Furniture',
            ),

            buildAddOnCheckbox(
              'Extended WiFi',
            ),

            buildAddOnCheckbox(
              'Promotional Spot',
            ),

            buildAddOnCheckbox(
              'Extra Lighting',
            ),

            const SizedBox(
                height: 30),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton(

                onPressed:
                submitApplication,

                child:
                const Text(
                  'Submit Application',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
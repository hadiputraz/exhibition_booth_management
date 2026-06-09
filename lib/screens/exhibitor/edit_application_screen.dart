import 'package:flutter/material.dart';

import '../../models/application_model.dart';
import '../../services/application_service.dart';

class EditApplicationScreen extends StatefulWidget {
  final ApplicationModel application;

  const EditApplicationScreen({
    super.key,
    required this.application,
  });

  @override
  State<EditApplicationScreen> createState() => _EditApplicationScreenState();
}

class _EditApplicationScreenState extends State<EditApplicationScreen> {
  late TextEditingController companyDescriptionController;

  late TextEditingController exhibitDescriptionController;

  List<String> selectedAddOns = [];

  @override
  void initState() {
    super.initState();

    companyDescriptionController = TextEditingController(
      text: widget.application.companyDescription,
    );

    exhibitDescriptionController = TextEditingController(
      text: widget.application.exhibitDescription,
    );

    selectedAddOns = List<String>.from(
      widget.application.addOns,
    );
  }

  Widget buildAddOnCheckbox(String addOn) {
    return CheckboxListTile(
      title: Text(addOn),
      value: selectedAddOns.contains(addOn),
      onChanged: (value) {
        setState(() {
          if (value == true) {
            selectedAddOns.add(addOn);
          } else {
            selectedAddOns.remove(addOn);
          }
        });
      },
    );
  }

  Future<void> updateApplication() async {
    await ApplicationService().updateApplicationDetails(
      applicationId: widget.application.id,
      companyDescription: companyDescriptionController.text.trim(),
      exhibitDescription: exhibitDescriptionController.text.trim(),
      addOns: selectedAddOns,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Application Updated',
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
          'Edit Application',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: companyDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Company Description',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: exhibitDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Exhibit Description',
              ),
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Additional Items',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: updateApplication,
                child: const Text(
                  'Update Application',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

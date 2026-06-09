import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/application_model.dart';
import '../../services/application_service.dart';

import 'edit_application_screen.dart';

class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({
    super.key,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;

      case 'Rejected':
        return Colors.red;

      case 'Cancelled':
        return Colors.grey;

      default:
        return Colors.orange;
    }
  }

  Future<void> cancelApplication({
    required BuildContext context,
    required String applicationId,
  }) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Cancel Application',
          ),
          content: const Text(
            'Are you sure you want to cancel this application?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                'No',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                'Yes',
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await ApplicationService().updateApplicationStatus(
        applicationId: applicationId,
        status: 'Cancelled',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Applications',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ApplicationModel>>(
        stream: ApplicationService().getMyApplications(
          userId,
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
                'No applications found',
              ),
            );
          }

          List<ApplicationModel> applications = snapshot.data!;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              ApplicationModel application = applications[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.companyName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        application.companyDescription,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        application.exhibitDescription,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Start Date: ${application.startDate}',
                      ),
                      Text(
                        'End Date: ${application.endDate}',
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add-ons: ${application.addOns.join(', ')}',
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(
                            application.status,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Text(
                          application.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (application.reason != null &&
                          application.reason!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Text(
                            'Reason: ${application.reason}',
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      const SizedBox(height: 15),
                      if (application.status == 'Pending')
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditApplicationScreen(
                                        application: application,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Edit Application',
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  cancelApplication(
                                    context: context,
                                    applicationId: application.id,
                                  );
                                },
                                child: const Text(
                                  'Cancel Application',
                                ),
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

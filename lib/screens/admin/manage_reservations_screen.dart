import 'package:flutter/material.dart';

import '../../models/application_model.dart';
import '../../services/application_service.dart';

class ManageReservationsScreen extends StatelessWidget {
  const ManageReservationsScreen({
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

  Future<void> deleteReservation({
    required BuildContext context,
    required String applicationId,
  }) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Reservation',
          ),
          content: const Text(
            'Are you sure you want to delete this reservation?',
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
      await ApplicationService().deleteApplication(
        applicationId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Reservations',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ApplicationModel>>(
        stream: ApplicationService().getApplications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No reservations found',
              ),
            );
          }

          List<ApplicationModel> applications = snapshot.data!;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              ApplicationModel app = applications[index];

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
                        app.companyName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        app.companyDescription,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        app.exhibitDescription,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Start Date: ${app.startDate}',
                      ),
                      Text(
                        'End Date: ${app.endDate}',
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add-ons: ${app.addOns.join(', ')}',
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(
                            app.status,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Text(
                          app.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (app.reason != null && app.reason!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Text(
                            'Reason: ${app.reason}',
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await ApplicationService()
                                    .updateApplicationStatus(
                                  applicationId: app.id,
                                  status: 'Approved',
                                );
                              },
                              child: const Text(
                                'Approve',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await ApplicationService()
                                    .updateApplicationStatus(
                                  applicationId: app.id,
                                  status: 'Rejected',
                                );
                              },
                              child: const Text(
                                'Reject',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await ApplicationService().updateApplicationStatus(
                              applicationId: app.id,
                              status: 'Cancelled',
                            );
                          },
                          child: const Text(
                            'Cancel Reservation',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            deleteReservation(
                              context: context,
                              applicationId: app.id,
                            );
                          },
                          child: const Text(
                            'Delete Reservation',
                          ),
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

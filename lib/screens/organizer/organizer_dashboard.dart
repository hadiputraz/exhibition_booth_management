import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

import '../auth/login_screen.dart';

import 'add_exhibition_screen.dart';
import 'application_management_screen.dart';
import 'manage_exhibitions_screen.dart';

class OrganizerDashboard extends StatelessWidget {
  const OrganizerDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Organizer Dashboard',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddExhibitionScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Add Exhibition',
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ManageOrganizerExhibitionsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'My Exhibitions',
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ApplicationManagementScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Manage Applications',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

import '../auth/login_screen.dart';

import 'select_exhibition_screen.dart';
import 'my_applications_screen.dart';

class ExhibitorDashboard extends StatelessWidget {
  const ExhibitorDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exhibitor Dashboard',
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
                      builder: (context) => const SelectExhibitionScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Browse Exhibitions',
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
                      builder: (context) => const MyApplicationsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'My Applications',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

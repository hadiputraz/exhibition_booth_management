import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

import '../auth/login_screen.dart';

import 'manage_exhibitions_screen.dart';
import 'manage_users_screen.dart';
import 'manage_reservations_screen.dart';
import 'manage_booths_screen.dart';
import 'floor_plan_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
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
                      builder: (context) => const ManageExhibitionsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Manage Exhibitions',
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
                      builder: (context) => const ManageUsersScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Manage Users',
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
                      builder: (context) => const ManageReservationsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Manage Reservations',
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
                      builder: (context) => const ManageBoothsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Manage Booths',
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
                      builder: (context) => const FloorPlanScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Floor Plan Management',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

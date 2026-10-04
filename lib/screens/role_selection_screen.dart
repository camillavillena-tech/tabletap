import 'package:flutter/material.dart';
import 'mobile_scanner.dart';

//import 'customer_home_screen.dart'; //unused as of the moment, but will be used in the future when the QR scanner is implemented

import 'staff_login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'TableTap',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF290E07),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'How would you like to continue?',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF290E07),
                ),
              ),
              const SizedBox(height: 32),

              _RoleCard(
                icon: Icons.restaurant,
                title: 'Customer',
                description: 'Browse the menu and place an order.',
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MobileScannerScreen(),
                  ),
                );
                },
              ),

              const SizedBox(height: 16),

              _RoleCard(
                icon: Icons.badge,
                title: 'Staff',
                description: 'Sign in and manage incoming orders.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const StaffLoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: const Color(0xFFAE3C00),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(description),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
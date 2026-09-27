import 'package:flutter/material.dart';

import 'screens/role_selection_screen.dart';
import 'theme.dart';

void main() {
  runApp(const TableTapApp());
}

class TableTapApp extends StatelessWidget {
  const TableTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableTap',
      debugShowCheckedModeBanner: false,
      theme: tableTapTheme,
      home: const RoleSelectionScreen(),
    );
  }
}
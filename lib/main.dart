import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MscpConnectApp());
}

class MscpConnectApp extends StatelessWidget {
  const MscpConnectApp({super.key});

  static const Color primaryBlue = Color(0xFF0B4A82);
  static const Color accentBlue = Color(0xFF1976D2);
  static const Color background = Color(0xFFF5F7FA);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MSCP Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          primary: primaryBlue,
          secondary: accentBlue,
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: false,
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

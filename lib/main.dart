import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'backend/services/auth_service.dart';
import 'pages/homepage.dart';
import 'pages/login_page.dart';
import 'pages/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SQLite for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory for desktop platforms
    databaseFactory = databaseFactoryFfi;
  }

  // Check if the user is logged in
  final authService = AuthService();
  final isLoggedIn = await authService.isLoggedIn();

  // Check if it's the first launch
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('first_launch') ?? true;

  runApp(MyApp(isFirstLaunch: isFirstLaunch, isLoggedIn: isLoggedIn));

  // Set first launch to false after app starts
  if (isFirstLaunch) {
    await prefs.setBool('first_launch', false);
  }
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.isFirstLaunch,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sankalp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: const Color(0xFF39AC9E),
      ),
      // If logged in, go to home; otherwise start with login
      home: isLoggedIn ? const MyHomePage(title: 'Sankalp') : const LoginPage(),
      routes: {
        '/home': (context) => const MyHomePage(title: 'Sankalp'),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
      },
    );
  }
}

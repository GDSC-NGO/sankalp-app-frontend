import 'package:flutter/material.dart';
import 'package:sankalp/component/bottomnavbar.dart';
import 'package:sankalp/component/ngocard.dart';
import 'package:sankalp/component/homesearchbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // App header with title and profile icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sankalp',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  CircleAvatar(backgroundColor: Colors.grey[300], radius: 20),
                ],
              ),
              const SizedBox(height: 16),
              // Search bar
              HomeSearchBar(),
              const SizedBox(height: 24),
              // NGOs near you title
              const Text(
                "Ngo's near you",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A4A4A),
                ),
              ),
              const SizedBox(height: 16),
              // NGO listing (scrollable)
              Expanded(
                child: ListView(
                  children: const [
                    NGOCard(name: "Ngo name 1", rating: 4.0),
                    SizedBox(height: 16),
                    NGOCard(name: "Ngo name 2", rating: 4.0),
                    SizedBox(height: 16),
                    NGOCard(name: "Ngo name 3", rating: 4.2),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}

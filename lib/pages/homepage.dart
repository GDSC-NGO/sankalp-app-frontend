import 'package:flutter/material.dart';
import 'package:sankalp/component/bottomnavbar.dart';
import 'package:sankalp/component/ngocard.dart';

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
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(Icons.search, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      "Search for NGO's",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              ),
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



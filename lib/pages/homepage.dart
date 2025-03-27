import 'package:flutter/material.dart';
import 'package:sankalp/component/bottomnavbar.dart';
import 'package:sankalp/component/ngocard.dart';
import 'package:sankalp/component/homesearchbar.dart';
import 'package:sankalp/component/custom_button.dart';

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
      body: Column(
        children: [
          // Top colored section
          Container(
            color: const Color(0xFF39AC9E),
            width: double.infinity,
            child: SafeArea(
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
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    HomeSearchBar(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          // Rest of the content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  // NGO listing (scrollable)
                  Expanded(
                    child: ListView(
                      children: const [
                        NGOCard(
                          name: "Baburao Foundation",
                          location: "Mulund, Mumbai",
                        ),
                        SizedBox(height: 16),
                        NGOCard(
                          name: "Gadekar Community",
                          location: "GTB Nagar, Mumbai",
                        ),
                        SizedBox(height: 16),
                        NGOCard(
                          name: "Bapuli and Sons",
                          location: "kandivali, Mumbai",
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  // Add a login/register button at the bottom
                  // CustomButton(
                  //   text: 'Login / Register',
                  //   onPressed: () {
                  //     Navigator.pushReplacementNamed(context, '/login');
                  //   },
                  // ),
                  const SizedBox(height: 16), // Add spacing below the button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86, // Increased height to fix the overflow
      decoration: const BoxDecoration(
        color: Color(
          0xFF616161,
        ), // Equivalent constant color for Colors.grey[700]
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: ClipRRect(
        child: BottomNavigationBar(
          selectedItemColor: Color(0xFF39AC9E),
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Colors.white,
          elevation: 0, // Remove default shadow
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

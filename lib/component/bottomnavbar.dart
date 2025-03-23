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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.grey[700],
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Color(0xFFC0C0C0),
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

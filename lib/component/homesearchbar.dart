import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for NGO's",
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

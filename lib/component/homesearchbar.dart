import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for NGO's",
          hintStyle: TextStyle(color: Color(0xFFA0A0A0), fontSize: 18),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Color(0xFFA0A0A0), size: 28),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

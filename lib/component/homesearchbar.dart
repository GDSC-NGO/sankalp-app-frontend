import 'package:flutter/material.dart';
import '../backend/repositories/ngo_repository.dart';

class HomeSearchBar extends StatelessWidget {
  final Function(String)? onSearch;

  const HomeSearchBar({
    super.key,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    final NGORepository _ngoRepository = NGORepository();

    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: "Search for NGO's",
          hintStyle: TextStyle(color: Color(0xFFA0A0A0), fontSize: 18),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Color(0xFFA0A0A0), size: 28),
          contentPadding: EdgeInsets.symmetric(vertical: 14),
          suffixIcon: Icon(Icons.mic, color: Color(0xFFA0A0A0)),
        ),
        style: const TextStyle(color: Colors.black, fontSize: 16),
        onSubmitted: (value) {
          // Call the provided onSearch callback if available
          if (onSearch != null) {
            onSearch!(value);
          }
        },
        textInputAction: TextInputAction.search,
      ),
    );
  }
}

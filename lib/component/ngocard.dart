import 'package:flutter/material.dart';

class NGOCard extends StatelessWidget {
  final String name;
  final String location;

  const NGOCard({super.key, required this.name, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              // Changed to Row to place avatar on the left
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CircleAvatar on the left
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[400],
                  // You can add an image here if needed:
                  // backgroundImage: NetworkImage('url_to_ngo_logo'),
                ),
                const SizedBox(width: 16), // Space between avatar and text
                // Column for name and location information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NGO name and rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4A4A4A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
